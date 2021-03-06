<?php
namespace Cities\Controllers;

use Cities\Models\Cities;

/**
 * Display the terms and conditions page.
 */
class TermsController extends ControllerBase
{
    /**
     * Init
     */
    public function initialize()
    {
        $loginState = 0;
        if(is_array($this->auth->getIdentity())){

            $currentUser = $this->auth->getIdentity();

            $this->currentUserId = $currentUser['id'];

            $loginState = 1;

            $cities = Cities::find("user_id = ".$currentUser['id']);

            if(count($cities) <= 1){
                $this->view->setVar('current_city', $cities[0]->id);
            }

            $this->view->setVar('num_cities', count($cities));

        }
        $this->view->setVar('logged_in', $loginState);
        $this->view->setTemplateBefore('public');
    }

    /**
     * Default action. Set the public layout (layouts/public.volt)
     */
    public function indexAction()
    {
        $loginState = 0;
        if(is_array($this->auth->getIdentity())){
            $loginState = 1;
        }
        $this->view->setVar('logged_in', $loginState);
        $this->view->setTemplateBefore('public');
    }
}
