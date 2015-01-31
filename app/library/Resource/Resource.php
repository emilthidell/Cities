<?php
namespace Cities\Resource;

use Cities\Models\Resources;

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

        $diff = date_diff($nowDateTime, $lastFillupDateTime);
        $minutesDiff = ($diff->y*256*24*60)+($diff->m*30*24*60)+($diff->d*24*60)+($diff->h*60)+($diff->i)+($diff->s/60);
        $numFillups = floor((int)$minutesDiff/$this->resources->fillup_interval);
        $numFillupMinutes = $numFillups*$this->resources->fillup_interval;;

        $newFillupDate = date('Y-m-d h:i:s'); // TODO: Change to real fillup date later, could not figure out how to add minutes to dateTime

        $newResources = array(
            'stone'       => 20,
            'wood'        => 30,
            'food'        => 20,
            'gold'        => 0,
            'last_fillup' => $newFillupDate
        );

        $this->update($newResources);
    }

    /**
     * Update resources
     *
     * @param  object $resources
     * @return boolean
     */
    private function update($newResources)
    {
        $this->resources->assign($newResources);

        if(!$this->resources->save()){
            echo 'Failed update resources for user ID: '.$identity['id'];
            var_dump($this->resources->getMessages());
            die();
        }
    }

}
