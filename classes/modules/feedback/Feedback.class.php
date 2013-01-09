<?
/*---------------------------------------------------------------------------
* @Module Name: Feedback
* @Description: Feedback for LiveStreet
* @Version: 2.0
* @Author: Chiffa
* @LiveStreet Version: 1.X
* @File Name: Feedback.class.php
* @License: CC BY-NC, http://creativecommons.org/licenses/by-nc/3.0/
*----------------------------------------------------------------------------
*/

/**
 * Модуль Feedback - обратная связь
 *
 */
class PluginFeedback_ModuleFeedback extends ModuleORM {
	const ERROR_NOT_MAILS		= 100;
	const ERROR_IN_BLACKLIST	= 201;
	const ERROR_IN_TIMELIMIT	= 202;

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
			 * Проверяем IP по спискам
			 */
			$bInBlackList = false;
			$bInWhiteList = false;
			$aIpList = $this->PluginFeedback_Feedback_GetIpItemsAll();
			foreach ($aIpList as $oIp) {
				$iChekIp = ip2int($oMsg->getIp());
				$iFromIp = $oIp->getIpFrom();
				$iToIp = $oIp->getIpTo();
				if ($iChekIp >= $iFromIp && $iChekIp <= $iToIp) {
				//if (bound($iChekIp, $iFromIp, $iToIp)) {
					$bInBlackList = (bool)($oIp->getGroup() == 'black');
					$bInWhiteList = (bool)($oIp->getGroup() == 'white');
				}
			}
			if ($bInBlackList) {
				return array('state'=>false,'code'=>self::ERROR_IN_BLACKLIST);
			}
			if (!$this->CanWrite() && !$bInWhiteList) {
				return array('state'=>false,'code'=>self::ERROR_IN_TIMELIMIT);
			}
			/**
			 * Собираем данные
			 */
			$sSendTitle = $oMsg->getTitle() ? $oMsg->getTitle() : $this->Lang_Get('plugin.feedback.notify_title');
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
			if (!$bInWhiteList) {
				$iTimeLimit = (int)Config::Get('plugin.feedback.acl.limit_time');
				fSetCookie('CfFB', md5(func_getIp()), 0, 0, 0, $iTimeLimit);
			}
			$aRes['state'] = true;
		} else {
			$aRes['state'] = false;
			$aRes['code'] = self::ERROR_NOT_MAILS;
		}
		return $aRes;
	}

	/**
	 * Проверяет возможность написать
	 *
	 */
	public function CanWrite() {
		$sCookieIp=fGetCookie('CfFB');
		return (bool)($sCookieIp != md5(func_getIp()));
	}
}
?>