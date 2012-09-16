{include file='header.tpl'}

{if $oConfig->GetValue('view.tinymce')}
	<script src="{cfg name='path.root.engine_lib'}/external/tinymce-jq/tiny_mce.js"></script>
	<script>
		jQuery(function($){
			tinyMCE.init(ls.settings.getTinymce());
		});
	</script>
{else}
	{include file='window_load_img.tpl' sToLoad='send_text'}
	<script>
		jQuery(function($){
			ls.lang.load({lang_load name="panel_b,panel_i,panel_u,panel_url,panel_url_promt,panel_image,panel_quote,panel_list,panel_list_ul,panel_list_ol,panel_clear_tags,panel_list_li,panel_image_promt"});
			// Подключаем редактор
			$('#send_text').markItUp(ls.feedback.getMarkitup());
		});
	</script>
{/if}

<h2 class="page-header">{$aLang.plugin.feedback.feedback}</h2>

<form action="{router page='feedback'}" method="POST">
	<input type="hidden" name="security_ls_key" value="{$LIVESTREET_SECURITY_KEY}" /> 

	{hook run='form_feedback_begin'}

	<p>
		<label for="send_name">{$aLang.plugin.feedback.send_name}:</label>
		<input type="text" id="send_name" name="send_name" value="{$_aRequest.send_name}" class="input-text input-width-400" /><br />
		<span class="note">{$aLang.plugin.feedback.send_name_notice}</span>
	</p>

	<p>
		<label for="send_mail">{$aLang.plugin.feedback.send_mail}:</label>
		<input type="text" id="send_mail" name="send_mail" value="{$_aRequest.send_mail}" class="input-text input-width-400" /><br />
		<span class="form_note">{$aLang.plugin.feedback.send_mail_notice}</span>
	</p>

	<p>
		<label for="send_title">{$aLang.plugin.feedback.send_title}:</label>
		{if !$oConfig->GetValue('plugin.feedback.selected_titles')}
			<input type="text" id="send_title" name="send_title" value="{$_aRequest.send_title}" class="input-text input-width-400" /><br />
		{else}
			<select id="send_title" name="send_title" class="input-width-400">
				<option value="">&nbsp;</option>
				{foreach from=$aLang.plugin.feedback.titles item=sTitle}
				<option value="{$sTitle}"{if $_aRequest.send_title==$sTitle} selected{/if}>{$sTitle}</option>
				{/foreach}
			</select>
		{/if}
	</p>

	<label for="send_text">{$aLang.plugin.feedback.send_text}{if !$oConfig->GetValue('view.tinymce')} ({$aLang.plugin.feedback.send_text_notice}){/if}:</label>
	<textarea name="send_text" id="send_text" rows="20" class="mce-editor">{$_aRequest.send_text}</textarea>

	{hookb run="feedback_captcha"}
	<p>
		<label for="send_captcha">{$aLang.plugin.feedback.captcha}</label>
		<img src="{cfg name='path.root.engine_lib'}/external/kcaptcha/index.php?{$_sPhpSessionName}={$_sPhpSessionId}" 
			onclick="this.src='{cfg name='path.root.engine_lib'}/external/kcaptcha/index.php?{$_sPhpSessionName}={$_sPhpSessionId}&n='+Math.random();"
			class="captcha-image" />
		<input type="text" name="send_captcha" id="send_captcha" value="" maxlength="3" class="input-text input-width-100" />
	</p>
	{/hookb}

	{hook run='form_feedback_end'}

	<button type="submit" name="submit_feedback" id="submit_feedback" class="button button-primary">{$aLang.plugin.feedback.button_send}</button>
</form>

{include file='footer.tpl'}