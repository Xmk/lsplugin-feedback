<?
/*---------------------------------------------------------------------------
* @Module Name: Feedback
* @Description: Feedback for LiveStreet
* @Version: 2.0
* @Author: Chiffa
* @LiveStreet Version: 1.0
* @File Name: config.php
* @License: CC BY-NC, http://creativecommons.org/licenses/by-nc/3.0/
*----------------------------------------------------------------------------
*/

/* Настройки роутинга */
Config::Set('router.page.feedback', 'PluginFeedback_ActionFeedback');


/**
 * Конфиг модуля "feedback" - обратная связь
 */
 
/* Выбор темы из выпадающего списка */
$config['selected_titles']			= true;

/**
 * Активация плагина
 */
$config['activate'] = array();

/**
 * Деактивация плагина
 */
$config['deactivate'] = array(
	/* Удаление таблиц при деактивации */
	'delete' => true
);


return $config;
?>