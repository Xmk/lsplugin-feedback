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

	this.addItemToList = function(item) {
		var c=$('#setting-'+item+'-container');
		var t=$('#setting_'+item+'_template');
		if (c && t) {
			c.append(t.clone().show());
			return true;
		}
		return false;
	};
	this.delItemFromList = function(o,item) {
		if ($(o)) {
			var it=$(o).parent('.js-setting-'+item+'-item')
			if (it) {
				it.detach();
				return true;
			}
		}
		return false;
	};

	this.addFormMail = function() {
		return !this.addItemToList('mail');
	};
	this.deleteMail = function(o) {
		return !this.delItemFromList(o,'mail');
	};

	this.addFormTitle = function() {
		return !this.addItemToList('title');
	};
	this.deleteTitle = function(o) {
		return !this.delItemFromList(o,'title');
	};

	return this;
}).call(ls.feedback || {},jQuery);


jQuery(document).ready(function($){

	var container=$('#setting-title-container').parent('.wrapper-content');

	$('#field_title_list').change(container.show);
	$('#field_title_yes').change(container.hide);
	$('#field_title_no').change(container.hide);

});