<?php

!defined( 'APP_ROOT' ) && exit( 'Direct Access Deny!' );

use Phalcon\Db\Adapter\Pdo\Mysql as DbAdapter;
use Phalcon\Session\Adapter\Files as FileSessionAdapter;
use Phalcon\Events\Manager as EventsManager;
use libraries\Verify;
use vendors\xunsearch\lib\XS;
use vendors\Pheanstalk;
use libraries\Benchmark;

$config = $di->get( 'config' );
// Set a different connection in each module

$di->set( 'mongodb', function (){
    
        $mongo =  new \MongoClient( '192.168.1.126:27017' );
        
        return $mongo->selectDB( 'imgs' );
        
}, true );

$di->set( 'bm', function(){
    $bm = new Benchmark();
    return $bm;
}, true);

$di->set( 'session', function() use($config)
{

    if( extension_loaded( 'memcached' ) )
    {
        $session = new \Phalcon\Session\Adapter\Libmemcached( array(
            'servers' => $config->cache->memcached->backend->toArray(),
            'client' => array(
                Memcached::OPT_HASH => Memcached::HASH_MD5,
                Memcached::OPT_PREFIX_KEY => 'huaer.'
            ),
            'lifetime' => $config->cache->memcached->frontend->lifetime,
            'prefix' => 'huaer_'   
            
        ));
    }
    else if( extension_loaded( 'memcache' ) )
    {
        $session = new \Phalcon\Session\Adapter\Memcache( $config->cache->memcache->backend->toArray() );
    }
    else 
    {
        $session = new \Phalcon\Session\Adapter\Files();
    }
    //session_set_cookie_params( 3600, '/', '.huaer.dev' );
    ini_set( "session.cookie_httponly", 1 );

    $session->start();

    return $session;
}, true );

 $di->set( 'cookies', function(){
 	$cookies = new \Phalcon\Http\Response\Cookies();
 	$cookies->useEncryption( false );
 	ini_set("session.cookie_httponly", 1);
 	return $cookies;
 });




// Registering a router
$di->set( 'router',
        function ()
{
    require APP_ROOT . 'config/router.php';
    return $router;
}, true );

// Registering unitTest
$di->set( 'utest', function ()
{
    return new \libraries\UnitTest();
}, true );

$di->set( 'url',
        function () use($config )
{
    $url = new Phalcon\Mvc\Url();
    $url->setBaseUri( $config->application->baseUri );
    return $url;
}, true );

// 验证码
$di->set( 'verify', function ()
{
    $verify = new Verify();
    return $verify;
}, true );

// //////////////////////////////////////////////////////////////////////////////////////////////////////////
// cache
/**
 * for html segment
 */
$di->set( 'htmlCache',
        function () use($config )
{

    if( !file_exists( $config->application->cacheDir . 'html/' ) && !mkdir( $config->application->cacheDir . 'html/' ) )
    {
        var_dump( error_get_last() );
        exit();
    }

    $frontCache = new \Phalcon\Cache\FrontEnd\Output( $config->cache->htmlCache->frontend ); // cache two days


    $cache = new \Phalcon\Cache\Backend\File( $frontCache,
            $config->cache->htmlCache->backend->toArray()
            );

    return $cache;
}, true );

/**
 * data file cache
 * 序列化是存在错误
 */
$di->set( 'fileCache',
        function () use($config )
{
    $frontCache = new \Phalcon\Cache\FrontEnd\Data( $config->cache->fileCache->frontend ); 

    if( !file_exists( $config->application->cacheDir . 'fileCache/' ) && !mkdir( $config->application->cacheDir . 'fileCache/' ) )
    {
        var_dump( error_get_last() );
        exit();
    }

    $cache = new \Phalcon\Cache\Backend\File( $frontCache, $config->cache->fileCache->backend->toArray() );

    return $cache;
}, true );


/**
 * data file cache 需要手动清除的file cache
 */
$di->set( 'fCache',
        function () use($config )
{
    if( !file_exists( $config->application->cacheDir . 'fCache/' ) && !mkdir( $config->application->cacheDir . 'fCache/' ) )
    {
        var_dump( error_get_last() );
        exit();
    }

    return new libraries\FCache( $config );
}, true );

/**
 * memcache cache
 */
$di->set( 'memCache', function () use($config )
{
    $frontCache = new \Phalcon\Cache\FrontEnd\Data( $config->cache->memcache->frontend->toArray() ); // cache two days

   if( !extension_loaded( 'memcache' ) )
   {
       echo 'memcache extension not loaded!<br>';
       exit();
   }
   else
    {
        $cache = new \Phalcon\Cache\Backend\Memcache( $frontCache, $config->cache->memcache->backend->toArray() );
    }
    

    return $cache;
}, true );

$di->set( 'memCached', function() use( $config )
{
    $frontCache = new \Phalcon\Cache\FrontEnd\Data( $config->cache->memcached->frontend ); // cache two days

   if( !extension_loaded( 'memcached' ) )
   {
       echo 'memcache extension not loaded!<br>';
       exit();
   }
   else
   {
        $cache = new \Phalcon\Cache\Backend\Libmemcached( $frontCache,
                    array( 'servers' => $config->cache->memcached->backend->toArray() ));
    }
    return $cache;
}, true );
/**
 * apc cache
 */
$di->set( 'apcCache', function () use($config )
{
    if( !extension_loaded( 'apc' ) )
    {
        echo 'apc extension not loaded!<br>';
        exit();
    }

    $frontCache = new \Phalcon\Cache\FrontEnd\Data( $config->cache->apc->frontend->toArray() ); // cache two days


    $cache = new \Phalcon\Cache\Backend\Apc( $frontCache, $config->cache->apc->backend->toArray() );

    return $cache;
}, true );

/**
 * memory 易失性 不能进行序列化 只能在一次请求中有效
 */
$di->set( 'memory',
        function () use($config )
{
    $frontCache = new \Phalcon\Cache\FrontEnd\Data( 
        $config->cache->inmem->frontend );

    $cache = new \Phalcon\Cache\Backend\Memory( $frontCache );

    return $cache;
}, true );

/**
 * xCache
 */
$di->set( 'xcache',
        function () use($config )
{
    if( !extension_loaded( 'XCache' ) )
    {
        echo 'XCache extension not loaded!';
        exit();
    }

    $frontCache = new \Phalcon\Cache\FrontEnd\Data( $config->cache->xcache->frontend );

    $cache = new \Phalcon\Cache\Backend\Xcache( $frontCache, $config->cache->xcache->backend->toArray() );

    return $cache;
}, true );

/**
 * mongodb Cache
 */
$di->set( 'mongoCache',
        function () use($config )
{
    if( !extension_loaded( 'mongo' ) )
    {
        echo 'mongo extension not loaded!';
        exit();
    }

    $frontCache = new \Phalcon\Cache\FrontEnd\Data( $config->cache->mongodb->frontend );

    $cache = new \Phalcon\Cache\Backend\Mongo( $frontCache, $config->cache->mongodb->backend->toArray() );

    return $cache;
}, true );


/**
 * redis cache
 */
$di->set( 'redisCache',
        function() use( $config )
{
    if( !extension_loaded( 'redis' ))
    {
        echo 'redis extension not loaded!<br>';
        exit();
    }
    
    $frontCache = new \Phalcon\Cache\FrontEnd\Data( $config->cache->redisCache->frontend );

    $cache = new \Phalcon\Cache\Backend\Redis( $frontCache, $config->cache->redisCache->backend->toArray() );

    return $cache;
}, true );

/**
 * native redis
 * 原生native使用phpredis扩展
 */
$di->set( 'nredis', function()
{

	if( !extension_loaded( 'redis' ))
	{
		echo 'redis extension not loaded!<br>';
		exit();
	}
	
	$redis = new \Redis();
	
	$redis->connect( '192.168.1.234', 6379 /*, 'password'*/ );
	
	return $redis;
}, true );

/**
 * muti Cache
 * 由于发者根据自行需求进行配置
 */
$di->set( 'multiCache',
        function () use($config )
{
//     if( !extension_loaded( 'mongo' ) )
//     {
//         echo  'mongo extension not loaded!';
//         exit();
//     }


    if( !extension_loaded( 'apc' ) )
    {
        echo 'apc extension not loaded!';
        exit();
    }
    $ultraFastFrontend = new \Phalcon\Cache\FrontEnd\Data( $config->cache->apc->frontend );

    if( !extension_loaded( 'memcache' ) )
    {
        echo 'memcache not loaded!';
        exit();
    }
    $fastFrontend = new \Phalcon\Cache\FrontEnd\Data( $config->cache->memCache->frontend );


    if( !file_exists( $config->application->cacheDir . 'fileCache/' ) && !mkdir( $config->application->cacheDir . 'fileCache/' ) )
    {
        var_dump( error_get_last() );
        exit();
    }
    $slowFrontend = new \Phalcon\Cache\FrontEnd\Data( $config->cache->fileCache->frontend );

    $cache = new \Phalcon\Cache\Multiple( array(
        new \Phalcon\Cache\Backend\Apc( $ultraFastFrontend,
                array(
            "prefix" => 'multi'
                ) ),
        new \Phalcon\Cache\Backend\Memcache( $fastFrontend,
                array(
            "prefix" => 'multi',
            "host"   => "127.0.0.1",
            "port"   => "11211"
                ) ),
        new \Phalcon\Cache\Backend\File( $slowFrontend,
                array(
            "prefix"   => 'multi',
            "cacheDir" => $config->application->cacheDir . 'fileCache/'
                ) )
            ) );

    return $cache;
}, true );

/**
 * safe Cache
 * 主要用来生产用
 */
$di->set( 'safeCache',function () use($config )
{
    $frontCache = new \Phalcon\Cache\FrontEnd\Data( array(
        'lifetime' => 172800
    ) ); // cache two days

  if( extension_loaded( 'memcached' ) )
    {
        $cache = new \Phalcon\Cache\Backend\Libmemcached($frontCache,  array( 
            'servers' => $config->cache->memcached->backend->toArray() ) );
    }
    else if( extension_loaded( 'memcache' ) )
    {
        $cache = new \Phalcon\Cache\Backend\Memcache( $frontCache, $config->cache->memcache->backend->toArray() );
    }
    else if( !file_exists( $config->application->cacheDir . 'fileCache/' ) && !mkdir( $config->application->cacheDir . 'fileCache/' ) )
    {
        var_dump( error_get_last() );
        exit();
    }
    else 
    {
        $cache = new \Phalcon\Cache\Backend\File( $frontCache,array(
            'cacheDir' => $config->application->cacheDir . 'fileCache/'
        ) );
    }

    return $cache;
}, true );


/**
 * upload
 */
$di->set( 'upload', function()
{
    return new UploadUtils();
}, true );



$di->set( 'email',
        function() use ( $config )
{
 //include APP_ROOT . 'config/' . 'email.php'   
    $email = new \libraries\Email();

    return $email;
}, true );


// $di->set( 'xs_goods', function(){
//     return new XS( 'goods' );
// }, true );

// $di->set( 'xs_article', function(){
// 	return new XS( 'article' );
// }, true );

$di->set( 'modelsMetadata',function() use ( $config ){ 
	$metaData = new \Phalcon\Mvc\Model\MetaData\Memory( array(
		'lifetime' => 1440,
	    'prefix' => 'metadata_'
	));
	
	return $metaData;
}, true );

$di->set( 'queue', function() use ( $config ){
	$queue = new \Phalcon\Queue\Beanstalk( $config->beanstalk->toArray() );
	
	return $queue;
}, true );

/**
 * pheanstalk
 */
$di->set( 'npqueue', function(){
    $phean = new \vendors\Pheanstalk\Pheanstalk( $config->beanstalk->host, $config->beanstalk->port );
    
    return $phean;
}, true );

/**
 * CsrfCheck
 */
$di->set( 'security', function(){
    return new \libraries\CsrfCheck();
}, true );