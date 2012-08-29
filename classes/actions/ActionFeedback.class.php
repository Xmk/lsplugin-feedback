<?
/*---------------------------------------------------------------------------
* @Module Name: Feedback
* @Description: Feedback for LiveStreet
* @Version: 1.2
* @Author: Chiffa
* @LiveStreet Version: 0.4.2
* @File Name: ActionFeedback.class.php
* @License: GNU GPL v2, http://www.gnu.org/licenses/old-licenses/gpl-2.0.html
*----------------------------------------------------------------------------
*/

class PluginFeedback_ActionFeedback extends ActionPlugin {

	/**
	 * Инизиализация экшена
	 */
	public function Init() {
		$this->Viewer_AddHtmlTitle($this->Lang_Get('feedback'));
		$this->SetDefaultEvent('index');
	}

	/**
	 * Регистрируем евенты
	 *
	 */
	protected function RegisterEvent() {
		$this->AddEvent('index','EventIndex');
	}


	private function ClearForm() {
		unset($_REQUEST);
		$_REQUEST = array();
	}
	private function CanWrite() {
		return !isset($_COOKIE['feedback']);
	}
	private function SetWrite() {
		SetCookie('feedback', 1, time()+Config::Get('plugin.feedback.acl_limit_time'));
	}

	/**********************************************************************************
	 ************************ РЕАЛИЗАЦИЯ ЭКШЕНА ***************************************
	 **********************************************************************************
	 */

	/**
	 * Показывает и обрабатывает страничку обратной связи
	 */
	protected function EventIndex() {
		if (!$this->checkFields()) {
			return false;
		}

		$aMails = Config::Get('plugin.feedback.mail');

		if (!is_array($aMails)) {
			$aMails = array($aMails);
		}

		/*
		 * Собираем данные
		 */
		$sIp = ($_SERVER["REMOTE_ADDR"]) ? $_SERVER["REMOTE_ADDR"] : getenv("HTTP_X_FORWARDED_FOR");
		$sSendTitle = $this->Text_Parser(getRequest('send_title'));
		$aSendContent = array(
			'sIp'	=> $sIp.chr(13).chr(10),
			'sName'	=> $this->Text_Parser(getRequest('send_name')),
			'sMail'	=> $this->Text_Parser(getRequest('send_mail')),
			'sText'	=> $this->Text_Parser(getRequest('send_text')),
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
		$this->ClearForm();
		$this->SetWrite();
		$this->Message_AddNoticeSingle($this->Lang_Get('feedback_send_ok'));
	}


	/**
	 * Проверка полей формы
	 *
	 * @return bool
	 */
	protected function checkFields() {
		/**
		 * Проверяем только если была отправлена форма с данными (методом POST)
		 */
		if (!isPost('submit_feedback')) {
			return false;
		}

		$this->Security_ValidateSendForm();

		$bOk = true;
		/**
		 * Проверка - разрешено ли писать по времени
		 */
		if (!$this->CanWrite()) {
			$this->Message_AddError($this->Lang_Get('feedback_send_spam_error'), $this->Lang_Get('error'));
			$bOk = false;
		}
		/**
		 * Проверка имени
		 */
		if (!func_check(getRequest('send_name'), 'text', 3, 30)) {
			$this->Message_AddError($this->Lang_Get('feedback_send_name_error'),$this->Lang_Get('error'));
			$bOk = false;
		}
		/**
		 * Проверка мыла
		 */
		if (!func_check(getRequest('send_mail'), 'mail')) {
			$this->Message_AddError($this->Lang_Get('feedback_send_mail_error'), $this->Lang_Get('error'));
			$bOk = false;
		}
		/**
		 * Проверка заголовка
		 */
		if (!func_check(getRequest('send_title'), 'text', 3, 100)) {
			$this->Message_AddError($this->Lang_Get('feedback_send_title_error'), $this->Lang_Get('error'));
			$bOk = false;
		}
		/**
		 * Проверка текста
		 */
		if (!func_check(getRequest('send_text'), 'text', 10, 3000)) {
			$this->Message_AddError($this->Lang_Get('feedback_send_text_error'), $this->Lang_Get('error'));
			$bOk = false;
		}
		/**
		 * Проверка капчи
		 */
		if (!isset($_SESSION['captcha_keystring']) or $_SESSION['captcha_keystring']!=strtolower(getRequest('captcha'))) {
			$this->Message_AddError($this->Lang_Get('feedback_captcha_error'), $this->Lang_Get('error'));
			$bOk = false;
		}
		/**
		 * Выполнение хуков
		 */
		$this->Hook_Run('check_feedback_fields', array('bOk'=>&$bOk));
		/**
		 * Возвращаем статус
		 */
		return $bOk;
	}

}
?>