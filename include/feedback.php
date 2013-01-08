<?php
/*---------------------------------------------------------------------------
* @Module Name: Feedback
* @Description: Feedback for LiveStreet
* @Version: 2.0
* @Author: Chiffa
* @LiveStreet Version: 1.0
* @File Name: feedback.php
* @License: CC BY-NC, http://creativecommons.org/licenses/by-nc/3.0/
*----------------------------------------------------------------------------
*/

if (!function_exists('fSetCookie')) {
	function fSetCookie($sName=null, $sValue='', $bSticky=1, $iExpiresDays=0, $iExpiresMinutes=0, $iExpiresSeconds=0) {
		if (!($sName)) return;

		if ($bSticky) $iExpires = time() + (60*60*24*365);
		else $iExpires = time() + ($iExpiresDays * 86400) + ($iExpiresMinutes * 60) + $iExpiresSeconds;

		if ($iExpires <= time()) $iExpires = false;

		print_r(array('sName'=>$sName,'sValue'=>$sValue,'bSticky'=>$bSticky,'iExpiresDays'=>$iExpiresDays,'iExpiresMinutes'=>$iExpiresMinutes,'iExpiresSeconds'=>$iExpiresSeconds));

		@setcookie($sName,$sValue,$iExpires,Config::Get('sys.cookie.path'),Config::Get('sys.cookie.host'));
	}
}
if (!function_exists('fGetCookie')) {
	function fGetCookie($sName) {
		if (isset($_COOKIE[$sName])) {
			return htmlspecialchars(urldecode(trim($_COOKIE[$sName])));
		}
		return false;
	}
}
function bound($x, $min, $max) {
	return min(max($x, $min), $max);
}
function int2ip($i) {
	$d=array();
	$d[0]=(int)($i/256/256/256);
	$d[1]=(int)(($i-$d[0]*256*256*256)/256/256);
	$d[2]=(int)(($i-$d[0]*256*256*256-$d[1]*256*256)/256);
	$d[3]=$i-$d[0]*256*256*256-$d[1]*256*256-$d[2]*256;
	return join($d,'.');
}
function ip2int($ip) {
   $a=explode('.',$ip);
   return $a[0]*256*256*256+$a[1]*256*256+$a[2]*256+$a[3];
}

?>