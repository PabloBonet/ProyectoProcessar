<?php
include_once ('functions.inc.php');
include_once('mysql_functions.inc.php');
//pr($GLOBALS);
/*Config vars*/

$devel = 0;
if($devel){
	//database local server
	define('SERVER','localhost');
	define('USER','root');
	define('PASS','');
	define('DBNAME','processar');
         $config = array(
            'URLWEB' => 'http://processar.int/',
            'WEBROOT' => '/webroot/',
            'ADMINROOT' => '/kdpanel/',
            'CONFIGPATH' => 'C:/wamp/www/processar/inc/',
            'WWW_ROOT' => 'C:/wamp/www/processar/webroot/',
            'WATERMARK' => 'C:/wamp/www/processar/webroot/img/watermark.png',
            'DO_DEBUG' => true
        );
} else {
	//database online server
	define('SERVER','localhost');
	define('USER','otrjnjpd_dba');
	define('PASS','C^$;5l.9lA8l');
	define('DBNAME','otrjnjpd_web');
        $config = array(
            'URLWEB' => 'http://www.processar.com.ar/',
            'WEBROOT' => '/webroot/',
            'ADMINROOT' => '/kdpanel/',
            'CONFIGPATH' => '/home6/otrjnjpd/public_html/inc/',
            'WWW_ROOT' => '/home6/otrjnjpd/public_html/webroot/',
            'WATERMARK' => '/home6/otrjnjpd/public_html/webroot/img/watermark.png',
            'DO_DEBUG' => false
        );
}
foreach ($config as $key => $val) {
    define($key,$val);
}
//connect to mysql
dbconnect();
date_default_timezone_set('America/Argentina/Buenos_Aires');

//load config settings from settings table
generate_settings();

$meses = array("ENE","FEB","MAR","ABR","MAY","JUN","JUL","AGO","SEP","OCT","NOV","DIC");

//if DO_DEBUG level, do debug
//debug();
?>