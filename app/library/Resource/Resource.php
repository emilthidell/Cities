<?php
namespace Cities\Resource;

use Cities\Models\Resources;
use Cities\Models\CapResources;
use Cities\Models\Buildings;
use Cities\Models\Shop;

class Resource
{
    public $resources;

    private $config;

    private $userId;

    /**
     * Construct
     */
    public function __construct($resources, $config, $userId)
    {
        $this->resources = $resources;
        $this->config    = $config;
        $this->userId    = $userId;
    }

    /**
     * Create resources
     */
    public function create()
    {
        $startResources = $this->config->startResources;

        $initResources = new Resources();
        $initResources->stone           = $startResources['stone'];
        $initResources->wood            = $startResources['wood'];
        $initResources->food            = $startResources['food'];
        $initResources->gold            = $startResources['gold'];
        $initResources->last_fillup     = date('Y-m-d h:i:s');
        $initResources->fillup_interval = $startResources['fillup_interval'];
        $initResources->user_id         = $this->userId;

        if(!$initResources->save()){
            echo 'Failed create resources for user ID: '.$this->userId;
            var_dump($initResources->getMessages());
            die();
        }
    }

    /**
     * Fillup resources
     */
    public function fillup()
    {
        $nowDateTime        = new \dateTime(date('Y-m-d h:i:s'));
        $lastFillupDateTime = new \dateTime($this->resources->last_fillup);
        $lastFillup         = $this->resources->last_fillup;

        $diff = date_diff($nowDateTime, $lastFillupDateTime);
        $minutesDiff = ($diff->y*256*24*60)+($diff->m*30*24*60)+($diff->d*24*60)+($diff->h*60)+($diff->i)+($diff->s/60);
        $numFillups = floor((int)$minutesDiff/$this->resources->fillup_interval);
        $numFillupMinutes = $numFillups*$this->resources->fillup_interval;;

        $lastFillup = strtotime($lastFillup);
        $futureDate = $lastFillup+(60*$numFillupMinutes);
        $newFillupDate = date("Y-m-d H:i:s", $futureDate);

        $addResources     = $this->getNewResources($numFillups);
        $currentResources = $this->getCurrentResources();

        $newResources = @array(
            'stone'       => (int)$currentResources['stone']+(int)$addResources['stone'],
            'wood'        => (int)$currentResources['wood']+(int)$addResources['wood'],
            'food'        => (int)$currentResources['food']+(int)$addResources['food'],
            'gold'        => (int)$currentResources['gold']+(int)$addResources['gold'],
            'last_fillup' => $newFillupDate
        );

        $this->update($newResources);
    }

    /**
     * Get new resources
     *
     * @param  integer $numFillups
     * @return array
     */
    private function getNewResources($numFillups)
    {
        $addResources = array();
        $buildings = Buildings::find('user_id = '.$this->userId);
        foreach($buildings as $building){

            $buildingProperties = Shop::findFirst($building->shop_item_id);
            $attributes = json_decode($buildingProperties->attributes);
            foreach($attributes as $resource => $attribute){
                if(!isset($addResources[$resource])){
                    $addResources[$resource] = 0;
                }
                $addResources[$resource] += $attribute*$numFillups;
            }
        }
        return $addResources;
    }

    /**
     * Get current resources
     *
     * @return array
     */
    private function getCurrentResources()
    {
        $currentResources = array();
        $resources = Resources::findFirst('user_id = '.$this->userId);
        $currentResources['stone'] = $resources->stone;
        $currentResources['wood'] = $resources->wood;
        $currentResources['food'] = $resources->food;
        $currentResources['gold'] = $resources->gold;
        return $currentResources;
    }

    /**
     * Cap the resources at the maximum limit
     *
     * @return void
     */
    private function capResources($currentResources)
    {

        $resourceList = array('stone','wood','food','gold');

        $newResources = array();

        $capResources = CapResources::findFirst('user_id = '.$this->userId);
        foreach($capResources as $resource => $capResource){
            if(in_array($resource, $resourceList)){
                if($currentResources[$resource] > $capResource){
                    $newResources[$resource] = $capResource;
                }else{
                    $newResources[$resource] = $currentResources[$resource];
                }
            }
        }

        return $newResources;
    }

    /**
     * Update resources
     *
     * @param  object $resources
     * @return boolean
     */
    private function update($newResources)
    {
        $newResources = $this->capResources($newResources);
        
        $this->resources->assign($newResources);

        if(!$this->resources->save()){
            echo 'Failed update resources for user ID: '.$identity['id'];
            var_dump($this->resources->getMessages());
            die();
        }
    }

}
