<?php
/*---------------------------------------------------------------------------
* @Module Name: Feedback
* @Description: Feedback for LiveStreet
* @Version: 2.0
* @Author: Chiffa
* @LiveStreet Version: 1.X
* @File Name: Msg.entity.class.php
* @License: CC BY-NC, http://creativecommons.org/licenses/by-nc/3.0/
*----------------------------------------------------------------------------
*/

/**
 * Объект сущности письма
 *
 */
class PluginFeedback_ModuleFeedback_EntityMsg extends Entity {
	/**
	 * Определяем правила валидации
	 *
	 * @var array
	 */
	protected $aValidateRules=array(
		array('mail','email','allowEmpty'=>false),
		array('captcha','captcha'),
		array('ip','time_limit')
	);

	public function Init() {
		parent::Init();
		$this->aValidateRules[]=array('name','string','allowEmpty'=>!Config::Get('plugin.feedback.field.name'),'min'=>3,'max'=>30);
		$this->aValidateRules[]=array('title','string','allowEmpty'=>!Config::Get('plugin.feedback.field.title'),'min'=>3,'max'=>100);
        //
        $this->aValidateRules[]=array('text','string',
            'allowEmpty'=>false,
            'min'=> null !== Config::Get('plugin.feedback.acl.msg_text_min') ? Config::Get('plugin.feedback.acl.msg_text_min') : 10,
            'max'=> null !== Config::Get('plugin.feedback.acl.msg_text_max') ? Config::Get('plugin.feedback.acl.msg_text_max') : 3000,
        );
        if (Config::Get('plugin.feedback.acl.check_exists')) {
            $this->aValidateRules[]=array('mail','mail_exists');
        }
    }

	/**
	 * Проверка на ограничение по времени
	 *
	 * @param string $sValue	Проверяемое значение
	 * @param array $aParams	Параметры
	 * @return bool|string
	 */
	public function ValidateTimeLimit($sValue,$aParams) {
		if ($this->PluginFeedback_Feedback_CanWrite()) {
			return true;
		}
		return $this->Lang_Get('plugin.feedback.send_spam_error');
	}

    /**
     * Проверка email на существование
     *
     * @param string $sValue	Проверяемое значение
     * @param array $aParams	Параметры
     * @return bool|string
     */
    public function ValidateMailExists($sValue,$aParams) {
        if ($this->Mail_SmtpCheckMail($sValue)) {
            return true;
        }
        return $this->Lang_Get('plugin.feedback.send_mail_exists_error', array('email'=>$sValue));
    }
}
?>