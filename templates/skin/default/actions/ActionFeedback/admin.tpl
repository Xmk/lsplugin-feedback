{include file='header.tpl' noSidebar=true}

<h2 class="page-header"><a href="{router page='feedback'}">{$aLang.plugin.feedback.feedback}</a> <span>&raquo;</span> {$aLang.plugin.feedback.acp}</h2>

<form action="{router page='feedback'}admin/" method="post">
	<div class="wrapper-content">
		<p id="setting_mail_template" style="display:none" class="js-setting-mail-item">
			<input type="text" name="mail[]" value="" class="input-text input-width-200">
			<a class="icon-synio-remove" title="{$aLang.plugin.feedback.acp_mail_delete}" href="#" onclick="return ls.feedback.admin.deleteMail(this)"></a>
		</p>
	</div>

	<div class="wrapper-content wrapper-content-dark">
		<h3>{$aLang.plugin.feedback.acp_mails}</h3>
		<span class="note">{$aLang.plugin.feedback.acp_mails_note}</span>
		{assign var="aMails" value=$_aRequest.mail}

		<div id="setting-mail-container">
		{foreach from=$aMails item=oMail}
			<p class="js-setting-mail-item">
				<input type="text" name="mail[]" value="{$oMail->getValue()|escape:'html'}" class="input-text input-width-200">
				<a class="icon-synio-remove" title="{$aLang.plugin.feedback.acp_mail_delete}" href="#" onclick="return ls.feedback.admin.deleteMail(this)"></a>
			</p>
		{/foreach}
		</div>
		<a href="#" onclick="return ls.feedback.admin.addFormMail()" class="link-dotted">{$aLang.plugin.feedback.acp_mail_add}</a>
	</div>

	<div class="wrapper-content">
		<h3>{$aLang.plugin.feedback.acp_acl}</h3>
		{assign var="aAcl" value=$_aRequest.acl}

		<div id="setting-acl-container">
			{assign var="oSetTimeLimit" value=$aAcl.limit_time}
			<p>
				<label for="acl_limit_time">{$aLang.plugin.feedback.acp_acl_time_limit}</label>
				<input type="text" id="acl_limit_time" name="acl[limit_time]" value="{$oSetTimeLimit->getValue()|escape:'html'}" class="input-text input-width-100"><br>
				<span class="note">{$aLang.plugin.feedback.acp_acl_time_limit_note}</span>
			</p>
		</div>
		<div id="setting-acl-container">
			{assign var="oSetCloseEnable" value=$aAcl.limit_time}
			<p>
				<label for="acl_close_enable_yes">{$aLang.plugin.feedback.acp_acl_close_enable}</label>
				<label><input type="radio" class="radio" name="acl[close_enable]" id="acl_close_enable_yes" value="1"{if $oSetCloseEnable->getValue()} checked{/if}> Yes</label>
				<label><input type="radio" class="radio" name="acl[close_enable]" id="acl_close_enable_no" value="0"{if !$oSetCloseEnable || !$oSetCloseEnable->getValue()} checked{/if}> No</label>
			</p>
		</div>
	</div>

	<div class="wrapper-content">
		<button type="submit" name="submit_feedback_settings" class="button button-primary">{$aLang.plugin.feedback.acp_save}</button>
	</div>
</form>

{include file='footer.tpl'}