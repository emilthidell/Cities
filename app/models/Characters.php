<?php
namespace Cities\Models;

use Phalcon\Mvc\Model;

/**
 * Cities\Models\Profiles
 * All the profile levels in the application. Used in conjenction with ACL lists
 */
class Characters extends Model
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
     * Current City Id
     * @var integer
     */
    public $current_city_id;

    /**
     * Title
     * @var string
     */
    public $title;

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
     * Attributes
     * @var blob
     */
    public $attributes;

    /**
     * Created at
     * @var timestamp
     */
    public $created_at;

    /**
     * Updated at
     * @var timestamp
     */
    public $updated_at;

    /**
     * Dead
     * @var boolean
     */
    public $dead;

    /**
     * Define relationships to Users and Permissions
     */
    public function initialize()
    {
        $this->setSource("characters");
    }

    /**
     * Get the city data from database
     */
    public function getCordinates()
    {
        return array('x' => $this->x, 'y' => $this->y);
    }
}
