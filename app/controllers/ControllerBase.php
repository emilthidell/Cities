<?php
namespace Cities\Controllers;

use Phalcon\Tag;
use Phalcon\Mvc\Model\Criteria;
use Phalcon\Mvc\Controller;
use Phalcon\Mvc\Dispatcher;

use Cities\Models\Resources;
use Cities\Resource\Resource;

/**
 * ControllerBase
 * This is the base controller for all controllers in the application
 */
class ControllerBase extends Controller
{

    /**
     * Execute before the router so we can determine if this is a provate controller, and must be authenticated, or a
     * public controller that is open to all.
     *
     * @param Dispatcher $dispatcher
     * @return boolean
     */
    public function beforeExecuteRoute(Dispatcher $dispatcher)
    {
        date_default_timezone_set('UTC');
        
        $this->preDefineTemplateVars();

        $controllerName = $dispatcher->getControllerName();

        // Get the current identity
        $identity = $this->auth->getIdentity();

        if (is_array($identity)) { // User logged in, check the resources and how many resources have collected
            $resources = Resources::findFirst('user_id = '.$identity['id']);
            $resourceConfig = $this->config;
            $resourceModel = new Resource($resources, $resourceConfig, $identity['id']);
            if(!$resources){
                $resourceModel->create();
            }else{ // Check for fillups
                $resourceModel->fillup();
            }
        }

        // Only check permissions on private controllers
        if ($this->acl->isPrivate($controllerName)) {
            // If there is no identity available the user is redirected to index/index
            if (!is_array($identity)) {

                $this->flash->notice('You don\'t have access to this module: private');

                $dispatcher->forward(array(
                    'controller' => 'index',
                    'action' => 'index'
                ));
                return false;
            }

            // Check if the user have permission to the current option
            $actionName = $dispatcher->getActionName();
            if (!$this->acl->isAllowed($identity['profile'], $controllerName, $actionName)) {

                $this->flash->notice('You don\'t have access to this module: ' . $controllerName . ':' . $actionName);

                if ($this->acl->isAllowed($identity['profile'], $controllerName, 'index')) {
                    $dispatcher->forward(array(
                        'controller' => $controllerName,
                        'action' => 'index'
                    ));
                } else {
                    $dispatcher->forward(array(
                        'controller' => 'user_control',
                        'action' => 'index'
                    ));
                }

                return false;
            }
        }
    }

    public function preDefineTemplateVars(){

        $guide = new \stdClass();
        $guide->mode         = 0;
        $guide->messages     = array();
        $guide->jsonMessages = '';

        $this->view->setVar('guide', $guide);
    }
}
