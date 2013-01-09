--
-- Table structure for table `prefix_feedback_setting`
--

CREATE TABLE IF NOT EXISTS `prefix_feedback_setting` (
	`setting_key` varchar(250) CHARACTER SET utf8 NOT NULL,
	`setting_value` varchar(250) CHARACTER SET utf8 NOT NULL DEFAULT '',
	`setting_group` varchar(250) CHARACTER SET utf8 NOT NULL DEFAULT '',
	PRIMARY KEY (`setting_key`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `prefix_feedback_ip`
--

CREATE TABLE IF NOT EXISTS `prefix_feedback_ip` (
	`ip_id` int(11) NOT NULL auto_increment,
	`ip_group` varchar(50) CHARACTER SET utf8 NOT NULL DEFAULT '',
	`ip_comment` varchar(255) CHARACTER SET utf8 NOT NULL DEFAULT '',
	`ip_from` int(11) NOT NULL DEFAULT '0',
	`ip_to` int(11) NOT NULL DEFAULT '0',
	`ip_hash` varchar(100) DEFAULT '',
	PRIMARY KEY (`ip_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------
