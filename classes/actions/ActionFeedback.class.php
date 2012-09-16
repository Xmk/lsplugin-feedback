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
		$this->AddEvent('index','EventIndex');
		$this->AddEvent('admin','EventAdmin');
	}


	private function CanWrite() {
		return !isset($_COOKIE['feedback']);
	}

	/**********************************************************************************
	 ************************ РЕАЛИЗАЦИЯ ЭКШЕНА ***************************************
	 **********************************************************************************
	 */

	/**
	 * Показывает и обрабатывает страничку обратной связи
	 */
	protected function EventIndex() {
		if (!isPost('submit_feedback')) {
			return false;
		}
		/**
		 * Проверка - разрешено ли писать по времени
		 */
		if (!$this->CanWrite()) {
			$this->Message_AddErrorSingle($this->Lang_Get('plugin.feedback.send_spam_error'), $this->Lang_Get('error'));
			return;
		}
		/**
		 * Создаем объект письма
		 */
		$oMsg=LS::Ent('PluginFeedback_Feedback_Msg');
		/**
		 * Заполняем поля (данные)
		 */
		$oMsg->setName(getRequest('send_name'));
		$oMsg->setMail(getRequest('send_mail'));
		$oMsg->setTitle(getRequest('send_title'));
		$oMsg->setText($this->Text_Parser(getRequest('send_text')));
		$oMsg->setCaptcha(getRequest('send_captcha'));
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
			if ($this->PluginFeedback_Feedback_Send($oMsg)) {
				$this->Hook_Run('feedback_send_after', array('oMsg'=>$oMsg));

				$this->Message_AddNoticeSingle($this->Lang_Get('plugin.feedback.send_ok'));
			} else {
				$this->Message_AddErrorSingle($this->Lang_Get('system_error'));
			}
		} else {
			/**
			 * Получаем ошибки
			 */
			$this->Message_AddErrorSingle($oMsg->_getValidateError());
		}
	}

	/**
	 * Показывает и обрабатывает админку
	 */
	protected function EventAdmin() {
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