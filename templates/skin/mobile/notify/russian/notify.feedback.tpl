{if $sName}
<strong>Имя пользователя:</strong> {$sName|escape:'html'}<br/>
{/if}
<strong>Обратный адресс:</strong> {$sMail|escape:'html'}<br/>
<br/>
<strong>IP адресс, с которого было отправлено письмо:</strong><br/>
{$sIp}
<br/>
<br/>
<strong>Текст сообщения:</strong><br/>
{$sText}
<br/>
<br/>