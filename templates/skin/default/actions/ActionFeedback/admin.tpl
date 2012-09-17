{include file='header.tpl' noSidebar=true}

<h2 class="page-header"><a href="{router page='feedback'}">{$aLang.plugin.feedback.feedback}</a> <span>&raquo;</span> {$aLang.plugin.feedback.acl}</h2>

<form action="{router page='feedback'}admin/" method="post">
	<div class="wrapper-content">
		<p id="setting_mail_template" style="display:none" class="js-setting-mail-item">
			<input type="text" name="mail[]" value="" class="input-text input-width-200">
			<a class="icon-synio-remove" title="{$aLang.plugin.feedback.acl_mail_delete}" href="#" onclick="return ls.feedback.admin.deleteMail(this)"></a>
		</p>
	</div>

	<div class="wrapper-content wrapper-content-dark">
		<h3>{$aLang.plugin.feedback.acl_mails}</h3>
		<span class="note">{$aLang.plugin.feedback.acl_mails_note}</span>

		{assign var="aMails" value=$aSettings.mail}
		<div id="setting-mail-container">
		{foreach from=$aMails item=oMail}
			<p class="js-setting-mail-item">
				<input type="text" name="mail[]" value="{$oMail->getValue()|escape:'html'}" class="input-text input-width-200">
				<a class="icon-synio-remove" title="{$aLang.plugin.feedback.acl_mail_delete}" href="#" onclick="return ls.feedback.admin.deleteMail(this)"></a>
			</p>
		{/foreach}
		</div>
		<a href="#" onclick="return ls.feedback.admin.addFormMail()" class="link-dotted">{$aLang.plugin.feedback.acl_mail_add}</a>
	</div>

	<div class="wrapper-content">
		<button type="submit" name="submit_feedback_settings" class="button button-primary">{$aLang.plugin.feedback.acl_save}</button>
	</div>
</form>

{include file='footer.tpl'}