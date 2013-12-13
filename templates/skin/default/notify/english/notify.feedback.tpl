{if $sName}
<strong>Username:</strong> {$sName|escape:'html'}<br/>
{/if}
<strong>Feedback:</strong> {$sMail|escape:'html'}<br/>
<br/>
<strong>IP address from which the message was sent:</strong><br/>
{$sIp}
<br/>
<br/>
<strong>Message:</strong><br/>
{$sText}
<br/>
<br/>