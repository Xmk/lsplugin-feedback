<li id="ip_{$oIpItem->getId()}">
	<div class="iplist_actions">
		<a href="javascript:ls.feedback.admin.deleteIp('{$oIpItem->getHash()}')" title="" class="icon-remove">
			<span class="font-icon-remove-sign"></span>
		</a>
	</div>
	<span class="iplist_ip">{$oIpItem->getFromLong()|escape:"html"}</span> -
	<span class="iplist_ip">{$oIpItem->getToLong()|escape:"html"}</span>
	{if $oIpItem->getComment()}
		<div class="iplist_comment help-block error margin-0">{$oIpItem->getComment()|escape:"html"}</div>
	{/if}
</li>