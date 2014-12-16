<?php
namespace Cities\Models;

use Phalcon\Mvc\Model;

/**
 * Cities\Models\Profiles
 * All the profile levels in the application. Used in conjenction with ACL lists
 */
class Buildings extends Model
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
     * cityID
     * @var integer
     */
    public $city_id;

    /**
     * Shop item Id
     * @var integer
     */
    public $shop_item_id;

    /**
     * Upgrade
     * @var integer
     */
    public $upgrade;

    /**
     * X
     * @var integer
     */
    public $x;

    /**
     * y
     * @var integer
     */
    public $y;

    /**
     * Health
     * @var integer
     */
    public $health;

    /**
     * Created at
     * @var timestamp
     */
    public $created_at;

    /**
     * Define relationships to Users and Permissions
     */
    public function initialize()
    {
        $this->setSource("buildings");
    }

    /**
     * Get the city data from database
     */
    public function getCordinates()
    {
        return array('x' => $this->x, 'y' => $this->y);
    }
}
