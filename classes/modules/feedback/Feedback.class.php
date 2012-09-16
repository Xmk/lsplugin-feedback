<?
/*---------------------------------------------------------------------------
* @Module Name: Feedback
* @Description: Feedback for LiveStreet
* @Version: 2.0
* @Author: Chiffa
* @LiveStreet Version: 1.0
* @File Name: Feedback.class.php
* @License: CC BY-NC, http://creativecommons.org/licenses/by-nc/3.0/
*----------------------------------------------------------------------------
*/

/**
 * Модуль Feedback - обратная связь
 *
 */
class PluginFeedback_ModuleFeedback extends ModuleORM {
	/**
	 * Объект текущего пользователя
	 *
	 * @var ModuleUser_EntityUser|null
	 */
	protected $oUserCurrent;

	/**
	 * Инициализация
	 *
	 */
	public function Init() {
		$this->oUserCurrent=$this->User_GetUserCurrent();
	}

	/**
	 * Отправка письма
	 */
	public function Send($oMsg) {
		$aMails = Config::Get('plugin.feedback.mail');

		if (!is_array($aMails)) {
			$aMails = array($aMails);
		}

		/**
		 * Собираем данные
		 */
		$sSendTitle = $oMsg->getTitle();
		$aSendContent = array(
			'sIp' => $oMsg->getIp(),
			'sName' => $oMsg->getName(),
			'sMail' => $oMsg->getMail(),
			'sText' => $oMsg->getText()
		);

		/**
		 * Отправляем письмо
		 */
		foreach ($aMails as $sMail) {
			$this->Notify_Send(
				$sMail,
				'notify.feedback.tpl',
				$sSendTitle,
				$aSendContent,
				__CLASS__
			);
		}

		fSetCookie('feedback', 1, 0, 0, 0, Config::Get('plugin.feedback.acl_limit_time'));

		return true;
	}

	/**
	 * Проверяет возможность написать
	 *
	 */
	public function CanWrite() {
		return !fGetCookie('feedback');
	}
}
?>