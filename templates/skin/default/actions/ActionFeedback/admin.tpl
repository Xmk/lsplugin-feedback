{include file='header.tpl' noSidebar=true}

<h2 class="page-header"><a href="{router page='feedback'}">{$aLang.plugin.feedback.feedback}</a> <span>&raquo;</span> {$aLang.plugin.feedback.acp}</h2>

<form action="{router page='feedback'}admin/" method="post">
	<div class="wrapper-content">
		<p id="setting_mail_template" style="display:none" class="js-setting-mail-item">
			<input type="text" name="mail[]" value="" class="input-text input-width-200">
			<a class="icon-synio-remove" title="{$aLang.plugin.feedback.acp_mail_delete}" href="#" onclick="return ls.feedback.admin.deleteMail(this)"></a>
		</p>
		<p id="setting_title_template" style="display:none" class="js-setting-title-item">
			<input type="text" name="title[]" value="" class="input-text input-width-200">
			<a class="icon-synio-remove" title="{$aLang.plugin.feedback.acp_title_delete}" href="#" onclick="return ls.feedback.admin.deleteTitle(this)"></a>
		</p>
	</div>

	<div class="wrapper-content wrapper-content-dark">
		<h3>{$aLang.plugin.feedback.acp_mails}</h3>
		<span class="note">{$aLang.plugin.feedback.acp_mails_note}</span>
		{assign var="aMails" value=$_aRequest.mail}

		<div id="setting-mail-container">
		{foreach from=$aMails item=sMail}
			<p class="js-setting-mail-item">
				<input type="text" name="mail[]" value="{$sMail|escape:'html'}" class="input-text input-width-200">
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
			<p>
				<label for="acl_limit_time">{$aLang.plugin.feedback.acp_acl_time_limit}</label>
				<input type="text" id="acl_limit_time" name="acl[limit_time]" value="{$aAcl.limit_time|escape:'html'}" class="input-text input-width-100"><br>
				<span class="note">{$aLang.plugin.feedback.acp_acl_time_limit_note}</span>
			</p>
		</div>
		<div id="setting-acl-container">
			<p>
				<label for="acl_close_enable_yes">{$aLang.plugin.feedback.acp_acl_close_enable}</label>
				<label><input type="radio" class="radio" name="acl[close_enable]" id="acl_close_enable_yes" value="1"{if $aAcl.limit_time} checked{/if}> Yes</label>
				<label><input type="radio" class="radio" name="acl[close_enable]" id="acl_close_enable_no" value="0"{if !$aAcl.limit_time} checked{/if}> No</label>
			</p>
		</div>
	</div>

	<div class="wrapper-content wrapper-content-dark">
		<h3>{$aLang.plugin.feedback.acp_fields}</h3>
		<span class="note">{$aLang.plugin.feedback.acp_fields_note}</span>
		{assign var="aFields" value=$_aRequest.field}

		<div id="setting-fields-container">
			<p>
				<label for="field_name">{$aLang.plugin.feedback.acp_fields_name}</label>
				<label><input type="radio" class="radio" name="field[name]" id="field_name_no" value="0"{if !$aFields.name} checked{/if}> {$aLang.plugin.feedback.acp_field_hide}</label>
				<label><input type="radio" class="radio" name="field[name]" id="field_name_yes" value="1"{if $aFields.name} checked{/if}> {$aLang.plugin.feedback.acp_field_show}</label>
			</p>
		</div>
		<div id="setting-fields-container">
			<p>
				<label for="field_title">{$aLang.plugin.feedback.acp_fields_title}</label>
				<label><input type="radio" class="radio" name="field[title]" id="field_title_no" value="0"{if !$aFields.title} checked{/if}> {$aLang.plugin.feedback.acp_field_hide}</label>
				<label><input type="radio" class="radio" name="field[title]" id="field_title_yes" value="1"{if $aFields.title == 1} checked{/if}> {$aLang.plugin.feedback.acp_field_show} {$aLang.plugin.feedback.acp_field_input|lower}</label>
				<label><input type="radio" class="radio" name="field[title]" id="field_title_list" value="2"{if $aFields.title == 2} checked{/if}> {$aLang.plugin.feedback.acp_field_show} {$aLang.plugin.feedback.acp_field_list|lower}</label>
			</p>
		</div>
	</div>

	<div class="wrapper-content"{if !$aFields.title || $aFields.title != 2} style="display:none"{/if}>
		<h3>{$aLang.plugin.feedback.acp_titles}</h3>
		{assign var="aTitles" value=$_aRequest.title}

		<div id="setting-title-container">
		{foreach from=$aTitles item=sTitle}
			<p class="js-setting-title-item">
				<input type="text" name="title[]" value="{$sTitle|escape:'html'}" class="input-text input-width-200">
				<a class="icon-synio-remove" title="{$aLang.plugin.feedback.acp_title_delete}" href="#" onclick="return ls.feedback.admin.deleteTitle(this)"></a>
			</p>
		{/foreach}
		</div>
		<a href="#" onclick="return ls.feedback.admin.addFormTitle()" class="link-dotted">{$aLang.plugin.feedback.acp_title_add}</a>
	</div>

	<div class="wrapper-content">
		<button type="submit" name="submit_feedback_settings" class="button button-primary">{$aLang.plugin.feedback.acp_save}</button>
	</div>
</form>

{include file='footer.tpl'}