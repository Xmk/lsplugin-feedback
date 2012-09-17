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
