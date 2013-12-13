<?php
/*---------------------------------------------------------------------------
* @Module Name: Feedback
* @Description: Feedback for LiveStreet
* @Version: 2.0
* @Author: Chiffa
* @LiveStreet version: 1.X
* @File Name: config.php
* @License: CC BY-NC, http://creativecommons.org/licenses/by-nc/3.0/
*----------------------------------------------------------------------------
*/

/**
  * Настройки роутинга
  */
Config::Set('router.page.feedback', 'PluginFeedback_ActionFeedback');
Config::Set('plugin.feedback.encrypt', 'ChiffaYo');

/**
 * Если вы внесли пожертвование http://livestreetcms.com/profile/Chiffa/donate/
 * или покупали плагин за деньги
 * ставим true
 */
$config['donator']				= false;

return $config;

?>