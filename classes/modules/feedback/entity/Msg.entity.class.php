<?
/*---------------------------------------------------------------------------
* @Module Name: Feedback
* @Description: Feedback for LiveStreet
* @Version: 2.0
* @Author: Chiffa
* @LiveStreet Version: 1.0
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
		array('name','string','allowEmpty'=>false,'min'=>3,'max'=>30),
		array('mail','email','allowEmpty'=>false),
		array('title','string','allowEmpty'=>false,'min'=>3,'max'=>100),
		array('text','string','allowEmpty'=>false,'min'=>10,'max'=>3000),
		array('captcha','captcha'),
		array('ip','time_limit')
	);

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
}
?>