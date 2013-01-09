<li id="ip_{$oIpItem->getId()}">
	<div class="iplist_actions">
		<a href="javascript:ls.feedback.admin.deleteIp('{$oIpItem->getHash()}')" title="" class="icon-remove"></a>
	</div>
	<span class="iplist_ip">{$oIpItem->getFromLong()|escape:"html"}</span> -
	<span class="iplist_ip">{$oIpItem->getToLong()|escape:"html"}</span>
	{if $oIpItem->getComment()}
		<div class="iplist_comment">{$oIpItem->getComment()|escape:"html"}</div>
	{/if}
</li>