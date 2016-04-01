<?php
!defined( 'APP_ROOT' ) && exit( 'Direct Access Deny!' );
return new \Phalcon\Config(array(
    'database' => array(
        'adapter'  => 'Mysql',
        'host'     => '127.0.0.1',
        'username' => 'root',
        'password' => 'root',
        'dbname'   => 'fcms',
        'charset'  => 'utf8',
        'prefix'   => 'fcms_',
    ),    
	'application' => array(
        'pluginsDir'     => APP_ROOT . 'plugins/',
        'libraryDir'     => APP_ROOT . 'libraries/',
        'cacheDir'       => APP_ROOT . 'cache/',
        'enumsDir'		 => APP_ROOT . 'enums/',
        'logs' 			 => APP_ROOT . 'logs/',
        'listenersDir'	 => APP_ROOT . 'listeners/',
        'baseUri'        => '/',
    ),
	'cache' => array(
	        'cacheAdapter' => 'memcache',
	        'memcache'     => array(
                'frontend' => array( 'lifetime' => 14400 ),
                'backend'  => array(
	                'host' => '127.0.0.1',
	                'port' => '11211'
                )
	        ),
	        'memcached' => array(
                'backend' => array( 
                    array(
                        'host'   => '127.0.0.1',
                        'port'   => '11211',
                        'weight' => '1'
                    )
                ),
                'frontend' => array( 'lifetime' => 14400 )
            ),
	        'mongoCache'   => array(
                'frontend' => array( 'lifetime' => 14400 ),
                'backend'  => array(
	                'server'     => "mongodb://localhost",
	                'db'         => 'caches',
	                'collection' => 'images',
                )
            ),
	        'apc' => array(
                'frontend' => array( 'lifetime' => 172800 ),
                'backend'  => array( 'prefix'   => 'fcms_' )
	        ),
	        'inmem'        => array( 'frontend' => array( 'lifetime' => 1800 ) ),
	        'redisCache'   => array( 
                'frontend' => array( 'lifetime' => 14400 ),
                'backend'  => array(
                    'host'       => '127.0.0.1',
                    'port'       => 6379,
                    //'auth'     => 'foobared',
                    'persistent' => false,
                    'prefix'     => 'fcms_'
                )
            ),
	        'fileCache'    => array( 
                'frontend' => array( 'lifetime' => 14400 ),
                'backend'  => array( 'cacheDir' => APP_ROOT . 'cache/fileCache/' ) 
	        ),
	        'fCache'       => array( 
                'frontend' => array( 'lifetime' => 14400 ),
	            'backend'  => array( 'cacheDir' => APP_ROOT . 'cache/fileCache/' )
            ),
	        'xcache'       => array( 
                'frontend' => array( 'lifetime' => 14400 ),
                'backend'  => array( 'prefix'   => 'fcms_' )
	        ),
	        'htmlCache'    => array( 
                'frontend' => array( 'lifetime' => 14400 ),
                'backend'  => array( 'cacheDir' => APP_ROOT . 'cache/html/' )
	        )
    ),
    'beanstalk' => array( 
        'host'  => '127.0.0.1', 
        'port'  => 11300 ),
    'admin_regenrator_time_interval' => 3 * 60,
    'home_regenarater_time_interval' => 3 * 60,
    'sensitive_default_replace'		 => '**',
    )
);