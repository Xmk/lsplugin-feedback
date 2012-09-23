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
	const ERROR_NOT_MAILS	= 100;

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
		parent::Init();
		/**
		 * Получаем объект текущего юзера
		 */
		$this->oUserCurrent=$this->User_GetUserCurrent();
	}

	public function GetSettings($bGroup=0) {
		$aRes = array();
		$aSets = $this->GetSettingItemsAll();
		foreach ($aSets as $oSet) {
			if ($bGroup) {
				$aRes[$oSet->getGroup()][]=$oSet;
			} else {
				$aKeys=explode('.',$oSet->getKey());
				$sEval='$aRes';
				foreach ($aKeys as $sK) {
					$sEval.='['.var_export((string)$sK,true).']';
				}
				$sEval.='=$oSet->getValue();';
				eval($sEval);
			}
		}
		return $aRes;
	}

	public function SetSettings($aSets) {
		if (!is_array($aSets)) {
			return false;
		}
		$aSettings = $this->GetSettings(1);

		foreach ($aSets as $sGroup=>$aItems) {
			//delete all old sets on this group
			foreach ($aSettings[$sGroup] as $oSet) {
				$oSet->Delete();
			}
			//unique
			$aItems = array_unique($aItems);
			//save new sets
			foreach ($aItems as $sKey=>$sValue) {
				$oSet=LS::Ent('PluginFeedback_Feedback_Setting');
				$oSet->setGroup($sGroup);
				$oSet->setKey((string)$sGroup.'.'.$sKey);
				$oSet->setValue($sValue);
				$oSet->Save();
			}
		}
		return true;
	}

	/**
	 * Отправка письма
	 */
	public function Send($oMsg) {
		$aRes = array();

		$aMails = Config::Get('plugin.feedback.mail');

		if (!empty($aMails)) {
			/**
			 * Собираем данные
			 */
			$sSendTitle = ($oMsg->getTitle() || $this->Lang_Get('plugin.feedback.notify_title'));
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

			$iTimeLimit = (int)Config::Get('plugin.feedback.acl.limit_time');
			fSetCookie('feedback', 1, 0, 0, 0, $iTimeLimit);

			$aRes['state']=true;
		} else {
			$aRes['state']=false;
			$aRes['code']=self::ERROR_NOT_MAILS;
		}
		return $aRes;
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