<?php
namespace Cities\Controllers;

use Cities\Models\Profiles;
use Cities\Models\Cities;
use Cities\Models\Permissions;

/**
 * View and define permissions for the various profile levels.
 */
class PermissionsController extends ControllerBase
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

        $this->view->setTemplateBefore('private');
    }

    /**
     * View the permissions for a profile level, and change them if we have a POST.
     */
    public function indexAction()
    {
        $this->view->setTemplateBefore('private');

        if ($this->request->isPost()) {

            // Validate the profile
            $profile = Profiles::findFirstById($this->request->getPost('profileId'));

            if ($profile) {

                if ($this->request->hasPost('permissions')) {

                    // Deletes the current permissions
                    $profile->getPermissions()->delete();

                    // Save the new permissions
                    foreach ($this->request->getPost('permissions') as $permission) {

                        $parts = explode('.', $permission);

                        $permission = new Permissions();
                        $permission->profilesId = $profile->id;
                        $permission->resource = $parts[0];
                        $permission->action = $parts[1];

                        $permission->save();
                    }

                    $this->flash->success('Permissions were updated with success');
                }

                // Rebuild the ACL with
                $this->acl->rebuild();

                // Pass the current permissions to the view
                $this->view->permissions = $this->acl->getPermissions($profile);
            }

            $this->view->profile = $profile;
        }

        // Pass all the active profiles
        $this->view->profiles = Profiles::find('active = "Y"');
    }
}
