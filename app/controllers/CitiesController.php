<?php
namespace Cities\Controllers;

use Phalcon\Tag;
use Phalcon\Mvc\Model\Criteria;
use Cities\Models\Users;
use Cities\Models\Cities;
use Cities\Models\Buildings;
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
        }

        $cities = Cities::find("user_id = ".$currentUser['id']);

        if(count($cities) <= 1){
            $this->view->setVar('current_city', $cities[0]->id);
        }

        $this->view->setVar('logged_in', $loginState);
        $this->view->setVar('cities', $cities);
        $this->view->setVar('num_cities', count($cities));
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

        $buildings = $this->getBuildings($id);

        foreach($buildings as $id => $building)
        {
            $buildingProperties = $this->getBuildingProperties($building->shop_item_id);

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

        $this->view->setVar('city',      $city);
        $this->view->setVar('city',      $city);
        $this->view->setVar('buildings', $parsedBuildings);
        $this->view->setVar('mapFolder', strtolower(str_replace(' ','', $mapState)));
        $this->view->setTemplateBefore('city');
    }

    /**
     * Show building action, shows a specific building from a city
     */
    public function buildingAction($id)
    {
        $city = Cities::findFirst('id = '.$id);

        $mapStateSettings = $this->config->mapStates;

        $mapState = '';

        foreach($mapStateSettings as $key => $value){
            if($key == $city->state){
                $mapState = $value;
            }
        }

        $this->view->setVar('city', $city);
        $this->view->setVar('mapState', $mapState);
        $this->view->setVar('mapFolder', strtolower(str_replace(' ','', $mapState)));
        $this->view->setTemplateBefore('city');
    }

    /**
     * Fetch all the buildings for the city
     */
    private function getBuildings($id)
    {
        return Buildings::find("city_id = ".$id." AND user_id = ".$this->currentUserId);
    }

    /**
     * Fetch the building properties
     */
    private function getBuildingProperties($id)
    {
        return Shop::findFirst($id);
    }

}
