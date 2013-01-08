<?
/*---------------------------------------------------------------------------
* @Module Name: Feedback
* @Description: Feedback for LiveStreet
* @Version: 2.0
* @Author: Chiffa
* @LiveStreet Version: 1.0
* @File Name: IP.entity.class.php
* @License: CC BY-NC, http://creativecommons.org/licenses/by-nc/3.0/
*----------------------------------------------------------------------------
*/

/**
 * Объект сущности IP
 *
 */
class PluginFeedback_ModuleFeedback_EntityIp extends EntityORM {

	public function getFromLong() {
		return int2ip($this->getFrom());
	}

	public function getToLong() {
		return int2ip($this->getTo());
	}

}
?>