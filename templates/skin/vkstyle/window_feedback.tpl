<div class="modal modal-feedback" id="modal_feedback">
	<header class="modal-header">
		<h3 class="title-5">{$aLang.plugin.feedback.feedback}</h3>
		<a href="#" class="close jqmClose">
			<span class="font-icon-remove-circle"></span>
		</a>
	</header>

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
			<div class="form-group">
					<div class="input-icon">
					    <span class="font-icon-user btn"></span>
					    <input type="text" name="name" id="popup-feedback-name" value="{$_aRequest.name}" class="js-ajax-validate">
					    <span class="font-icon-question-sign btn js-infobox" title="{$aLang.plugin.feedback.send_name_notice}"></span>
					</div>
				</div>
			<small class="validate-error-hide validate-error-field-name help-block bg-error"></small>
			{/if}

			<div class="form-group">
				<div class="input-icon">
					<span class="font-icon-social-email btn"></span>
					    <input type="text" id="popup-feedback-mail" name="mail" value="{$_aRequest.mail}" class="js-ajax-validate">
					    <span class="font-icon-question-sign btn js-infobox" title="{$aLang.plugin.feedback.send_mail_notice}"></span>
					</div>
				</div>
			<small class="validate-error-hide validate-error-field-mail help-block bg-error"></small>

			{if $oConfig->GetValue('plugin.feedback.field.title')}
			<p>
			{if $oConfig->GetValue('plugin.feedback.field.title') == 1}
				<div class="form-group">
					<div class="input-icon">
						<span class="font-icon-text-width btn"></span>
						<input type="text" id="popup-feedback-title" name="title" value="{$_aRequest.title}" class="js-ajax-validate">
						<span class="font-icon-question-sign btn js-infobox" title="{$aLang.plugin.feedback.send_title_notice}"></span>
					</div>
				</div>
			{else}
				<select name="title" id="popup-feedback-title" class="input-text input-width-400 js-ajax-validate">
					<option value="">{$aLang.plugin.feedback.send_title}</option>
					{foreach from=$oConfig->GetValue('plugin.feedback.title') item=sTitle}
					<option value="{$sTitle}"{if $_aRequest.title==$sTitle} selected{/if}>{$sTitle}</option>
					{/foreach}
				</select>
			{/if}
			<small class="validate-error-hide validate-error-field-title help-block bg-error"></small></p>
			{/if}

			<div class="form-group">
				<label for="text">{$aLang.plugin.feedback.send_text}:</label>
				<textarea name="text" id="popup-feedback-text" class="input-text input-width-400 js-ajax-validate" rows="10">{$_aRequest.text}</textarea>
				<i class="icon-question-sign js-tip-help" title="{$aLang.plugin.feedback.send_text_notice}"></i>
				<small class="validate-error-hide validate-error-field-text help-block bg-error"></small>
			</div>

			{hookb run="popup_feedback_captcha"}
			<div class="form-group">
				<label for="popup-feedback-captcha">{$aLang.plugin.feedback.captcha}</label>
				<img src="{cfg name='path.root.engine_lib'}/external/kcaptcha/index.php?{$_sPhpSessionName}={$_sPhpSessionId}" 
					 onclick="this.src='{cfg name='path.root.engine_lib'}/external/kcaptcha/index.php?{$_sPhpSessionName}={$_sPhpSessionId}&n='+Math.random();"
					 class="captcha-image" />
				<input type="text" name="captcha" id="popup-feedback-captcha" value="" maxlength="3" class="input-text input-width-100 js-ajax-validate" />
				<small class="validate-error-hide validate-error-field-captcha help-block bg-error"></small>
			</div>
			{/hookb}

			{hook run='form_feedback_end' isPopup=true}

			<button type="submit"  name="submit_feedback" class="button button-primary" id="popup-feedback-form-submit" disabled="disabled">{$aLang.plugin.feedback.button_send}</button>
		</form>
		<div style="position: relative;">
		{hook run='feedback_copyright'}
		</div>
	</div>

</div>