{assign var="noSidebar" value=true}
{assign var="sToLoad" value='feedback-text'}
{include file='header.tpl'}
{include file='editor.tpl'}

<h2 class="page-header">{$aLang.plugin.feedback.feedback}</h2>

<form action="{router page='feedback'}" method="POST" id="feedback-form" class="feedback-form">
	{hook run='form_feedback_begin'}

	{if $oConfig->GetValue('plugin.feedback.field.name')}
	<p><label for="feedback-name">{$aLang.plugin.feedback.send_name}</label>
	<input type="text" name="name" id="feedback-name" value="{$_aRequest.name}" class="input-text input-width-300 js-ajax-validate" />
	<i class="icon-ok-green validate-ok-field-name" style="display: none"></i>
	<i class="icon-question-sign js-tip-help" title="{$aLang.plugin.feedback.send_name_notice}"></i>
	<small class="validate-error-hide validate-error-field-name"></small></p>
	{/if}

	<p><label for="feedback-mail">{$aLang.plugin.feedback.send_mail}</label>
	<input type="text" name="mail" id="feedback-mail" value="{$_aRequest.mail}" class="input-text input-width-300 js-ajax-validate" />
	<i class="icon-ok-green validate-ok-field-mail" style="display: none"></i>
	<i class="icon-question-sign js-tip-help" title="{$aLang.plugin.feedback.send_name_notice}"></i>
	<small class="validate-error-hide validate-error-field-mail"></small></p>

	{if $oConfig->GetValue('plugin.feedback.field.title')}
	<p><label for="feedback-mail">{$aLang.plugin.feedback.send_title}</label>
	{if $oConfig->GetValue('plugin.feedback.field.title') == 1}
	<input type="text" name="title"id="popup-feedback-title" value="{$_aRequest.title}" class="input-text input-width-300 js-ajax-validate" />
	{else}
	<select name="title" id="popup-feedback-title" class="input-text input-width-300 js-ajax-validate">
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

	<p><label for="text">{$aLang.plugin.feedback.send_text}:</label>
	<textarea name="text" id="popup-feedback-text" class="mce-editor markitup-editor input-text input-width-300 js-ajax-validate" rows="10">{$_aRequest.text}</textarea>
	<i class="icon-question-sign js-tip-help" title="{$aLang.plugin.feedback.send_text_notice}"></i>
	<i class="icon-ok-green validate-ok-field-text" style="display: none"></i>
	<small class="validate-error-hide validate-error-field-text"></small></p>

	{hookb run="feedback_captcha"}
	<p><label for="popup-feedback-captcha">{$aLang.plugin.feedback.captcha}</label>
	<img src="{cfg name='path.root.engine_lib'}/external/kcaptcha/index.php?{$_sPhpSessionName}={$_sPhpSessionId}" 
		 onclick="this.src='{cfg name='path.root.engine_lib'}/external/kcaptcha/index.php?{$_sPhpSessionName}={$_sPhpSessionId}&n='+Math.random();"
		 class="captcha-image" />
	<input type="text" name="captcha" id="popup-feedback-captcha" value="" maxlength="3" class="input-text input-width-100 js-ajax-validate" />
	<i class="icon-ok-green validate-ok-field-captcha" style="display: none"></i>
	<small class="validate-error-hide validate-error-field-captcha"></small></p>
	{/hookb}

	<p><small class="validate-error-hide validate-error-field-ip"></small></p>

	{hook run='form_feedback_end'}

	<button type="submit" name="submit_feedback" class="button button-primary" id="feedback-form-submit" disabled="disabled">{$aLang.plugin.feedback.button_send}</button>
</form>

{hook run='feedback_copyright'}

{include file='footer.tpl'}