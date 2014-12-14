<?php
$loader = new \Phalcon\Loader();

/**
 * We're a registering a set of directories taken from the configuration file
 */
$loader->registerNamespaces(array(
    'Cities\Models' => $config->application->modelsDir,
    'Cities\Controllers' => $config->application->controllersDir,
    'Cities\Forms' => $config->application->formsDir,
    'Cities' => $config->application->libraryDir
));

$loader->register();

// Use composer autoloader to load vendor classes
require_once __DIR__ . '/../../vendor/autoload.php';
