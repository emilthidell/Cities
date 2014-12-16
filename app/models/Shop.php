<?php
namespace Cities\Models;

use Phalcon\Mvc\Model;

/**
 * Cities\Models\Profiles
 * All the profile levels in the application. Used in conjenction with ACL lists
 */
class Shop extends Model
{

    /**
     * ID
     * @var integer
     */
    public $id;

    /**
     * Type
     * @var string
     */
    public $type;

    /**
     * Title
     * @var string
     */
    public $title;

    /**
     * Width
     * @var integer
     */
    public $width;

    /**
     * Length
     * @var integer
     */
    public $length;

    /**
     * Attributes
     * @var blob
     */
    public $attributes;

    /**
     * Price
     * @var blob
     */
    public $price;

    /**
     * Resource folder (root: public/img/)
     * @var string
     */
    public $resource_folder;

    /**
     * Define relationships to Users and Permissions
     */
    public function initialize()
    {
        $this->setSource("shop");
    }

    /**
     * Get the city data from database
     */
    public function getSize()
    {
        return array('width' => $this->width, 'length' => $this->length);
    }
}
