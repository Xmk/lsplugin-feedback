/*---------------------------------------------------------------------------
* @Module Name: Feedback
* @Description: Feedback for LiveStreet
* @Version: 2.0
* @Author: Chiffa
* @LiveStreet Version: 1.0
* @File Name: feedback.js
* @License: CC BY-NC, http://creativecommons.org/licenses/by-nc/3.0/
*----------------------------------------------------------------------------
*/

var ls=ls || {}

ls.feedback = ls.feedback || {}

ls.feedback.admin = (function ($) {

	this.addFormMail = function() {
		var tpl=$('#setting_mail_template').clone();
		$('#setting-mail-container').append(tpl.show());
		return false;
	};

	this.deleteMail = function(o) {
		$(o).parent('.js-setting-mail-item').detach();
		return false;
	};

	this.addFormTitle = function() {
		var tpl=$('#setting_title_template').clone();
		$('#setting-title-container').append(tpl.show());
		return false;
	};

	this.deleteTitle = function(o) {
		$(o).parent('.js-setting-title-item').detach();
		return false;
	};

	return this;
}).call(ls.feedback || {},jQuery);

jQuery(document).ready(function($){

	$('#field_title_list').change(function() {
		$('#setting-title-container').parent('.wrapper-content').show()
	});
	$('#field_title_yes').change(function() {
		$('#setting-title-container').parent('.wrapper-content').hide()
	});
	$('#field_title_no').change(function() {
		$('#setting-title-container').parent('.wrapper-content').hide()
	});

});