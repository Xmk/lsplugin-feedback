/*---------------------------------------------------------------------------
* @Module Name: Feedback
* @Description: Feedback for LiveStreet
* @Version: 2.0
* @Author: Chiffa
* @LiveStreet Version: 1.X
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

	this.checkWriterStatus = function() {
		var status=ls.registry.get('copywriter'), el;
		for (var i=1;i<=4;i++) {
			el=$('#filter_ip2_'+i).attr('readonly',status ? false : 'readonly');
			if (!status) {
				el.val($('#filter_ip1_'+i).val());
			}
		}
	};

	this.copyWriterEnabler = function(status) {
		ls.registry.set('copywriter',status);
		this.checkWriterStatus();
	};

	this.copyWriter = function(e) {
		if (!ls.registry.get('copywriter')) {
			var oField=$(e.target);
			var idField=oField.attr('id').replace('filter_ip1_','filter_ip2_');
			$('#'+idField).val(oField.val());
		}
	};

	this.applyIpForm = function(form) {
		ls.ajaxSubmit(aRouter['feedback']+'ajax/addip/', form, function(result) {
			if (result.bStateError) {
				ls.msg.error(null,result.sMsg);
			} else {
				if (result.sMsg) ls.msg.notice(null,result.sMsg);
				$('#ip_'+result.sType+'_list').append(result.sText);
				$('#ip_'+result.sType+'_empty').hide();
			}
		}.bind(this));
		return false;
	};
	this.deleteIp = function(hash) {
		if (!confirm(ls.lang.get('plugin.feedback.acp_ip_del_confirm'))) return false;

		ls.ajax(aRouter['feedback']+'ajax/deleteip/', { hash:hash }, function(result) {
			if (result.bStateError) {
				ls.msg.error(null,result.sMsg);
			} else {
				if (result.sMsg) ls.msg.notice(null,result.sMsg);
				$('#ip_'+result.sId).detach();
				if ($('#ip_'+result.sType+'_list li').size() == 1)
				$('#ip_'+result.sType+'_empty').show();
			}
		}.bind(this));
		return false;
	};

	return this;
}).call(ls.feedback.admin || {},jQuery);


jQuery(document).ready(function($){

	var container=$('#setting-title-container').parent('.wrapper-content');

	$('input:radio[name=field[title]]').change(function(e){
		var checkbox=$(e.target);
		if (checkbox.attr('checked')) {
			if (checkbox.val() < 2) {
				container.hide();
			} else {
				container.show();
			}
		}
	});

	$('input.input-feedback-ip.js-cp').keyup(ls.feedback.admin.copyWriter);

	ls.feedback.admin.checkWriterStatus();
});