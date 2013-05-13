{if $oConfig->GetValue('plugin.feedback.system.button_name')}
	{assign var="sFeedbackButtonTitle" value=$oConfig->GetValue('plugin.feedback.system.button_name')}
{else}
	{assign var="sFeedbackButtonTitle" value=$aLang.plugin.feedback.button}
{/if}
<li {if $sMenuHeadItemSelect=='feedback'}class="active"{/if}>
	{if $oConfig->GetValue('plugin.feedback.system.popup')}
		<a href="{router page='feedback'}" class="js-feedback-window-show">{$sFeedbackButtonTitle}</a>
	{else}
		<a href="{router page='feedback'}">{$sFeedbackButtonTitle}</a>
	{/if}
</li>
