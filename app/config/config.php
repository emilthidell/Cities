<?php

/**
* Local database settings
**/
$databaseConfig = array(
    'adapter'  => 'Mysql',
    'host'     => '127.0.0.1',
    'username' => 'root',
    'password' => '',
    'dbname'   => 'cities'
);

$applicationDomain = "cities.dev";
$mandrillAppKey    = "";

/**
* Production database settings loader
*
* To activate production mode, place a file in the production servers config folder named config.prod.php with the following content:
<?php
$databaseConfig = array(
    'adapter'  => 'Mysql',
    'host'     => '127.0.0.1',
    'username' => 'production_user',
    'password' => 'production_password',
    'dbname'   => 'production_dbnam'
);

$applicationDomain = "citites.production;

$mandrillAppKey = "";

?>
*
**/
$configFile = str_replace("\\","/",__FILE__);
$databaseProdConfigFileArray = explode("/", $configFile);
$databaseProdConfigFile = "";
for ($i = 0; $i <= count($databaseProdConfigFileArray)-2; $i++) {
    $part = $databaseProdConfigFileArray[$i];
    if(!strpos($part, ':')){
        $databaseProdConfigFile .= "/".$part;
    }else{
        $databaseProdConfigFile .= $part;
    }
}
$databaseProdConfigFile = $databaseProdConfigFile."/config.prod.php";
if(file_exists($databaseProdConfigFile)){
    include($databaseProdConfigFile);
}

return new \Phalcon\Config(array(
    'database' => $databaseConfig,
    'application' => array(
            'controllersDir' => APP_DIR . '/controllers/',
            'modelsDir'      => APP_DIR . '/models/',
            'formsDir'       => APP_DIR . '/forms/',
            'viewsDir'       => APP_DIR . '/views/',
            'libraryDir'     => APP_DIR . '/library/',
            'pluginsDir'     => APP_DIR . '/plugins/',
            'cacheDir'       => APP_DIR . '/cache/',
            'baseUri'        => '/',
            'publicUrl'      => $applicationDomain,
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
                    'apiKey' => $mandrillAppKey
            )
        )
));
