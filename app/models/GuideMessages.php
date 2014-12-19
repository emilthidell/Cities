<?php
namespace Cities\Models;

use Phalcon\Mvc\Model;

/**
 * Cities\Models\Profiles
 * All the profile levels in the application. Used in conjenction with ACL lists
 */
class GuideMessages extends Model
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
     * Seconds
     * @var integer
     */
    public $seconds;

    /**
     * Icon
     * @var string
     */
    public $icon;

    /**
     * Message
     * @var string
     */
    public $message;

    /**
     * Seen
     * @var boolean
     */
    public $seen;

    /**
     * Expire
     * @var timestamp
     */
    public $expire;

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
        $this->setSource("guide_messages");
    }

}
