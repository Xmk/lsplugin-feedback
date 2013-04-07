{include file='header.tpl' noSidebar=true}

<h2 class="page-header"><a href="{router page='feedback'}">{$aLang.plugin.feedback.feedback}</a> <span>&raquo;</span> {$aLang.plugin.feedback.acp}</h2>

{include file="$sTemplatePathPlugin/menu.feedback.admin.tpl"}
{assign var="_aSettings" value=$_aRequest.settings}

<form action="{router page='feedback'}admin/" method="post">
	<input type="hidden" name="security_ls_key" value="{$LIVESTREET_SECURITY_KEY}" />

	<div class="wrapper-content">
		<p id="setting_mail_template" style="display:none" class="js-setting-mail-item">
			<input type="text" name="settings[mail][]" value="" class="input-text input-width-200">
			<a class="icon-synio-remove" title="{$aLang.plugin.feedback.acp_mail_delete}" href="#" onclick="return ls.feedback.admin.deleteMail(this)"></a>
		</p>
		<p id="setting_title_template" style="display:none" class="js-setting-title-item">
			<input type="text" name="settings[title][]" value="" class="input-text input-width-200">
			<a class="icon-synio-remove" title="{$aLang.plugin.feedback.acp_title_delete}" href="#" onclick="return ls.feedback.admin.deleteTitle(this)"></a>
		</p>
	</div>

	<div class="wrapper-content wrapper-content-dark">
		<h3>{$aLang.plugin.feedback.acp_mails}</h3>
		<span class="note">{$aLang.plugin.feedback.acp_mails_note}</span>
		{assign var="aMails" value=$_aSettings.mail}

		<div id="setting-mail-container">
		{foreach from=$aMails item=sMail}
			<p class="js-setting-mail-item">
				<input type="text" name="settings[mail][]" value="{$sMail|escape:'html'}" class="input-text input-width-200">
				<a class="icon-synio-remove" title="{$aLang.plugin.feedback.acp_mail_delete}" href="#" onclick="return ls.feedback.admin.deleteMail(this)"></a>
			</p>
		{/foreach}
		</div>
		<a href="#" onclick="return ls.feedback.admin.addFormMail()" class="link-dotted">{$aLang.plugin.feedback.acp_mail_add}</a>
	</div>

	<div class="wrapper-content">
		<h3>{$aLang.plugin.feedback.acp_acl}</h3>
		{assign var="aAcl" value=$_aSettings.acl}

		<div id="setting-acl-container">
			<p>
				<label for="acl_limit_time">{$aLang.plugin.feedback.acp_acl_time_limit}</label>
				<input type="text" id="acl_limit_time" name="settings[acl][limit_time]" value="{$aAcl.limit_time|escape:'html'}" class="input-text input-width-100"><br>
				<span class="note">{$aLang.plugin.feedback.acp_acl_time_limit_note}</span>
			</p>
		</div>
		<div id="setting-acl-container">
			<p>
				<label for="acl_close_enable_yes">{$aLang.plugin.feedback.acp_acl_close_enable}</label>
				<label><input type="radio" class="radio" name="settings[acl][close_enable]" id="acl_close_enable_yes" value="1"{if $aAcl.limit_time} checked{/if}> Yes</label>
				<label><input type="radio" class="radio" name="settings[acl][close_enable]" id="acl_close_enable_no" value="0"{if !$aAcl.limit_time} checked{/if}> No</label>
			</p>
		</div>
        <div id="setting-acl-container">
			<p>
				<label for="acl_check_exist">{$aLang.plugin.feedback.acp_acl_check_exists}</label>
				<label><input type="radio" class="radio" name="settings[acl][check_exists]" id="acl_check_exists" value="1"{if $aAcl.check_exists} checked{/if}> Yes</label>
				<label><input type="radio" class="radio" name="settings[acl][check_exists]" id="acl_check_exists" value="0"{if !$aAcl.check_exists} checked{/if}> No</label>
			</p>
		</div>
        <div id="setting-acl-container">
			<p>
				<label for="acl_msg_text_min">
				<input type="text" class="input-text input-width-100" name="settings[acl][msg_text_min]" id="acl_msg_text_min" value="{$aAcl.msg_text_min}"> &ndash;
                {$aLang.plugin.feedback.acp_acl_text_min}
                </label>
			    <label for="acl_msg_text_max">
				<input type="text" class="input-text input-width-100" name="settings[acl][msg_text_max]" id="acl_msg_text_max" value="{$aAcl.msg_text_max}"> &ndash;
                {$aLang.plugin.feedback.acp_acl_text_max}
                </label>
			</p>
		</div>
	</div>

	<div class="wrapper-content wrapper-content-dark">
		<h3>{$aLang.plugin.feedback.acp_fields}</h3>
		<span class="note">{$aLang.plugin.feedback.acp_fields_note}</span>
		{assign var="aFields" value=$_aSettings.field}

		<div id="setting-fields-container">
			<p>
				<label for="field_name">{$aLang.plugin.feedback.acp_fields_name}</label>
				<label><input type="radio" class="radio" name="settings[field][name]" id="field_name_no" value="0"{if !$aFields.name} checked{/if}> {$aLang.plugin.feedback.acp_field_hide}</label>
				<label><input type="radio" class="radio" name="settings[field][name]" id="field_name_yes" value="1"{if $aFields.name} checked{/if}> {$aLang.plugin.feedback.acp_field_show}</label>
			</p>
		</div>
		<div id="setting-fields-container">
			<p>
				<label for="field_title">{$aLang.plugin.feedback.acp_fields_title}</label>
				<label><input type="radio" class="radio" name="settings[field][title]" id="field_title_no" value="0"{if !$aFields.title} checked{/if}> {$aLang.plugin.feedback.acp_field_hide}</label>
				<label><input type="radio" class="radio" name="settings[field][title]" id="field_title_input" value="1"{if $aFields.title == 1} checked{/if}> {$aLang.plugin.feedback.acp_field_show} {$aLang.plugin.feedback.acp_field_input|lower}</label>
				<label><input type="radio" class="radio" name="settings[field][title]" id="field_title_list" value="2"{if $aFields.title == 2} checked{/if}> {$aLang.plugin.feedback.acp_field_show} {$aLang.plugin.feedback.acp_field_list|lower}</label>
			</p>
		</div>
	</div>

	<div class="wrapper-content"{if !$aFields.title || $aFields.title != 2} style="display:none"{/if}>
		<h3>{$aLang.plugin.feedback.acp_titles}</h3>
		{assign var="aTitles" value=$_aSettings.title}

		<div id="setting-title-container">
		{foreach from=$aTitles item=sTitle}
			<p class="js-setting-title-item">
				<input type="text" name="settings[title][]" value="{$sTitle|escape:'html'}" class="input-text input-width-200">
				<a class="icon-synio-remove" title="{$aLang.plugin.feedback.acp_title_delete}" href="#" onclick="return ls.feedback.admin.deleteTitle(this)"></a>
			</p>
		{/foreach}
		</div>
		<a href="#" onclick="return ls.feedback.admin.addFormTitle()" class="link-dotted">{$aLang.plugin.feedback.acp_title_add}</a>
	</div>

	<div class="wrapper-content wrapper-content-dark">
		<h3>{$aLang.plugin.feedback.acp_sys}</h3>
		<span class="note">{$aLang.plugin.feedback.acp_sys_note}</span>

		<div id="setting-sys-container">
			{assign var="aSystem" value=$_aSettings.system}
			<p>
				<label>
					<input type="checkbox" class="input-checkbox" name="settings[system][popup]" id="popup_wnd" value="1"{if $aSystem.popup} checked{/if}>
					{$aLang.plugin.feedback.acp_sys_popup}
				</label>
			</p>
			<p>
				<label>
					{$aLang.plugin.feedback.acp_sys_button_name}<br/>
					<input type="text" name="settings[system][button_name]" value="{$aSystem.button_name}" class="input-text input-width-200">
				</label>
			</p>
		</div>
		<div id="setting-sys-container">
			{assign var="aDeactivate" value=$_aSettings.deactivate}
			<h3>{$aLang.plugin.feedback.acp_sys_deactivate}</h3>
			<p>
				<label>
					<input type="checkbox" class="input-checkbox" name="settings[deactivate][delete]" id="deactivate_delete" value="1"{if $aDeactivate.delete} checked{/if}>
					{$aLang.plugin.feedback.acp_sys_deactivate_delete}
				</label>
			</p>
		</div>
	</div>

	<div class="wrapper-content">
		<button type="submit" name="submit_feedback_settings" class="button button-primary">{$aLang.plugin.feedback.acp_save}</button>
	</div>
</form>

{include file='footer.tpl'}