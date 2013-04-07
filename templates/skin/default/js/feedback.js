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

ls.feedback = (function ($) {
	/**
	 * Инициализация формы обратной связи
	 * @param	isPopup
	 */
	this.initForm = function(isPopup) {
		isPopup = isPopup ? true : false;
		var form = isPopup ? 'popup-feedback-form' : 'feedback-form';
		var submit = isPopup ? 'popup-feedback-form-submit' : 'feedback-form-submit';
		if (typeof(form)=='string') {
			form=$('#'+form);
		}
		if (typeof(submit)=='string') {
			submit=$('#'+submit);
		}
		$(form).find('.js-ajax-validate').blur(function(e){
			ls.feedback.validateField($(e.target).attr('name'),$(e.target).val(),$(form));
		});
		$(form).bind('submit',function(){
			ls.feedback.send(form,isPopup);
			return false;
		});
		$(submit).attr('disabled',false);
	};

	/**
	 * Настройки для редактора
	 * @return	hash
	 */
	this.getMarkitup = function() {
		return {
			onShiftEnter:	{keepDefault:false, replaceWith:'<br />\n'},
			onCtrlEnter:	{keepDefault:false, openWith:'\n<p>', closeWith:'</p>'},
			onTab:			{keepDefault:false, replaceWith:'    '},
			markupSet: [
				{name: ls.lang.get('panel_b'), className:'editor-bold', key:'B', openWith:'(!(<strong>|!|<b>)!)', closeWith:'(!(</strong>|!|</b>)!)' },
				{name: ls.lang.get('panel_i'), className:'editor-italic', key:'I', openWith:'(!(<em>|!|<i>)!)', closeWith:'(!(</em>|!|</i>)!)'  },
				{name: ls.lang.get('panel_u'), className:'editor-underline', key:'U', openWith:'<u>', closeWith:'</u>' },
				{separator:'---------------' },
				{name: ls.lang.get('panel_list'), className:'editor-ul', openWith:'    <li>', closeWith:'</li>', multiline: true, openBlockWith:'<ul>\n', closeBlockWith:'\n</ul>' },
				{name: ls.lang.get('panel_list'), className:'editor-ol', openWith:'    <li>', closeWith:'</li>', multiline: true, openBlockWith:'<ol>\n', closeBlockWith:'\n</ol>' },
				{name: ls.lang.get('panel_list_li'), className:'editor-li', openWith:'<li>', closeWith:'</li>' },
				{separator:'---------------' },
				{name: ls.lang.get('panel_quote'), className:'editor-quote', key:'Q', replaceWith: function(m) { if (m.selectionOuter) return '<blockquote>'+m.selectionOuter+'</blockquote>'; else if (m.selection) return '<blockquote>'+m.selection+'</blockquote>'; else return '<blockquote></blockquote>' } },
				{name: ls.lang.get('panel_url'), className:'editor-link', key:'L', openWith:'<a href="[!['+ls.lang.get('panel_url_promt')+':!:http://]!]"(!( title="[![Title]!]")!)>', closeWith:'</a>', placeHolder:'Your text to link...' },
				{name: ls.lang.get('panel_image'), className:'editor-picture', key:'P', beforeInsert: function(h) { jQuery('#window_upload_img').jqmShow(); } },
				{separator:'---------------' },
				{name: ls.lang.get('panel_clear_tags'), className:'editor-clean', replaceWith: function(markitup) { return markitup.selection.replace(/<(.*?)>/g, "") } },
			]
		}
	};

	/**
	 * Очиска полей формы обратной связи
	 * @param	form
	 */
	this.clearFields = function(form) {
		if (typeof(form)=='string') {
			form=$('#'+form);
		}
		form.find('.validate-error-show').removeClass('validate-error-show').addClass('validate-error-hide');
		form.find('.icon-ok-green').hide();
		form.find('input.js-ajax-validate').val('');
		form.find('textarea.js-ajax-validate').val('');
		form.find('select.js-ajax-validate').val('');
		form.find('.captcha-image').click();
	};

	/**
	 * Валидация полей формы обратной связи
	 * @param aFields
	 * @param sForm
	 */
	this.validateFields = function(aFields,sForm) {
		var url = aRouter['feedback']+'ajax/validate/';
		var params = {fields: aFields};
		if (typeof(sForm)=='string') {
			sForm=$('#'+sForm);
		}

		ls.hook.marker('validateFeedbackFieldsBefore');
		ls.ajax(url, params, function(result) {
			if (!sForm) {
				sForm=$('body');
			}
			$.each(aFields,function(i,aField){
				if (result.aErrors && result.aErrors[aField.field][0]) {
					sForm.find('.validate-error-field-'+aField.field).removeClass('validate-error-hide').addClass('validate-error-show').text(result.aErrors[aField.field][0]);
					sForm.find('.validate-ok-field-'+aField.field).hide();
				} else {
					sForm.find('.validate-error-field-'+aField.field).removeClass('validate-error-show').addClass('validate-error-hide');
					sForm.find('.validate-ok-field-'+aField.field).show();
				}
			});
			ls.hook.run('validate_feedback_fields_after', [aFields, sForm, result]);
		});
	};

	/**
	 * Валидация конкретного поля формы
	 * @param	sField
	 * @param	sValue
	 * @param	sForm
	 * @param	aParams
	 */
	this.validateField = function(sField,sValue,sForm,aParams) {
		var aFields=[];
		aFields.push({field: sField, value: sValue, params: aParams || {}});
		this.validateFields(aFields,sForm);
	};

	/**
	 * Ajax отправка письма с проверкой полей формы
	 * @param	form
	 * @param	isPopup
	 */
	this.send = function(form,isPopup) {
		var url = aRouter['feedback']+'ajax/send/';

		ls.user.formLoader(form);
		ls.hook.marker('feedbackSendBefore');
		ls.ajaxSubmit(url, form, function(result) {
			ls.user.formLoader(form,true);
			if (result.bStateError) {
				ls.msg.error(null,result.sMsg);
			} else {
				if (typeof(form)=='string') {
					form=$('#'+form);
				}
				form.find('.validate-error-show').removeClass('validate-error-show').addClass('validate-error-hide');
				if (result.aErrors) {
					$.each(result.aErrors,function(sField,aErrors){
						if (aErrors[0]) {
							form.find('.validate-error-field-'+sField).removeClass('validate-error-hide').addClass('validate-error-show').text(aErrors[0]);
						}
					});
				} else {
					if (result.sMsg) {
						//if (isPopup) {
							//this.noticePopup(result.sMsg);
						//} else {
							ls.msg.notice(null,result.sMsg);
						//}
					}
					this.clearFields(form);
				}
				ls.hook.run('feedback_send_after', [form, result]);
			}
		}.bind(this));
	};

	return this;
}).call(ls.feedback || {},jQuery);


jQuery(document).ready(function($){
	ls.hook.run('feedback_template_init_start',[],window);

	// Инициализация формы
	ls.feedback.initForm();

	// Модальное окно
	$('.js-feedback-window-show').click(function(){
        $('#modal_feedback').jqmShow();
        return false;
    });

	ls.hook.run('feedback_template_init_end',[],window);
});