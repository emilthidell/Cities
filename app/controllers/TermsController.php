<?php
namespace Cities\Controllers;

/**
 * Display the terms and conditions page.
 */
class TermsController extends ControllerBase
{

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
