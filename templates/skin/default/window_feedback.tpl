<div class="modal modal-feedback" id="modal_feedback">
	<header class="modal-header">
		<h3>{$aLang.plugin.feedback.feedback}</h3>
		<a href="#" class="close jqmClose"></a>
	</header>

	{strip}
	<div class="modal-content">
		<script type="text/javascript">
			jQuery(document).ready(function($){
				ls.feedback.initForm(true);
			});
		</script>

		<form action="{router page='feedback'}" method="post" id="popup-feedback-form">
			{hook run='form_feedback_begin' isPopup=true}

			<p>
			<small class="validate-error-hide validate-error-field-ip"></small></p>

			{if $oConfig->GetValue('plugin.feedback.field.name')}
			<p>
			<input type="text" name="name" placeholder="{$aLang.plugin.feedback.send_name}" id="popup-feedback-name" value="{$_aRequest.name}" class="input-text input-width-400 js-ajax-validate" />
			<i class="icon-question-sign js-tip-help" title="{$aLang.plugin.feedback.send_name_notice}"></i>
			<i class="icon-ok-green validate-ok-field-name" style="display: none"></i>
			<small class="validate-error-hide validate-error-field-name"></small></p>
			{/if}

			<p>
			<input type="text" name="mail" placeholder="{$aLang.plugin.feedback.send_mail}" id="popup-feedback-mail" value="{$_aRequest.mail}" class="input-text input-width-400 js-ajax-validate" />
			<i class="icon-question-sign js-tip-help" title="{$aLang.plugin.feedback.send_mail_notice}"></i>
			<i class="icon-ok-green validate-ok-field-mail" style="display: none"></i>
			<small class="validate-error-hide validate-error-field-mail"></small></p>

			{if $oConfig->GetValue('plugin.feedback.field.title')}
			<p>
			{if $oConfig->GetValue('plugin.feedback.field.title') == 1}
				<input type="text" name="title" placeholder="{$aLang.plugin.feedback.send_title}" id="popup-feedback-title" value="{$_aRequest.title}" class="input-text input-width-400 js-ajax-validate" />
			{else}
				<select name="title" id="popup-feedback-title" class="input-text input-width-400 js-ajax-validate">
					<option value="">{$aLang.plugin.feedback.send_title}</option>
					{foreach from=$oConfig->GetValue('plugin.feedback.title') item=sTitle}
					<option value="{$sTitle}"{if $_aRequest.title==$sTitle} selected{/if}>{$sTitle}</option>
					{/foreach}
				</select>
			{/if}
			<i class="icon-question-sign js-tip-help" title="{$aLang.plugin.feedback.send_title_notice}"></i>
			<i class="icon-ok-green validate-ok-field-title" style="display: none"></i>
			<small class="validate-error-hide validate-error-field-title"></small></p>
			{/if}

			<p>
			<label for="text">{$aLang.plugin.feedback.send_text}:</label>
			<textarea name="text" id="popup-feedback-text" class="input-text input-width-400 js-ajax-validate" rows="10">{$_aRequest.text}</textarea>
			<i class="icon-question-sign js-tip-help" title="{$aLang.plugin.feedback.send_text_notice}"></i>
			<i class="icon-ok-green validate-ok-field-text" style="display: none"></i>
			<small class="validate-error-hide validate-error-field-text"></small></p>

			{hookb run="popup_feedbacl_captcha"}
			<p><label for="popup-feedback-captcha">{$aLang.plugin.feedback.captcha}</label>
			<img src="{cfg name='path.root.engine_lib'}/external/kcaptcha/index.php?{$_sPhpSessionName}={$_sPhpSessionId}" 
				 onclick="this.src='{cfg name='path.root.engine_lib'}/external/kcaptcha/index.php?{$_sPhpSessionName}={$_sPhpSessionId}&n='+Math.random();"
				 class="captcha-image" />
			<input type="text" name="captcha" id="popup-feedback-captcha" value="" maxlength="3" class="input-text input-width-100 js-ajax-validate" />
			<i class="icon-ok-green validate-ok-field-captcha" style="display: none"></i>
			<small class="validate-error-hide validate-error-field-captcha"></small></p>
			{/hookb}

			{hook run='form_feedback_end' isPopup=true}

			<button type="submit"  name="submit_feedback" class="button button-primary" id="popup-feedback-form-submit" disabled="disabled">{$aLang.plugin.feedback.button_send}</button>
		</form>
	</div>
	{/strip}
	{hook run='feedback_copyright'}
</div>
</div>