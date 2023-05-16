--
--  Comment Meta Language Constructs:
--
--  #IfNotTable
--    argument: table_name
--    behavior: if the table_name does not exist,  the block will be executed

--  #IfTable
--    argument: table_name
--    behavior: if the table_name does exist, the block will be executed

--  #IfMissingColumn
--    arguments: table_name colname
--    behavior:  if the colname in the table_name table does not exist,  the block will be executed

--  #IfNotColumnType
--    arguments: table_name colname value
--    behavior:  If the table table_name does not have a column colname with a data type equal to value, then the block will be executed

--  #IfNotRow
--    arguments: table_name colname value
--    behavior:  If the table table_name does not have a row where colname = value, the block will be executed.

--  #IfNotRow2D
--    arguments: table_name colname value colname2 value2
--    behavior:  If the table table_name does not have a row where colname = value AND colname2 = value2, the block will be executed.

--  #IfNotRow3D
--    arguments: table_name colname value colname2 value2 colname3 value3
--    behavior:  If the table table_name does not have a row where colname = value AND colname2 = value2 AND colname3 = value3, the block will be executed.

--  #IfNotRow4D
--    arguments: table_name colname value colname2 value2 colname3 value3 colname4 value4
--    behavior:  If the table table_name does not have a row where colname = value AND colname2 = value2 AND colname3 = value3 AND colname4 = value4, the block will be executed.

--  #IfNotRow2Dx2
--    desc:      This is a very specialized function to allow adding items to the list_options table to avoid both redundant option_id and title in each element.
--    arguments: table_name colname value colname2 value2 colname3 value3
--    behavior:  The block will be executed if both statements below are true:
--               1) The table table_name does not have a row where colname = value AND colname2 = value2.
--               2) The table table_name does not have a row where colname = value AND colname3 = value3.

--  #IfNotIndex
--    desc:      This function will allow adding of indexes/keys.
--    arguments: table_name colname
--    behavior:  If the index does not exist, it will be created

--  #EndIf
--    all blocks are terminated with and #EndIf statement.

#IfMissingColumn users_secure last_login_fail
ALTER TABLE `users_secure` ADD `last_login_fail` datetime DEFAULT NULL;
#EndIf

#IfMissingColumn users_secure total_login_fail_counter
ALTER TABLE `users_secure` ADD `total_login_fail_counter` bigint DEFAULT 0;
#EndIf

#IfMissingColumn users_secure auto_block_emailed
ALTER TABLE `users_secure` ADD `auto_block_emailed` tinyint DEFAULT 0;
#EndIf

#IfNotRow globals gl_name time_reset_password_max_failed_logins
UPDATE `globals` SET `gl_value` = 20 WHERE `gl_name` = 'password_max_failed_logins' AND `gl_value` = 0;
#EndIf

#IfNotTable ip_tracking
CREATE TABLE `ip_tracking` (
`id` bigint NOT NULL auto_increment,
`ip_string` varchar(255) DEFAULT '',
`total_ip_login_fail_counter` bigint DEFAULT 0,
`ip_login_fail_counter` bigint DEFAULT 0,
`ip_last_login_fail` datetime DEFAULT NULL,
`ip_auto_block_emailed` tinyint DEFAULT 0,
`ip_force_block` tinyint DEFAULT 0,
`ip_no_prevent_timing_attack` tinyint DEFAULT 0,
PRIMARY KEY (`id`),
UNIQUE KEY `ip_string` (`ip_string`)
) ENGINE=InnoDb AUTO_INCREMENT=1;
#EndIf

