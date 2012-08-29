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

class PluginFeedback_HookFeedback extends Hook {

	/**
	 * Регистрация хуков
	 */
	public function RegisterHook() {
		$this->AddHook('init_action', 'InitAction', __CLASS__);
		if (Config::Get('plugin.feedback.add_forms_links')) {
			$this->AddHook('template_form_login_end', 'InjectLogin', __CLASS__);
			$this->AddHook('template_form_login_popup_end', 'InjectLogin', __CLASS__);
			$this->AddHook('template_form_registration_end', 'InjectRegister', __CLASS__);
		}
		if (Config::Get('plugin.feedback.add_menu_link')) {
			$this->AddHook('template_main_menu', 'InjectMenu', __CLASS__);
		}
		if (Config::Get('plugin.feedback.add_footer_link')) {
			$this->AddHook('template_body_end', 'InjectFooter', __CLASS__);
		}
	}


	public function InitAction($aVars) {
		if (!$this->User_GetUserCurrent()) {
			/**
			 * Разрешаем гостям юзать обратную связь даже при закрытом режиме сайта
			 */
			if (Config::Get('general.close') && Config::Get('plugin.feedback.close_enable') && stripos($_SERVER['REQUEST_URI'], 'feedback') && Router::GetAction()!='feedback') {
				Router::Action('feedback');
				return ;
			}
		}
	}

	/**
	 * Вставляем ссылку на Обратную связь в форму регистрации и авторизации
	 */
	public function InjectLogin($aVars) {
		$this->Viewer_Assign('sMsg', $this->Lang_Get('login_problem'));
		return $this->Viewer_Fetch(Plugin::GetTemplatePath(__CLASS__).'inject_forms.tpl');
	}
	public function InjectRegister($aVars) {
		$this->Viewer_Assign('sMsg', $this->Lang_Get('register_problem'));
		return $this->Viewer_Fetch(Plugin::GetTemplatePath(__CLASS__).'inject_forms.tpl');
	}

	/**
	 * Вставляем ссылку на Обратную связь в главное меню
	 */
	public function InjectMenu() {
		return $this->Viewer_Fetch(Plugin::GetTemplatePath(__CLASS__).'inject_menu.tpl');
	}

	/**
	 * Вставляем ссылку на Обратную связь в футер
	 */
	public function InjectFooter($aVars) {
		return $this->Viewer_Fetch(Plugin::GetTemplatePath(__CLASS__).'inject_footer.tpl');
	}

}
?>