<?php

class PluginFeedback_ModuleMail extends PluginFeedback_Inherit_ModuleMail {
    /**
     * Устанавливает кому отвечать
     *
     * @param string $sAddress
     * @param string $sText
     */
    public function SetReplyTo($sAddress,$sName='') {
        $this->oMailer->ClearReplyTos();
        $this->oMailer->AddReplyTo($sAddress,$sName);
        $this->oMailer->Sender = $sAddress;
    }

    /**
     * Проверяет email на существование
     * @param $aMails
     */
    public function SmtpCheckMails($aMails, $sSender = null) {
        require_once(Plugin::GetPath(__CLASS__).'lib/mail/smtp_validateEmail.class.php');
        // instantiate the class
        $SMTP_Validator = new SMTP_validateEmail();
        // an optional sender
        $sSender = $sSender ? $sSender : Config::Get('sys.mail.from_email');
        // do the validation
        return $SMTP_Validator->validate((array)$aMails, $sSender);
    }

    /**
     * Проверяет один email на существование
     * @param $aMails
     */
    public function SmtpCheckMail($sMail, $sSender = null) {
        // do the validation
        $results = $this->SmtpCheckMails((array)$sMail,$sSender);
        if (isset($results[$sMail]) && $results[$sMail]) {
            return true;
        }
        return false;
    }
}
?>