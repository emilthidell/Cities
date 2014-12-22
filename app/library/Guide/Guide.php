<?php
namespace Cities\Guide;

use Cities\Models\GuideMessages;

/**
 * Display the "About" page.
 */
class Guide
{
    public $mode = 1;

    private $userId;

    /**
     * Construct
     */
    public function __construct($userId)
    {
        $this->userId = $userId;
    }

    /**
     * Get the messsages
     */
    public function getMessages()
    {
        $data = new \stdClass();

        $data->mode     = 1;
        $data->messages = GuideMessages::find('user_id = '.$this->userId.' AND seen = 0');


        if(count($data->messages) == 0){
            $data->mode = 0;
        }else{
            $parsedMessages = array();

            foreach($data->messages as $message){

                $parsedMessages[$message->id] = new \stdClass();

                $parsedMessages[$message->id]->id           = $message->id;
                $parsedMessages[$message->id]->user_id      = $message->user_id;
                $parsedMessages[$message->id]->seconds      = $message->seconds;
                $parsedMessages[$message->id]->width        = $message->width;
                $parsedMessages[$message->id]->height       = $message->height;
                $parsedMessages[$message->id]->top          = $message->top;
                $parsedMessages[$message->id]->left         = $message->left;
                $parsedMessages[$message->id]->pointer_left = $message->pointer_left;
                $parsedMessages[$message->id]->icon         = $message->icon;
                $parsedMessages[$message->id]->message      = $message->message;
                $parsedMessages[$message->id]->seen         = $message->seen;
                $parsedMessages[$message->id]->expire       = $message->expire;
                $parsedMessages[$message->id]->created_at   = $message->created_at;
            }

            $data->jsonMessages = htmlentities(json_encode($parsedMessages));

        }

        return $data;

    }

    /**
     * Publish messages
     *
     * @param  object $message
     * @return boolean
     */
    private function publishMessages($message)
    {
        $published = 0;

        if(!is_array($message)){
            $message = array($message);
        }

        return $published;
    }

}
