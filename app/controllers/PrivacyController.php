<?php
namespace Cities\Controllers;

/**
 * Display the privacy page.
 */
class PrivacyController extends ControllerBase
{

    public function initialize()
    {
        $currentUser = $this->auth->getIdentity();

        $loginState = 0;
        if(is_array($currentUser)){
            $loginState = 1;
        }

        $cities = Cities::find("user_id = ".$currentUser['id']);

        if(count($cities) <= 1){
            $this->view->setVar('current_city', $cities[0]->id);
        }

        $this->view->setVar('logged_in', $loginState);
        $this->view->setVar('cities', $cities);
        $this->view->setVar('num_cities', count($cities));
    }

    /**
     * Default action. Set the public layout (layouts/public.volt)
     */
    public function indexAction()
    {

        $this->view->setTemplateBefore('public');
    }
}
