<ul class="nav nav-pills">
	<li{if $sMenuSubItemSelect=='main'} class="active"{/if}><a href="{router page='feedback'}admin/"><div>{$aLang.plugin.feedback.acp_menu_main}</div></a></li>
	<li{if $sMenuSubItemSelect=='filter'} class="active"{/if}><a href="{router page='feedback'}admin/filter/"><div>{$aLang.plugin.feedback.acp_menu_filter}</div></a></li>
 
	{hook run='menu_feedback_admin_item'}
	{hook run='menu_feedback_admin'}
</ul>