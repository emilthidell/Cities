<?php
namespace Cities\Models;

use Phalcon\Mvc\Model;

/**
 * Cities\Models\Profiles
 * All the profile levels in the application. Used in conjenction with ACL lists
 */
class Resources extends Model
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
     * Stone
     * @var integer
     */
    public $stone;

    /**
     * wood
     * @var integer
     */
    public $wood;

    /**
     * food
     * @var integer
     */
    public $food;

    /**
     * gold
     * @var integer
     */
    public $gold;

    /**
     * Last fillup
     * @var timestamp
     */
    public $last_fillup;

    /**
     * Fillup interval
     * @var integer
     */
    public $fillup_interval;

    /**
     * Define relationships to Users and Permissions
     */
    public function initialize()
    {
        $this->setSource("resources");
    }

}
