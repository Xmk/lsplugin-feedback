<div class="toolbar-feedback">
	{if $oConfig->GetValue('plugin.feedback.system.popup')}
		<a href="{router page='feedback'}" class="js-feedback-window-show"><button class="button button-feedback"><i class="icon-comment"></i> {$aLang.plugin.feedback.button}</button></a>
	{else}
		<a href="{router page='feedback'}"><button class="button button-feedback"><i class="icon-comment"></i> {$aLang.plugin.feedback.button}</button></a>
	{/if}
</div>
