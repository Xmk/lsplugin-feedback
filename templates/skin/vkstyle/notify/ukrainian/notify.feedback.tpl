{if $sName}
<strong>Ім'я користувача:</strong> {$sName|escape:'html'}<br/>
{/if}
<strong>Зворотня адреса:</strong> {$sMail|escape:'html'}<br/>
<br/>
<strong>IP адреса, з якої було відправлено цей лист:</strong><br/>
{$sIp}
<br/>
<br/>
<strong>Текст повідомлення:</strong><br/>
{$sText}
<br/>
<br/>