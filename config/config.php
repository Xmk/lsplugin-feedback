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