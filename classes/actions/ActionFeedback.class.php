<?
/*---------------------------------------------------------------------------
* @Module Name: Feedback
* @Description: Feedback for LiveStreet
* @Version: 2.0
* @Author: Chiffa
* @LiveStreet Version: 1.0
* @File Name: ActionFeedback.class.php
* @License: CC BY-NC, http://creativecommons.org/licenses/by-nc/3.0/
*----------------------------------------------------------------------------
*/

class PluginFeedback_ActionFeedback extends ActionPlugin {
	/**
	 * Главное меню
	 *
	 * @var string
	 */
	protected $sMenuHeadItemSelect='feedback';
	/**
	 * Меню
	 *
	 * @var string
	 */
	protected $sMenuItemSelect='main';
	/**
	 * Подменю
	 *
	 * @var string
	 */
	protected $sMenuSubItemSelect='';

	/**
	 * Инизиализация экшена
	 */
	public function Init() {
		/**
		 * Меню
		 */
		$this->Viewer_AddMenu('feedback',$this->getTemplatePathPlugin().'menu.feedback.tpl');
		/**
		 * Заголовок
		 */
		$this->Viewer_AddHtmlTitle($this->Lang_Get('plugin.feedback.feedback'));
		/**
		 * Дефолтный эвент
		 */
		$this->SetDefaultEvent('index');
	}

	/**
	 * Регистрируем евенты
	 *
	 */
	protected function RegisterEvent() {
		/**
		 * Админка
		 */
		$this->AddEvent('admin','EventAdmin');
		/**
		 * Пользовательская часть
		 */
		$this->AddEvent('index','EventIndex');
		/**
		 * AJAX Обработчики
		 */
		$this->AddEventPreg('/^ajax$/i','/^addip$/','EventAjaxAddip');
		$this->AddEventPreg('/^ajax$/i','/^deleteip$/','EventAjaxDeleteip');
		$this->AddEventPreg('/^ajax$/i','/^validate$/','EventAjaxValidate');
		$this->AddEventPreg('/^ajax$/i','/^send$/','EventAjaxSend');
	}

	/**********************************************************************************
	 ************************ РЕАЛИЗАЦИЯ ЭКШЕНА ***************************************
	 **********************************************************************************
	 */

	/**
	 * Добавление IP
	 *
	 */
	protected function EventAjaxAddip() {
		/**
		 * Устанавливаем формат Ajax ответа
		 */
		$this->Viewer_SetResponseAjax('json');
		/**
		 * Читаем параметры
		 */
		$aIPs=getRequest('filter_ip',array());

		$sIP1=implode('.',$aIPs[1]);
		if (!isset($aIPs[2])) $aIPs[2] = $aIPs[1];
		$sIP2=implode('.',$aIPs[2]);
		/**
		 * Проверка на корректность
		 */
		if (!(ip2long($sIP1) && ip2long($sIP2))) {
			$this->Message_AddErrorSingle($this->Lang_Get('plugin.feedback.acp_ip_add_error'),$this->Lang_Get('error'));
			return false;
		}
		/**
		 * Создаем объект
		 */
		$oIp=LS::Ent('PluginFeedback_Feedback_Ip');
		$oIp->setGroup(getRequest('filter_type'));
		$oIp->setComment(getRequest('filter_comment'));
		$oIp->setFrom(ip2int($sIP1));
		$oIp->setTo(ip2int($sIP2));
		/**
		 * Код
		 */
		require_once Config::Get('path.root.engine').'/lib/external/XXTEA/encrypt.php';
		$sCode=rawurlencode(base64_encode(xxtea_encrypt($sIP1.'_'.$sIP2, Config::Get('plugin.feedback.encrypt'))));
		$oIp->setHash($sCode);
		/**
		 * Сохраняем
		 */
		if (!$oIp->Save()) {
			$this->Message_AddErrorSingle($this->Lang_Get('system_error'),$this->Lang_Get('error'));
			return false;
		}
		/**
		 * Рендерим шаблон
		 */
		$oViewer=$this->Viewer_GetLocalViewer();
		$oViewer->Assign('oIpItem',$oIp);
		$sTextResult=$oViewer->Fetch($this->getTemplatePathPlugin().'filter_ip_inlist.tpl');
		/**
		 * Передаем результат в ajax ответ
		 */
		$this->Viewer_AssignAjax('sType',$oIp->getGroup());
		$this->Viewer_AssignAjax('sText',$sTextResult);
		$this->Message_AddNoticeSingle($this->Lang_Get('plugin.feedback.acp_save_ok'));
		return true;
	}
	/**
	 * Удаление IP
	 *
	 */
	protected function EventAjaxDeleteip() {
		/**
		 * Устанавливаем формат Ajax ответа
		 */
		$this->Viewer_SetResponseAjax('json');
		/**
		 * Читаем параметры
		 */
		$sHash=getRequest('hash');
		/**
		 * Декодируем хэш
		 */
		require_once Config::Get('path.root.engine').'/lib/external/XXTEA/encrypt.php';
		$aIps=xxtea_decrypt(base64_decode(rawurldecode($sHash)),Config::Get('plugin.feedback.encrypt'));
		if (!$aIps) {
			$this->Message_AddErrorSingle($this->Lang_Get('plugin.feedback.acp_ip_del_error'),$this->Lang_Get('error'));
			return;
		}
		list($sIpFrom,$sIpTo)=explode('_',$aIps);
		/**
		 * Получаем объект IP
		 */
		if (!($oIp=$this->PluginFeedback_Feedback_GetIpByFromAndTo(ip2int($sIpFrom),ip2int($sIpTo)))) {
			$this->Message_AddErrorSingle($this->Lang_Get('system_error'),$this->Lang_Get('error'));
			return false;
		}
		/**
		 * Удаляем
		 */
		$sId=$oIp->getId();
		$oIp->Delete();
		/**
		 * Передаем результат в ajax ответ
		 */
		$this->Viewer_AssignAjax('sId',$sId);
		$this->Message_AddNoticeSingle($this->Lang_Get('plugin.feedback.acp_ip_del_ok'));
		return true;
	}

	/**
	 * Ajax валидация формы
	 *
	 */
	protected function EventAjaxValidate() {
		/**
		 * Устанавливаем формат Ajax ответа
		 */
		$this->Viewer_SetResponseAjax('json');
		/**
		 * Создаем объект сообщения
		 */
		$oMsg=LS::Ent('PluginFeedback_Feedback_Msg');
		/**
		 * Пробегаем по переданным полям/значениям и валидируем их каждое в отдельности
		 */
		$aFields=getRequest('fields');
		if (is_array($aFields)) {
			foreach($aFields as $aField) {
				if (isset($aField['field']) and isset($aField['value'])) {
					/**
					 * Запускаем хук
					 */
					$this->Hook_Run('feedback_validate_field', array('aField'=>&$aField));

					$sField=$aField['field'];
					$sValue=$aField['value'];
					/**
					 * Список полей для валидации
					 */
					switch($sField){
						case 'name':
							$oMsg->setName($sValue);
							break;
						case 'mail':
							$oMsg->setMail($sValue);
							break;
						case 'title':
							$oMsg->setTitle($sValue);
							break;
						case 'text':
							$oMsg->setText($sValue);
							break;
						case 'captcha':
							$oMsg->setCaptcha($sValue);
							break;
						default:
							continue;
							break;
					}
					/**
					 * Валидируем поле
					 */
					$oMsg->_Validate(array($sField),false);
				}
			}
		}
		/**
		 * Возникли ошибки?
		 */
		if ($oMsg->_hasValidateErrors()) {
			/**
			 * Получаем ошибки
			 */
			$this->Viewer_AssignAjax('aErrors',$oMsg->_getValidateErrors());
		}
	}
	/**
	 * Обработка Ajax регистрации
	 */
	protected function EventAjaxSend() {
		/**
		 * Устанавливаем формат Ajax ответа
		 */
		$this->Viewer_SetResponseAjax('json');
		/**
		 * Создаем объект письма
		 */
		$oMsg=LS::Ent('PluginFeedback_Feedback_Msg');
		/**
		 * Заполняем поля (данные)
		 */
		$oMsg->setName(getRequest('name'));
		$oMsg->setMail(getRequest('mail'));
		$oMsg->setTitle(getRequest('title'));
		$oMsg->setText($this->Text_Parser(getRequest('text')));
		$oMsg->setCaptcha(getRequest('captcha'));
		$oMsg->setIp(func_getIp());
		$oMsg->setDate(date("Y-m-d H:i:s"));
		/**
		 * Запускаем хук
		 */
		$this->Hook_Run('feedback_validate_before', array('oMsg'=>$oMsg));
		/**
		 * Запускаем валидацию
		 */
		if ($oMsg->_Validate()) {
			$this->Hook_Run('feedback_validate_after', array('oMsg'=>$oMsg));
			$aResult=$this->PluginFeedback_Feedback_Send($oMsg);
			if ($aResult['state']) {
				$this->Hook_Run('feedback_send_after', array('oMsg'=>$oMsg));
				/**
				 * Убиваем каптчу
				 */
				unset($_SESSION['captcha']);
				/**
				 * Выводим уведомление
				 */
				$this->Message_AddNoticeSingle($this->Lang_Get('plugin.feedback.send_ok'));
			} else {
				$aLangErr = '';
				switch ($aResult['code']) {
					case PluginFeedback_ModuleFeedback::ERROR_IN_BLACKLIST:
						$aLangErr='plugin.feedback.send_in_blacklist';
						break;
					case PluginFeedback_ModuleFeedback::ERROR_IN_TIMELIMIT:
						$aLangErr='plugin.feedback.send_spam_error';
						break;
					case PluginFeedback_ModuleFeedback::ERROR_NOT_MAILS:
					default:
						$aLangErr='system_error';
						break;
				}
				$this->Message_AddErrorSingle($this->Lang_Get($aLangErr));
			}
		} else {
			/**
			 * Получаем ошибки
			 */
			$this->Viewer_AssignAjax('aErrors',$oMsg->_getValidateErrors());
		}
	}

	/**
	 * Показывает страничку обратной связи
	 *
	 */
	protected function EventIndex() {

	}

	/**
	 * Показывает и обрабатывает админку
	 */
	protected function EventAdmin() {
		if (!LS::Adm()) {
			return parent::EventNotFound();
		}
		/**
		 * Меню
		 */
		$this->sMenuItemSelect='admin';
		/**
		 * Подключаем JS
		 */
		$this->Viewer_AppendScript($this->getTemplatePathPlugin().'js/feedback.admin.js');

		$sCategory=$this->GetParam(0);
		$sAction=$this->GetParam(1);

		/**
		 * Раздел админки
		 */
		switch ($sCategory) {
			case 'filter':
				return $this->_adminEventFilter();
			case null:
				return $this->_adminEventMain();
			default:
				return parent::EventNotFound();
		}
	}
	/**
	 * Главная страница админцентра
	 */
	protected function _adminEventMain() {
		$this->sMenuSubItemSelect='main';
		/**
		 * Была ли отправлена форма с данными
		 */
		if (isPost('submit_feedback_settings')) {
			$aData=array();
			foreach (array('mail','acl','field','title','deactivate') as $sGroup) {
				$aData[$sGroup]=array();
				foreach (getRequest($sGroup,array(),'post') as $sKey=>$sItem) {
					$sItem=trim((string)$sItem);
					if ($sItem) {
						$aData[$sGroup][(string)$sKey]=$sItem;
					}
				}
			}
			if ($this->PluginFeedback_Feedback_SetSettings($aData)) {
				$this->Message_AddNotice($this->Lang_Get('plugin.feedback.acp_save_ok'),null,1);
				Router::Location(Router::GetPath('feedback').'admin/');
			} else {

			}
		} else {
			$aSettings=$this->PluginFeedback_Feedback_GetSettings();
			foreach ($aSettings as $sKey=>$sValue) {
				$_REQUEST[$sKey]=$sValue;
			}
		}
		/**
		 * Устанавливаем шаблон вывода
		 */
		$this->SetTemplateAction('admin/main');
	}
	/**
	 * Списки фильтров
	 */
	protected function _adminEventFilter() {
		$this->sMenuSubItemSelect='filter';
		/**
		 * Была ли отправлена форма с данными
		 */
		$aIpList=$this->PluginFeedback_Feedback_GetIpItemsAll();
		$aSortList=array('white'=>array(),'black'=>array());
		foreach ($aIpList as $oIp) {
			$aSortList[$oIp->getGroup()][]=$oIp;
		}
		$this->Viewer_Assign('aWhiteList',$aSortList['white']);
		$this->Viewer_Assign('aBlackList',$aSortList['black']);
		/**
		 * Устанавливаем шаблон вывода
		 */
		$this->SetTemplateAction('admin/filter');
		/**
		 * Загружаем в шаблон JS текстовки
		 */
		$this->Lang_AddLangJs(
			array(
				'plugin.feedback.acp_ip_del_confirm'
			)
		);
	}


	/**
	 * Завершение работы экшена
	 */
	public function EventShutdown() {
		/**
		 * Загружаем в шаблон необходимые переменные
		 */
		$this->Viewer_Assign('menu','feedback');
		$this->Viewer_Assign('sMenuHeadItemSelect',$this->sMenuHeadItemSelect);
		$this->Viewer_Assign('sMenuItemSelect',$this->sMenuItemSelect);
		$this->Viewer_Assign('sMenuSubItemSelect',$this->sMenuSubItemSelect);
		$this->Viewer_Assign('sTemplatePathPlugin',rtrim($this->getTemplatePathPlugin(),'/'));
	}
}
?>