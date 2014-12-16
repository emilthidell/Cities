<?php
namespace Cities\Models;

use Phalcon\Mvc\Model;

/**
 * Cities\Models\Profiles
 * All the profile levels in the application. Used in conjenction with ACL lists
 */
class Cities extends Model
{

    /**
     * ID
     * @var integer
     */
    public $id;

    /**
     * userID
     * @var integer
     */
    public $user_id;

    /**
     * Name
     * @var string
     */
    public $title;

    /**
     * State
     * @var integer
     */
    public $state;

    /**
     * Data
     * @var blob
     */
    public $data;

    /**
     * Define relationships to Users and Permissions
     */
    public function initialize()
    {
        $this->setSource("cities");
    }

    /**
     * Get the city data from database
     */
    public function getData()
    {
        return $this->data;
    }
}
