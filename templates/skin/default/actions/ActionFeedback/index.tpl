{include file='header.tpl' showWhiteBack=true}

	<div class="feedback">
		<h3>{$aLang.feedback}</h3>
		<br/>
		<form action="{router page='feedback'}" method="POST">
			<input type="hidden" name="security_ls_key" value="{$LIVESTREET_SECURITY_KEY}" /> 

			{hook run='form_feedback_begin'}

			<p><label for="send_name">{$aLang.feedback_send_name}:</label><br/>
			<input type="text" class="input-text w300" name="send_name" id="send_name" value="{$_aRequest.send_name}" /><br />
			<span class="form_note">{$aLang.feedback_send_name_notice}</span></p>

			<p><label for="send_mail">{$aLang.feedback_send_mail}:</label><br/>
			<input type="text" class="input-text w300" id="send_mail" name="send_mail" value="{$_aRequest.send_mail}" /><br />
			<span class="form_note">{$aLang.feedback_send_mail_notice}</span></p>

			<p><label for="send_title">{$aLang.feedback_send_title}:</label><br />
			{if !$oConfig->GetValue('plugin.feedback.selected_titles')}
				<input type="text" class="input-text w300" id="send_title" name="send_title" value="{$_aRequest.send_title}" /><br /></p>
			{else}
				<select id="send_title" name="send_title" class="w300">
					<option value="">&nbsp;</option>
					{foreach from=$aLang.feedback_titles item=sTitle}
					<option value="{$sTitle}" {if $_aRequest.send_title==$sTitle}selected{/if}>{$sTitle}</option>
					{/foreach}
				</select></p>
			{/if}

			<p><label for="send_text">{$aLang.feedback_send_text}:</label><br />
			<textarea id="send_text" name="send_text">{$_aRequest.send_text}</textarea>
			</p><br />

			<p><label for="">{$aLang.feedback_captcha}:</label><br />
			<img src="{cfg name='path.root.engine_lib'}/external/kcaptcha/index.php?{$_sPhpSessionName}={$_sPhpSessionId}" onclick="this.src='{cfg name='path.root.engine_lib'}/external/kcaptcha/index.php?{$_sPhpSessionName}={$_sPhpSessionId}&n='+Math.random();"><br/>
			<input type="text" class="input-text" style="width: 80px;" name="captcha" value="" maxlength="3" /></p>

			{hook run='form_feedback_end'}

			<div class="lite-note"><button type="submit" name="submit_feedback" class="button" style="float: none;"><span><em>{$aLang.feedback_button_send}</em></span></button></div>
		</form>
		<br/>
	</div>

{include file='footer.tpl'}