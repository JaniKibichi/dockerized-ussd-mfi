<?php
//grab environmental variables

$username = getenv("AT_USERNAME");
$apikey = getenv("AT_APIKEY");
$productname = getenv("AT_PRODUCTNAME");
$shortcode = getenv("AT_SMSCODE");
$callerid = getenv("AT_NUMBER");
$ringback = getenv("RINGBACKTONE");
$voicecallurl = getenv("VOICE_CALLURL");
$tocall = getenv("CALLNUMBERS");
$voicemenuurl = getenv("VOICE_MENUURL");
$mysqlRoot = getenv("MYSQL_ROOT_PASSWORD");
$mysqlDB = getenv("MYSQL_DATABASE");
$mysqlUser = getenv("MYSQL_USER");
$mysqlPass = getenv("MYSQL_PASSWORD"); 

?>