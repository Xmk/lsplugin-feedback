<div class="slide slide-bg-yellow mb-10" id="modal_feedback">
	<header>
		<h3>{$aLang.plugin.feedback.feedback}</h3>
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
			<p class="validate-error-field-name">
				<input type="text" name="name" placeholder="{$aLang.plugin.feedback.send_name}" id="popup-feedback-name" value="{$_aRequest.name}" class="input-text input-width-full js-ajax-validate" />
				<small class="validate-error validate-error-hide"></small>
			</p>
			{/if}

			<p class="validate-error-field-mail">
				<input type="text" name="mail" placeholder="{$aLang.plugin.feedback.send_mail}" id="popup-feedback-mail" value="{$_aRequest.mail}" class="input-text input-width-full js-ajax-validate" />
				<small class="validate-error validate-error-hide"></small>
			</p>

			{if $oConfig->GetValue('plugin.feedback.field.title')}
			<p class="validate-error-field-title">
				{if $oConfig->GetValue('plugin.feedback.field.title') == 1}
					<input type="text" name="title" placeholder="{$aLang.plugin.feedback.send_title}" id="popup-feedback-title" value="{$_aRequest.title}" class="input-text input-width-full js-ajax-validate" />
				{else}
					<select name="title" id="popup-feedback-title" class="input-text input-width-full js-ajax-validate">
						<option value="">{$aLang.plugin.feedback.send_title}</option>
						{foreach from=$oConfig->GetValue('plugin.feedback.title') item=sTitle}
							<option value="{$sTitle}"{if $_aRequest.title==$sTitle} selected{/if}>{$sTitle}</option>
						{/foreach}
					</select>
				{/if}
				<small class="validate-error validate-error-hide"></small>
			</p>
			{/if}

			<p class="validate-error-field-text">
				<label for="text">{$aLang.plugin.feedback.send_text}:</label>
				<textarea name="text" id="popup-feedback-text" class="input-text input-width-full js-ajax-validate" rows="10">{$_aRequest.text}</textarea>
				<small class="validate-error validate-error-hide"></small>
			</p>

			{hookb run="popup_feedback_captcha"}
			<p class="validate-error-field-captcha">
				<label for="popup-feedback-captcha">{$aLang.plugin.feedback.captcha}</label>
				<img src="{cfg name='path.root.engine_lib'}/external/kcaptcha/index.php?{$_sPhpSessionName}={$_sPhpSessionId}" 
					 onclick="this.src='{cfg name='path.root.engine_lib'}/external/kcaptcha/index.php?{$_sPhpSessionName}={$_sPhpSessionId}&n='+Math.random();"
					 class="captcha-image" />
				<input type="text" name="captcha" id="popup-feedback-captcha" value="" maxlength="3" class="input-text input-width-100 js-ajax-validate" />
				<small class="validate-error validate-error-hide"></small>
			</p>
			{/hookb}

			{hook run='form_feedback_end' isPopup=true}

			<button type="submit" class="button button-primary" id="popup-feedback-form-submit" name="submit_feedback" disabled="disabled">{$aLang.plugin.feedback.button_send}</button>
			<button type="button" class="button" onclick="return ls.feedback.hideForm()">{$aLang.plugin.feedback.button_cancel}</button>
		</form>
	</div>

	{hook run='feedback_copyright'}
</div>