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
		$this->AddEventPreg('/^ajax$/i','/^validate$/','EventAjaxValidate');
		$this->AddEventPreg('/^ajax$/i','/^send$/','EventAjaxSend');
	}

	/**********************************************************************************
	 ************************ РЕАЛИЗАЦИЯ ЭКШЕНА ***************************************
	 **********************************************************************************
	 */

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
				unset($_SESSION['captcha_keystring']);
				/**
				 * Выводим уведомление
				 */
				$this->Message_AddNoticeSingle($this->Lang_Get('plugin.feedback.send_ok'));
			} else {
				$aLangErr = '';
				switch ($aResult['code']) {
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
		 * Подключаем JS
		 */
		$this->Viewer_AppendScript($this->getTemplatePathPlugin().'js/feedback.admin.js');
		/**
		 * Была ли отправлена форма с данными
		 */
		if (isPost('submit_feedback_settings')) {
			$aData=array();
			foreach (array('mail','acl','field','title') as $sGroup) {
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
		$this->Viewer_Assign('sTemplatePathPlugin',rtrim($this->getTemplatePathPlugin(),'/'));
	}
}
?>