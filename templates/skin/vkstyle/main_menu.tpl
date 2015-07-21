{if $oConfig->GetValue('plugin.feedback.system.button_name')}
	{assign var="sFeedbackButtonTitle" value=$oConfig->GetValue('plugin.feedback.system.button_name')}
{else}
	{assign var="sFeedbackButtonTitle" value=$aLang.plugin.feedback.button}
{/if}
<li {if $sMenuHeadItemSelect=='feedback'}class="active"{/if}>
	<a href="{router page='feedback'}"{if $oConfig->GetValue('plugin.feedback.system.popup')} class="js-feedback-window-show"{/if}>
		<div class="icon">
			<span class="font-icon-bullhorn color-tm-1"></span>
			<span class="text">{$sFeedbackButtonTitle}</span>
		</div>
	</a>
</li>
