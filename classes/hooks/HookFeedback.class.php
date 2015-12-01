<?php
/*---------------------------------------------------------------------------
* @Module Name: Feedback
* @Description: Feedback for LiveStreet
* @Version: 2.0
* @Author: Chiffa
* @LiveStreet version: 1.X
* @File Name: HookFeedback.class.php
* @License: CC BY-NC, http://creativecommons.org/licenses/by-nc/3.0/
*----------------------------------------------------------------------------
*/

class PluginFeedback_HookFeedback extends Hook {

	/**
	 * Регистрация хуков
	 */
	public function RegisterHook() {
		$this->AddHook('init_action', 'InitAction', __CLASS__);
		$this->AddHook('template_feedback_copyright','FeedbackCopyright');
		$this->AddHook('template_main_menu_item','MainMenu', __CLASS__);
		$this->AddHook('template_body_end', 'InjectModal', __CLASS__);
		$this->AddHook('template_userbar_item','MobileUserbarItem', __CLASS__);
	}

	public function InitAction($aVars) {
		if (!$this->User_GetUserCurrent()) {
			/**
			 * Разрешаем гостям юзать обратную связь даже при закрытом режиме сайта
			 */
			$oSet = $this->PluginFeedback_Feedback_GetSettingByKey('acl.close_enable');
			if ($oSet && $oSet->getValue()) {
				if (Config::Get('general.close') && stripos($_SERVER['REQUEST_URI'], 'feedback') && Router::GetAction()!='feedback') {
					Router::Action('feedback');
					return ;
				}
			}
		}
	}

	public function FeedbackCopyright() {
		if (Config::Get('plugin.feedback.donator')) {
			return;
		}
		$aPlugins=$this->Plugin_GetList();
		if (!(isset($aPlugins['feedback']))) {
			return;
		}
		$aFeedbackData=$aPlugins['feedback']['property'];
		$this->Viewer_Assign('aFeedbackData',$aFeedbackData);
		return $this->Viewer_Fetch(Plugin::GetTemplatePath(__CLASS__).'copyright.tpl');
	}

	public function InjectModal() {
		return $this->Viewer_Fetch(Plugin::GetTemplatePath(__CLASS__).'window_feedback.tpl');
	}

	public function MainMenu() {
		if (!Config::Get('plugin.feedback.system.button')) {
			return $this->Viewer_Fetch(Plugin::GetTemplatePath(__CLASS__).'main_menu.tpl');
		}
	}

	public function MobileUserbarItem() {
		if (class_exists('MobileDetect') && MobileDetect::IsMobileTemplate(false)) {
			return $this->Viewer_Fetch(Plugin::GetTemplatePath(__CLASS__).'userbar_item.tpl');
		}
	}

}
?>