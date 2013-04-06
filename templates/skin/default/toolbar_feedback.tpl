{if $oConfig->GetValue('plugin.feedback.system.button_name')}
	{assign var="sFeedbackButtonTitle" value=$oConfig->GetValue('plugin.feedback.system.button_name')}
{else}
	{assign var="sFeedbackButtonTitle" value=$aLang.plugin.feedback.button}
{/if}
<div class="toolbar-feedback">
    <noindex>
	{if $oConfig->GetValue('plugin.feedback.system.popup')}
		<a href="{router page='feedback'}" class="js-feedback-window-show" rel="nofollow"><button class="button button-feedback"><i class="icon-comment"></i> {$sFeedbackButtonTitle}</button></a>
	{else}
		<a href="{router page='feedback'}"><button class="button button-feedback" rel="nofollow"><i class="icon-comment"></i> {$sFeedbackButtonTitle}</button></a>
	{/if}
	</noindex>
</div>
