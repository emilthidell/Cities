<?php
namespace Cities\Controllers;

use Phalcon\Tag;
use Phalcon\Mvc\Model\Criteria;
use Cities\Models\Users;
use Cities\Models\Cities;
use Cities\Models\Buildings;
use Cities\Models\Characters;
use Cities\Models\Shop;
use Cities\Models\Allies;
use Cities\Models\Resources;

use Cities\Guide\Guide;

/**
 * Cities\Controllers\UsersController
 * CRUD to manage users
 */
class CitiesController extends ControllerBase
{

    private $currentUserId;

    public function initialize()
    {

        $currentUser = $this->checkAuth();

        if(is_array($currentUser)){

            $this->currentUserId = $currentUser['id'];

            $cities = Cities::find("user_id = ".$currentUser['id']);

            if(count($cities) == 0){

                $city = new Cities();
                $city->user_id     = $this->currentUserId;
                $city->x           = rand(50,950);
                $city->y           = rand(50,550);
                $city->state       = 0;
                $city->environment = 'forest';
                $city->layer       = 'grass';
                $city->data        = '';
                $city->tiles       = '[[0,0,1,0,1,0,1,0,1,0],[0,1,1,1,1,1,1,1,1,0],[0,2,1,1,1,3,1,1,1,0],[0,1,1,1,1,1,1,1,1,0],[0,1,1,1,1,1,1,1,1,0],[0,1,1,1,1,4,1,1,1,0],[0,1,0,1,0,1,0,1,0,0]]';
                $city->created_at  = date("Y-m-d H:i:s");
                $city->updated_at  = date("Y-m-d H:i:s");
                $city->title       = 'Your first city';
                if(!$city->save()){
                    echo "Error creating the city";
                    var_dump($city->getMessages());
                    die();
                }

                $home = new Buildings();
                $home->user_id      = $this->currentUserId;
                $home->city_id      = $city->id;
                $home->shop_item_id = 1;
                $home->x            = 392;
                $home->y            = 125;
                $home->upgrade      = 1;
                $home->health       = 100;
                $home->created_at   = date('Y-m-d h:i:s');
                $home->destroyed    = 0;
                if(!$home->save()){
                    echo "Error creating the home";
                    var_dump($home->getMessages());
                    die();
                }

                $character = new Characters();
                $character->user_id         = $this->currentUserId;
                $character->city_id         = $city->id;
                $character->current_city_id = $city->id;
                $character->title           = 'John Doe';
                $character->x               = 464;
                $character->y               = 256;
                $character->attributes      = '{}';
                $character->health          = 100;
                $character->created_at      = date('Y-m-d h:i:s');
                $character->updated_at      = date('Y-m-d h:i:s');
                $character->dead            = 0;
                if(!$character->save()){
                    echo "Error creating the character";
                    var_dump($character->getMessages());
                    die();
                }

            }

            if(count($cities) <= 1){
                $this->view->setVar('current_city', $cities[0]->id);
            }
            $this->view->setVar('cities', $cities);
            $this->view->setVar('num_cities', count($cities));

        }

    }

    /**
     * Check the user auth
     */
    public function checkAuth(){
        $loginState = 0;
        if(is_array($this->auth->getIdentity())){

            $currentUser = $this->auth->getIdentity();

            $this->currentUserId = $currentUser;

            $loginState = 1;

            $cities = Cities::find("user_id = ".$currentUser['id']);

            if(count($cities) == 1){
                $this->view->setVar('current_city', $cities[0]->id);
            }

            $this->view->setVar('num_cities', count($cities));
        }else{
            $currentUser = 0;
        }
        $this->view->setVar('logged_in', $loginState);

        return $currentUser;
    }

    /**
     * Default action, shows all your cities
     */
    public function indexAction()
    {
        $userCities = Cities::find('user_id = '.$this->currentUserId);
        $this->view->setTemplateBefore('private');
        $this->view->setVar('resources'  , $this->getResources($this->currentUserId));
    }

    /**
     * Show city action, shows a specific city
     */
    public function mapAction($cityId)
    {
        $this->view->cache(false);

        $guideModel = new Guide($this->currentUserId);
        $guideMessages = $guideModel->getMessages();
        $this->view->setVar('guide', $guideMessages);

        if(strtolower($cityId) == 'world')
        {
            $this->worldMapAction;
        }else{

            $accessGranted = 1;
            $allied        = 0;

            $userCities = Cities::find('user_id = '.$this->currentUserId);

            foreach($userCities as $userCity)
            {
                if($userCity->id == $cityId)
                {
                    $accessGranted = 1;
                }
            }

            $city = $this->getCity($cityId);

            $tilesTypes = $this->config->mapTiles;

            $city->htmlTiles = '';

            $city->tiles = json_decode($city->tiles);

            foreach($city->tiles as $x => $cityYArray){
                foreach($cityYArray as $y => $tile){

                    $outputTileStyle = "";
                    $tileLeft        = $x*141;
                    $tileTop         = $y*35;
                    $tileZIndex      = $y;
                    $cityTileClass   = 'cityTile';
                    if($tile === 0){
                        $cityTileClass .= ' clickable glassTile hiddenTile';
                    }
                    if ($y % 2) { $tileLeft = $tileLeft-(70.5); }

                    if($tilesTypes[$tile]){

                        $transition = '';
                        $transitionCount = 0;

                        $outputTileStyle = ' style="left:'.$tileLeft.'px;top:'.$tileTop.'px;background:url(/img/tiles/'.$tilesTypes[$tile].'.png);z-index:'.$tileZIndex.'"';
                        if(isset($cityTiles[$x][$y-1]) === true && $tile != $cityTiles[$x][$y-1]){
                            $transition .= '<div class="transitionTopLeft" style="background:url(/img/tiles/transitions/'.$tilesTypes[$tile].'-'.$tilesTypes[$cityTiles[$x][$y-1]].'-topleft.png)"></div>';
                            $transitionCount++;
                        }
                        if(isset($cityTiles[$x+1][$y-1]) === true && $tile != $cityTiles[$x+1][$y-1]){
                            $transition .= '<div class="transitionTopRight" style="background:url(/img/tiles/transitions/'.$tilesTypes[$tile].'-'.$tilesTypes[$cityTiles[$x+1][$y-1]].'-topright.png)"></div>';
                            $transitionCount++;
                        }
                        if(isset($cityTiles[$x+1][$y+1]) === true && $tile != $cityTiles[$x+1][$y+1]){
                            $transition .= ",bottomright";
                            $transitionCount++;
                        }
                        if(isset($cityTiles[$x][$y+1]) === true && $tile != $cityTiles[$x][$y+1]){
                            $transition .= ",bottomleft";
                            $transitionCount++;
                        }
                        if($transitionCount > 1){
                            $transition = '';
                        }
                    }

                    $city->htmlTiles .= '<div class="'.$cityTileClass.'"'.$outputTileStyle.' data-x="'.$x.'" data-y="'.$y.'">'.$transition.'</div>';
                }
                $tileLeft = 0;
            }

            if(!$accessGranted){
                $allied = $this->isUserAlly($city); // No need to do this if we're already granted access
            }

            $mapState = $this->getMapState($cityId);

            $parsedBuildings = array();
            $buildings       = $this->getBuildings($cityId);
            $parsedBuildings = $this->parseBuildingsObject($buildings);

            $parsedCharacters = array();
            $characters       = $this->getCharacters($cityId);
            $parsedCharacters = $this->parseCharactersObject($characters);

            $this->view->setVar('city'       , $city);
            $this->view->setVar('mapMode'    , 'map');
            $this->view->setVar('allied'     , $accessGranted);
            $this->view->setVar('resources'  , $this->getResources($this->currentUserId));
            $this->view->setVar('characters' , $parsedCharacters);
            $this->view->setVar('buildings'  , $parsedBuildings);
            $this->view->setVar('mapFolder'  , strtolower(str_replace(' ','', $mapState)));

            $this->view->setTemplateBefore('city');
        }
    }

    /**
     * Show the world map
     */
    public function worldMapAction()
    {
        $guideModel    = new Guide($this->currentUserId);
        $guideMessages = $guideModel->getMessages();
        $this->view->setVar('guide', $guideMessages);

        $cities = Cities::find();

        $parsedCities = array();

        foreach($cities as $city){

            $parsedCity = new \stdClass();
            $parsedCity->id          = $city->id;
            $parsedCity->preview     = $city->id;
            $parsedCity->x           = $city->x;
            $parsedCity->y           = $city->y;
            $parsedCity->title       = $city->title;
            $parsedCity->layer       = $city->layer;
            $parsedCity->environment = $city->environment;
            $parsedCity->tiles       = $city->tiles;
            $parsedCity->user_id     = $city->user_id;

            $extra = "";
            if($city->user_id == $this->currentUserId){
                $extra = "home";
            }

            $checkPreviewImage = @file_get_contents('img/previews/'.$city->id.'.png');

            if(!$checkPreviewImage){
                $parsedCity->preview = '0';
            }
            $parsedCity->extra   = $extra;

            $parsedCities[] = $parsedCity;
        }

        $this->view->setVar('cities', $parsedCities);
        $this->view->setVar('resources'  , $this->getResources($this->currentUserId));

        $this->view->setTemplateBefore('worldmap');
    }

    /**
     * Get the Map state
     */
    public function getMapState($cityId)
    {

        $city = Cities::findFirst('id = '.$cityId);

        $mapStateSettings = $this->config->mapStates;

        $mapState = '';

        foreach($mapStateSettings as $key => $value)
        {
            if($key == $city->state)
            {
                $mapState = $value;
            }
        }

        return $mapState;
    }

    /**
     * Show building action, shows a specific building from a city
     */
    public function buildingAction($cityId, $buildingId)
    {
        $this->mapAction($cityId);

        $building         = $this->getBuilding($buildingId);
        $parsedBuilding   = $this->parseBuildingsObject($building);

        if(count($parsedBuilding) == 1){
            $parsedBuilding = $parsedBuilding[0];
        }

        if($parsedBuilding->health > 70){
            $parsedBuilding->healthStatus = 'progress-bar-success';
        }elseif($parsedBuilding->health <= 70){
            $parsedBuilding->healthStatus = 'progress-bar-warning';
        }elseif($parsedBuilding->health < 30){
            $parsedBuilding->healthStatus = 'progress-bar-danger';
        }

        $this->view->setVar('building'  , $parsedBuilding);
        $this->view->setVar('mapMode'   , 'building');
        $this->view->setVar('resources'  , $this->getResources($this->currentUserId));

        $this->view->setTemplateBefore('city');

    }

    /**
     * Get all the buildings for the specific city
     */
    private function isUserAlly($userId)
    {

        $allies = $this->getAllies($this->currentUserId);

        foreach($allies as $ally){
            if($ally->ally_id == $userId){
                return true;
            }
        }

        return array();
    }

    /**
     * Get all the buildings for the specific city
     */
    private function getAllies()
    {
        return Allies::find("user_id = ".$this->currentUserId." AND response != ''"); // Get all accepted allies
    }

    /**
     * Get a specific city
     */
    private function getCity($cityId)
    {
        return Cities::findFirst('id = '.$cityId);
    }

    /**
     * Get all the buildings for the specific city
     */
    private function getBuildings($buildingId)
    {
        return Buildings::find("city_id = ".$buildingId." AND destroyed = 0");
    }

    /**
     * Get all the buildings for the specific city
     */
    private function getBuilding($buildingId)
    {
        return Buildings::find("id = ".$buildingId);
    }

    /**
     * Get all the characters for the city
     */
    private function getCharacters($id)
    {
        return Characters::find("current_city_id = ".$id." AND dead = 0");
    }

    /**
     * Get the building properties
     */
    private function getShopItem($shopItemId)
    {
        return Shop::findFirst($shopItemId);
    }

    /**
     * Get the resources
     */
    private function getResources($userId)
    {
        return Resources::findFirst('user_id = '.$userId);
    }

    /**
     * Parse the Characters object for the view
     */
    private function parseBuildingsObject($buildings)
    {
        if(count($buildings) > 0)
        {

            foreach($buildings as $building)
            {

                $buildingProperties = $this->getShopItem($building->shop_item_id);

                $parsedBuilding = new \stdClass();
                $parsedBuilding->id              = $building->id;
                $parsedBuilding->shop_item_id    = $buildingProperties->id;
                $parsedBuilding->type            = $buildingProperties->type;
                $parsedBuilding->title           = $buildingProperties->title;
                $parsedBuilding->width           = $buildingProperties->width;
                $parsedBuilding->length          = $buildingProperties->length;
                $parsedBuilding->description     = $buildingProperties->description;
                $parsedBuilding->attributes      = json_decode($buildingProperties->attributes);
                $parsedBuilding->price           = json_decode($buildingProperties->price);
                $parsedBuilding->resource_folder = $buildingProperties->resource_folder;
                $parsedBuilding->left            = $building->x;
                $parsedBuilding->top             = $building->y;
                $parsedBuilding->upgrade         = $building->upgrade;
                $parsedBuilding->health          = $building->health;

                $parsedBuilding->attributesHtml = $this->parseBuildingAttributesToHtml($parsedBuilding->attributes);

                $parsedBuildings[] = $parsedBuilding;
            }
            return $parsedBuildings;
        }
        return array();
    }

    /**
     * Parse the Characters object for the view
     */
    private function parseCharactersObject($characters)
    {
        if(count($characters) > 0)
        {
                foreach($characters as $characterId => $character)
                {
                    $characterCity = Cities::findFirst('id = '.$character->city_id);

                    $characterMapState = $this->getMapState($character->city_id);

                    $parsedCharacter = new \stdClass();
                    $parsedCharacter->id              = $character->id;
                    $parsedCharacter->city_id         = $character->city_id;
                    $parsedCharacter->current_city_id = $character->current_city_id;
                    $parsedCharacter->title           = $character->title;
                    $parsedCharacter->state           = strtolower(str_replace(' ','', $characterMapState));
                    $parsedCharacter->left            = $character->x;
                    $parsedCharacter->top             = $character->y;
                    $parsedCharacter->attributes      = json_decode($character->attributes);
                    $parsedCharacter->health          = $character->health;

                    $parsedCharacters[] = $parsedCharacter;

                }
                return $parsedCharacters;
        }
        return array();
    }

    /**
     * Parse the Building attributes of a building attributes obect
     */
    private function parseBuildingAttributesToHtml($attributes)
    {
        $anything = 0;

        $attributesHtml = "";

        if(isset($attributes->wood)){
            if($attributes->wood > 0){
                $anything = 1;
                $attributesHtml .= '<li class="add"><span class="resource-wood"></span> +'.$attributes->wood.'</li>';
            }elseif($attributes->wood < 0){
                $anything = 1;
                $attributesHtml .= '<li class="sub"><span class="resource-wood"></span> -'.$parsedBuilding->attributes->wood.'</li>';
            }
        }
        if(isset($attributes->stone)){
            if($attributes->stone > 0){
                $anything = 1;
                $attributesHtml .= '<li class="add"><span class="resource-stone"></span> +'.$attributes->stone.'</li>';
            }elseif($attributes->stone < 0){
                $anything = 1;
                $attributesHtml .= '<li class="sub"><span class="resource-stone"></span> -'.$parsedBuilding->attributes->stone.'</li>';
            }
        }
        if(isset($attributes->food)){
            if($attributes->food > 0){
                $anything = 1;
                $attributesHtml .= '<li class="add"><span class="resource-food"></span> +'.$attributes->food.'</li>';
            }elseif($attributes->food < 0){
                $anything = 1;
                $attributesHtml .= '<li class="sub"><span class="resource-food"></span> -'.$parsedBuilding->attributes->food.'</li>';
            }
        }
        if(isset($attributes->gold)){
            if($attributes->gold > 0){
                $anything = 1;
                $attributesHtml .= '<li class="add"><span class="resource-gold"></span> +'.$attributes->gold.'</li>';
            }elseif($attributes->gold < 0){
                $anything = 1;
                $attributesHtml .= '<li class="sub"><span class="resource-gold"></span> -'.$parsedBuilding->attributes->gold.'</li>';
            }
        }

        if($anything){
            $attributesHtml = "<h4>Daily resources from this building</h4><ul class='buildingAttributes'>".$attributesHtml."</ul>";
        }else{
            $attributesHtml = "<i>No daily resources from this building</i>";
        }

        return $attributesHtml;
    }


}
