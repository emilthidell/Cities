<?php
namespace Cities\Models;

use Phalcon\Mvc\Model;

/**
 * Cities\Models\Profiles
 * All the profile levels in the application. Used in conjenction with ACL lists
 */
class Allies extends Model
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
     * allyID
     * @var integer
     */
    public $ally_id;

    /**
     * response
     * @var string
     */
    public $response;

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
        $this->setSource("allies");
    }

}
