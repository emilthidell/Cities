<?php
namespace Cities\Controllers;

use Phalcon\Tag;
use Phalcon\Mvc\Model\Criteria;
use Cities\Models\Users;
use Cities\Models\Cities;
use Cities\Models\Buildings;
use Cities\Models\Characters;
use Cities\Models\Shop;

/**
 * Cities\Controllers\UsersController
 * CRUD to manage users
 */
class CitiesController extends ControllerBase
{

    private $currentUserId;

    public function initialize()
    {
        $currentUser = $this->auth->getIdentity();

        $this->currentUserId = $currentUser['id'];

        $loginState = 0;

        if(is_array($currentUser)){
            $loginState = 1;

            $cities = Cities::find("user_id = ".$currentUser['id']);

            if(count($cities) <= 1){
                $this->view->setVar('current_city', $cities[0]->id);
            }

            $this->view->setVar('logged_in', $loginState);
            $this->view->setVar('cities', $cities);
            $this->view->setVar('num_cities', count($cities));

        }

    }

    /**
     * Default action, shows all your cities
     */
    public function indexAction()
    {

        $this->view->setTemplateBefore('private');
    }

    /**
     * Show city action, shows a specific city
     */
    public function mapAction($id)
    {
        $this->view->cache(false);

        if(strtolower($id) == 'world'){
            $this->worldMapAction;
        }else{
            $city = Cities::findFirst('id = '.$id);

            $mapStateSettings = $this->config->mapStates;

            $mapState = '';

            foreach($mapStateSettings as $key => $value)
            {
                if($key == $city->state)
                {
                    $mapState = $value;
                }
            }

            $parsedBuildings = array();

            $buildings = $this->getBuildings($id);

            if(count($buildings) > 0)
            {

                foreach($buildings as $buildingId => $building)
                {
                    $buildingProperties = $this->getShopItem($building->shop_item_id);

                    $parsedBuilding = new \stdClass();
                    $parsedBuilding->id              = $building->id;
                    $parsedBuilding->shop_item_id    = $buildingProperties->id;
                    $parsedBuilding->type            = $buildingProperties->type;
                    $parsedBuilding->title           = $buildingProperties->title;
                    $parsedBuilding->width           = $buildingProperties->width;
                    $parsedBuilding->length          = $buildingProperties->length;
                    $parsedBuilding->attributes      = json_decode($buildingProperties->attributes);
                    $parsedBuilding->price           = json_decode($buildingProperties->price);
                    $parsedBuilding->resource_folder = $buildingProperties->resource_folder;
                    $parsedBuilding->left            = $building->x;
                    $parsedBuilding->top             = $building->y;
                    $parsedBuilding->upgrade         = $building->upgrade;
                    $parsedBuilding->health          = $building->health;

                    $parsedBuildings[] = $parsedBuilding;
                }
            }

            $parsedCharacters = array();

            $characters = $this->getCharacters($id);

            if(count($characters) > 0)
            {
                    foreach($characters as $characterId => $character)
                    {
                        $characterCity = Cities::findFirst('id = '.$character->city_id);

                        $characterMapState = '';

                        foreach($mapStateSettings as $key => $value)
                        {
                            if($key == $characterCity->state)
                            {
                                $characterMapState = $value;
                            }
                        }

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
            }

            $this->view->setVar('city',       $city);
            $this->view->setVar('characters', $parsedCharacters);
            $this->view->setVar('buildings',  $parsedBuildings);
            $this->view->setVar('mapFolder',  strtolower(str_replace(' ','', $mapState)));
            $this->view->setTemplateBefore('city');
        }
    }

    /**
     * Show the world map
     */
    public function worldMapAction()
    {
        $cities = Cities::find();

        $parsedCities = array();

        foreach($cities as $city){

            $parsedCity = new \stdClass();
            $parsedCity->id      = $city->id;
            $parsedCity->preview = $city->id;
            $parsedCity->x       = $city->x;
            $parsedCity->y       = $city->y;
            $parsedCity->title   = $city->title;
            $parsedCity->user_id = $city->user_id;

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
        $this->view->setTemplateBefore('worldmap');
    }

    /**
     * Show building action, shows a specific building from a city
     */
    public function buildingAction($id)
    {
        $building = Buildings::findFirst('id = '.$id);

        $this->view->setVar('building', $building);
        $this->view->setVar('mapFolder', strtolower(str_replace(' ','', $mapState)));
        $this->view->setTemplateBefore('city');
    }

    /**
     * Fetch all the buildings for the city
     */
    private function getBuildings($id)
    {
        return Buildings::find("city_id = ".$id." AND user_id = ".$this->currentUserId." AND destroyed = 0");
    }

    /**
     * Fetch all the characters for the city
     */
    private function getCharacters($id)
    {
        return Characters::find("current_city_id = ".$id." AND user_id = ".$this->currentUserId." AND dead = 0");
    }

    /**
     * Fetch the building properties
     */
    private function getShopItem($id)
    {
        return Shop::findFirst($id);
    }

}
