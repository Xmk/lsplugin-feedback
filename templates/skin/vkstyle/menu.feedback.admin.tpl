<nav class="sub-menu" role="sub-menu">
	<a href="#" id="pull"><span class="font-icon-reorder"></span></a>
	<ul>
		<li><a href="{router page='feedback'}admin/" {if $sMenuSubItemSelect=='main'} class="active"{/if}>{$aLang.plugin.feedback.acp_menu_main}</a></li>
		<li><a href="{router page='feedback'}admin/filter/" {if $sMenuSubItemSelect=='filter'} class="active"{/if}>{$aLang.plugin.feedback.acp_menu_filter}</a></li>
		{hook run='menu_feedback_admin_item'}
		{hook run='menu_feedback_admin'}
	</ul>
</nav>