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
Config::Set('router.page.feedback',	'PluginFeedback_ActionFeedback');


/**
 * Конфиг модуля "feedback" - обратная связь
 */
 
/* Адресса электронной почты, на которые будут приходить письма (через запятую) */
$config['mail']						= array('mail@mail.ru');

/* Доступ гостям к обратной связи даже в "закрытом режиме" работы сайта */
$config['close_enable']				= true;

/* время в секундах между отправкой сообщений, если 0 то ограничение по времени не будет работать */
$config['acl_limit_time']   		= 240;

/* Добавить ссылки на обратную связь в формы Авторизации и Регистрации */
$config['add_forms_links']			= true;

/* Добавить ссылку на обратную связь в главное меню */
$config['add_menu_link']			= true;

/* Добавить ссылку на обратную связь в футер */
$config['add_footer_link']			= false;

/* Выбор темы из выпадающего списка */
$config['selected_titles']			= true;


return $config;
?>