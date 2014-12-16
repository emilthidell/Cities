<?php
return new \Phalcon\Config(array(
    'database' => array(
                    'adapter'  => 'Mysql',
                    'host'     => '127.0.0.1',
                    'username' => 'cities',
                    'password' => '',
                    'dbname'   => 'cities'
    ),
    'application' => array(
                    'controllersDir' => APP_DIR . '/controllers/',
                    'modelsDir'      => APP_DIR . '/models/',
                    'formsDir'       => APP_DIR . '/forms/',
                    'viewsDir'       => APP_DIR . '/views/',
                    'libraryDir'     => APP_DIR . '/library/',
                    'pluginsDir'     => APP_DIR . '/plugins/',
                    'cacheDir'       => APP_DIR . '/cache/',
                    'baseUri'        => '/',
                    'publicUrl'      => 'cities.dev',
                    'cryptSalt'      => 'eEAfR|_&G&f,+vU]:jFr!!A&+71w1Ms9~8_4L!<@[N@DyaIP_2My|:+.u>/6m,$D'
    ),
    'mapStates' => array(
                    0 => 'Stone age',
                    1 => 'Medieval age',
                    2 => 'Current age',
                    3 => 'Space age',
                    4 => 'Moon',
    ),
    'mail' => array(
        'fromName'          => 'Cities',
        'fromEmail'         => 'mail@emil.ninja',
        'driver'            => 'mandrill', // or Amazon
        'mandrill' => array(
                    'apiKey' => '******************'
        )
    )
));
