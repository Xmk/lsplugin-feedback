<?
/*---------------------------------------------------------------------------
* @Module Name: Feedback
* @Description: Feedback for LiveStreet
* @Version: 1.2
* @Author: Chiffa
* @LiveStreet Version: 0.4.2
* @File Name: ActionFeedback.class.php
* @License: GNU GPL v2, http://www.gnu.org/licenses/old-licenses/gpl-2.0.html
*----------------------------------------------------------------------------
*/

/* ��������� �������� */
Config::Set('router.page.feedback',	'PluginFeedback_ActionFeedback');


/**
 * ������ ������ "feedback" - �������� �����
 */
 
/* ������� ����������� �����, �� ������� ����� ��������� ������ (����� �������) */
$config['mail']						= array('mail@mail.ru');

/* ������ ������ � �������� ����� ���� � "�������� ������" ������ ����� */
$config['close_enable']				= true;

/* ����� � �������� ����� ��������� ���������, ���� 0 �� ����������� �� ������� �� ����� �������� */
$config['acl_limit_time']   		= 240;

/* �������� ������ �� �������� ����� � ����� ����������� � ����������� */
$config['add_forms_links']			= true;

/* �������� ������ �� �������� ����� � ������� ���� */
$config['add_menu_link']			= true;

/* �������� ������ �� �������� ����� � ����� */
$config['add_footer_link']			= false;

/* ����� ���� �� ����������� ������ */
$config['selected_titles']			= true;


return $config;
?>