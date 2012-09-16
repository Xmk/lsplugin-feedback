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
	 */
	public function Init() {
		parent::Init();
		$this->aValidateRules[]=array('name','string','allowEmpty'=>false,'min'=>3,'max'=>30,'label'=>$this->Lang_Get('plugin.feedback.send_name'));
		$this->aValidateRules[]=array('mail','email','allowEmpty'=>false,'label'=>$this->Lang_Get('plugin.feedback.send_mail'));
		$this->aValidateRules[]=array('title','string','allowEmpty'=>false,'min'=>3,'max'=>100,'label'=>$this->Lang_Get('plugin.feedback.send_title'));
		$this->aValidateRules[]=array('text','string','allowEmpty'=>false,'min'=>10,'max'=>3000,'label'=>$this->Lang_Get('plugin.feedback.send_text'));
		$this->aValidateRules[]=array('captcha','captcha','label'=>$this->Lang_Get('plugin.feedback.captcha'));
	}

}
?>