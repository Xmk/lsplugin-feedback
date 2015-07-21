{include file='header.tpl'}

{include file="$sTemplatePathPlugin/menu.feedback.admin.tpl"}

<div class="container">
	<div class="row">
		<div class="width-12">
			<h2 class="title-5"><a href="{router page='feedback'}">{$aLang.plugin.feedback.feedback}</a> <span>&raquo;</span> {$aLang.plugin.feedback.acp_filter}</h2>
		</div>
	</div>


	<div class="wrapper-content wrapper-content-dark">
		<form id="ip-form" method="POST" enctype="multipart/form-data">
			<div class="row">
				<div class="width-12">
					<label for="filter_type">{$aLang.plugin.feedback.acp_ip_add} <select id="filter_type" name="filter_type" class="input-text input-width-200">
						<option value="white"{if $_aRequest.filter_type == 'white'} selected{/if}>{$aLang.plugin.feedback.acp_white_list}</option>
						<option value="black"{if $_aRequest.filter_type == 'black'} selected{/if}>{$aLang.plugin.feedback.acp_black_list}</option>
					</select></label>
				</div>
			</div>

			
				<div class="row">
					<div class="width-6">
						<div class="ip-block">
							<label for="filter_ip1_1">{$aLang.plugin.feedback.acp_ip_add_from}:</label>
							<input type="text" id="filter_ip1_1" name="filter_ip[1][1]" value="{$_aRequest.filter_ip[1][1]}" size="30" maxlength="3" class="input-text input-feedback-ip js-cp" /> .
							<input type="text" id="filter_ip1_2" name="filter_ip[1][2]" value="{$_aRequest.filter_ip[1][2]}" size="30" maxlength="3" class="input-text input-feedback-ip js-cp" /> .
							<input type="text" id="filter_ip1_3" name="filter_ip[1][3]" value="{$_aRequest.filter_ip[1][3]}" size="30" maxlength="3" class="input-text input-feedback-ip js-cp" /> .
							<input type="text" id="filter_ip1_4" name="filter_ip[1][4]" value="{$_aRequest.filter_ip[1][4]}" size="30" maxlength="3" class="input-text input-feedback-ip js-cp" />
						</div>
						<div class="ip-block">
							<label for="filter_ip2_1">{$aLang.plugin.feedback.acp_ip_add_to}: <input type="checkbox" class="input-checkbox" value="1" onchange="ls.feedback.admin.copyWriterEnabler(this.checked)"></input></label>
							<input type="text" id="filter_ip2_1" name="filter_ip[2][1]" value="{$_aRequest.filter_ip[2][1]}" size="30" maxlength="3" class="input-text input-feedback-ip" /> .
							<input type="text" id="filter_ip2_2" name="filter_ip[2][2]" value="{$_aRequest.filter_ip[2][2]}" size="30" maxlength="3" class="input-text input-feedback-ip" /> .
							<input type="text" id="filter_ip2_3" name="filter_ip[2][3]" value="{$_aRequest.filter_ip[2][3]}" size="30" maxlength="3" class="input-text input-feedback-ip" /> .
							<input type="text" id="filter_ip2_4" name="filter_ip[2][4]" value="{$_aRequest.filter_ip[2][4]}" size="30" maxlength="3" class="input-text input-feedback-ip" />
						</div>
					</div>
				
					<div class="width-6">
						<div class="form-group">
							<label for="filter_comment">{$aLang.plugin.feedback.acp_ip_add_comment}</label>
							<input type	="text" id="filter_comment" name="filter_comment" value="" class="input-text">
						</div>
						<button type="button" onclick="return ls.feedback.admin.applyIpForm('ip-form')" class="button button-primary">{$aLang.plugin.feedback.acp_ip_add_submit}</button>
					</div>
			</div>
		</form>
	</div>

	<div class="row">
		<div class="wrapper-content width-6" style="width:45%">
			<h3 class="title-5 margin-5">{$aLang.plugin.feedback.acp_black_list}</h3>

			<ul class="iplist" id="ip_black_list">
				{if $aBlackList}
					{foreach from=$aBlackList item=oBlack}
						{include file="$sTemplatePathPlugin/filter_ip_inlist.tpl" oIpItem=$oBlack}
					{/foreach}
				{/if}
				<li id="ip_black_empty" {if $aBlackList}style="display:none"{/if}>{$aLang.plugin.feedback.acp_black_list_empty}</li>
			</ul>
		</div>

		<div class="wrapper-content width-6" style="width:45%">
			<h3 class="title-5 margin-5">{$aLang.plugin.feedback.acp_white_list}</h3>

			<ul class="iplist" id="ip_white_list">
				{if $aWhiteList}
					{foreach from=$aWhiteList item=oWhite}
						{include file="$sTemplatePathPlugin/filter_ip_inlist.tpl" oIpItem=$oWhite}
					{/foreach}
				{/if}
				<li id="ip_white_empty" {if $aWhiteList}style="display:none"{/if}>{$aLang.plugin.feedback.acp_white_list_empty}</li>
			</ul>
		</div>
	</div>

</div>

{include file='footer.tpl'}