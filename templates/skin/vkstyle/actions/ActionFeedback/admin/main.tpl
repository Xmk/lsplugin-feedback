{include file='header.tpl'}
{include file="$sTemplatePathPlugin/menu.feedback.admin.tpl"}

<div class="container">
	<div class="row">
		<div class="width-12">
			<h2 class="title-5"><a href="{router page='feedback'}">{$aLang.plugin.feedback.feedback}</a> <span>&raquo;</span> {$aLang.plugin.feedback.acp}</h2>
		</div>
	</div>
			
			{assign var="_aSettings" value=$_aRequest.settings}

			<form action="{router page='feedback'}admin/" method="post">
				<input type="hidden" name="security_ls_key" value="{$LIVESTREET_SECURITY_KEY}" />

				<div id="setting_mail_template" style="display:none" class="js-setting-mail-item row">
					<div class="width-12">
						<input type="text" name="settings[mail][]" value="" class="input-text input-width-200">
						<a class="icon-remove" title="{$aLang.plugin.feedback.acp_mail_delete}" href="#" onclick="return ls.feedback.admin.deleteMail(this)"></a>
					</div>
				</div>

				<div id="setting_title_template" style="display:none" class="js-setting-title-item row">
					<div class="width-12">
						<input type="text" name="settings[title][]" value="" class="input-text input-width-200">
						<a class="icon-remove" title="{$aLang.plugin.feedback.acp_title_delete}" href="#" onclick="return ls.feedback.admin.deleteTitle(this)"></a>
					</div>
				</div>

				<div class="wrapper-content wrapper-content-dark">
					<div class="row">
						<div class="width-12">
							<h3 class="title-5">{$aLang.plugin.feedback.acp_mails}</h3>
							<div class="help-block bg-success">{$aLang.plugin.feedback.acp_mails_note}</div>
						</div>
					</div>
					
					{assign var="aMails" value=$_aSettings.mail}

					<div id="setting-mail-container">
						<div class="row">
							<div class="width-12">
								{foreach from=$aMails item=sMail}
									<div class="js-setting-mail-item input-icon">
										
									        	<span class="font-icon-social-email btn"></span>
									          	<input type="text" name="settings[mail][]" value="{$sMail|escape:'html'}">
									          	<a href="#" class="font-icon-remove-sign btn js-infobox" title="{$aLang.plugin.feedback.acp_mail_delete}" onclick="return ls.feedback.admin.deleteMail(this)"></a>
									</div>
								{/foreach}
								<a href="#" onclick="return ls.feedback.admin.addFormMail()" class="button">{$aLang.plugin.feedback.acp_mail_add}</a>
							</div>
						</div>
					</div>
				</div>

				<div class="wrapper-content">
					<div class="row">
						<div class="width-12">
							<h3 class="title-5">{$aLang.plugin.feedback.acp_acl}</h3>
						</div>
					</div>
					{assign var="aAcl" value=$_aSettings.acl}

					<div class="row">
						<div class="width-12">
							<div id="setting-acl-container">
								<div class="form-group">
									<label for="acl_limit_time">{$aLang.plugin.feedback.acp_acl_time_limit}</label>
									<div class="input-icon">
							        	<span class="font-icon-dashboard btn"></span>
							        	<input type="text" id="acl_limit_time" name="settings[acl][limit_time]" value="{$aAcl.limit_time|escape:'html'}" placeholder="{$aLang.plugin.feedback.acp_acl_time_limit_note}">
							        </div>
								</div>
							</div>
							<div id="setting-acl-container">
								<p>
									<label for="acl_close_enable_yes">{$aLang.plugin.feedback.acp_acl_close_enable}</label>
									<label><input type="radio" class="radio" name="settings[acl][close_enable]" id="acl_close_enable_yes" value="1" {if $aAcl.limit_time}checked="checked"{/if} /> Yes</label>
									<label><input type="radio" class="radio" name="settings[acl][close_enable]" id="acl_close_enable_no" value="0" {if !$aAcl.limit_time}checked="checked"{/if} /> No</label>
								</p>
							</div>
						</div>
					</div>
				</div>

				<div class="wrapper-content wrapper-content-dark">
					<div class="row">
						<div class="width-12">
							<h3 class="title-5">{$aLang.plugin.feedback.acp_fields}</h3>
							<div class="help-block bg-success hidden">{$aLang.plugin.feedback.acp_fields_note}</div>
						</div>
					</div>
					{assign var="aFields" value=$_aSettings.field}

					<div class="row">
						<div class="width-12">
							<div id="setting-fields-container">
								<div class="form-group">
									<label for="field_name">{$aLang.plugin.feedback.acp_fields_name}</label>
									<label><input type="radio" class="radio" name="settings[field][name]" id="field_name_no" value="0" {if !$aFields.name}checked="checked"{/if} /> {$aLang.plugin.feedback.acp_field_hide}</label>
									<label><input type="radio" class="radio" name="settings[field][name]" id="field_name_yes" value="1" {if $aFields.name}checked="checked"{/if} /> {$aLang.plugin.feedback.acp_field_show}</label>
								</div>
							</div>
							<div id="setting-fields-container">
								<div class="form-group">
									<label for="field_title">{$aLang.plugin.feedback.acp_fields_title}</label>
									<label><input type="radio" class="radio" name="settings[field][title]" id="field_title_no" value="0" {if !$aFields.title}checked="checked"{/if} /> {$aLang.plugin.feedback.acp_field_hide}</label>
									<label><input type="radio" class="radio" name="settings[field][title]" id="field_title_input" value="1" {if $aFields.title == 1}checked="checked"{/if} /> {$aLang.plugin.feedback.acp_field_show} {$aLang.plugin.feedback.acp_field_input|lower}</label>
									<label><input type="radio" class="radio" name="settings[field][title]" id="field_title_list" value="2" {if $aFields.title == 2}checked="checked"{/if} /> {$aLang.plugin.feedback.acp_field_show} {$aLang.plugin.feedback.acp_field_list|lower}</label>
								</div>
							</div>
						</div>
					</div>
				</div>

				<div class="row">
				<div class="wrapper-content width-12"{if !$aFields.title || $aFields.title != 2} style="display:none"{/if}>
							<h3 class="title-5 margin-5">{$aLang.plugin.feedback.acp_titles}</h3>
							{assign var="aTitles" value=$_aSettings.title}

							<div id="setting-title-container">
							{foreach from=$aTitles item=sTitle}
								<div class="js-setting-title-item input-icon">
							        	<span class="font-icon-text-width btn"></span>
							          	<input type="text" name="settings[title][]" value="{$sTitle|escape:'html'}">
							          	<a class="font-icon-remove-sign btn js-infobox" title="{$aLang.plugin.feedback.acp_title_delete}" href="#" onclick="return ls.feedback.admin.deleteTitle(this)"></a>
								</div>
							{/foreach}
							</div>
							<a href="#" onclick="return ls.feedback.admin.addFormTitle()" class="button">{$aLang.plugin.feedback.acp_title_add}</a>
				</div>
				</div>

				<div class="wrapper-content wrapper-content-dark">
					<div class="row">
						<div class="width-12">
							<h3 class="title-5">{$aLang.plugin.feedback.acp_sys}</h3>
							<span class="help-block bg-success hidden">{$aLang.plugin.feedback.acp_sys_note}</span>
						</div>
					</div>

					<div class="row">
						<div class="width-12">
							<div id="setting-sys-container">
								{assign var="aSystem" value=$_aSettings.system}
								<div class="form-group">
									<label>
										<input type="checkbox" class="input-checkbox" name="settings[system][popup]" value="1" {if $aSystem.popup}checked="checked"{/if} />
										{$aLang.plugin.feedback.acp_sys_popup}
									</label>
								</div>
								<div class="form-group hidden"> {* Настройка скрыта, т.к. если ставить в тулбар кнопку будет не красиво. *}
									<label>
										<input type="checkbox" class="input-checkbox" name="settings[system][button]" value="1" {if $aSystem.button}checked="checked"{/if} />
										{$aLang.plugin.feedback.acp_sys_button}
									</label>
								</div>
								<div class="form-group">
									<label>{$aLang.plugin.feedback.acp_sys_button_name}</label>
									<div class="input-icon">
								        <span class="font-icon-flag btn"></span>
								        <input type="text" name="settings[system][button_name]" value="{$aSystem.button_name}">
							        </div>									
								</div>
							</div>
						</div>
					</div>

					<div class="row">
						<div class="width-12">
							<div id="setting-sys-container">
								{assign var="aDeactivate" value=$_aSettings.deactivate}
								<h3 class="title-5 margin-5">{$aLang.plugin.feedback.acp_sys_deactivate}</h3>
								<p>
									<label>
										<input type="checkbox" class="input-checkbox" name="settings[deactivate][delete]" id="deactivate_delete" value="1" {if $aDeactivate.delete}checked="checked"{/if} />
										{$aLang.plugin.feedback.acp_sys_deactivate_delete}
									</label>
								</p>
							</div>
						</div>
					</div>

				</div>

				<div class="wrapper-content">
					<div class="row">
						<div class="width-12">
							<button type="submit" name="submit_feedback_settings" class="button button-primary">{$aLang.plugin.feedback.acp_save}</button>
						</div>
					</div>
				</div>
			</form>
	</div>
</div>
{include file='footer.tpl'}