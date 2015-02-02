<?php
namespace Cities\Models;

use Phalcon\Mvc\Model;

/**
 * Cities\Models\Profiles
 * All the profile levels in the application. Used in conjenction with ACL lists
 */
class CapResources extends Model
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
     * Define relationships to Users and Permissions
     */
    public function initialize()
    {
        $this->setSource("cap_resources");
    }

}
