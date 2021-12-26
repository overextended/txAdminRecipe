CREATE TABLE `users` (
	`identifier` VARCHAR(60) NOT NULL,
	`accounts` LONGTEXT NULL DEFAULT NULL,
	`group` VARCHAR(50) NULL DEFAULT 'user',
	`inventory` LONGTEXT NULL DEFAULT NULL,
	`job` VARCHAR(20) NULL DEFAULT 'unemployed',
	`job_grade` INT NULL DEFAULT 0,
	`position` VARCHAR(255) NOT NULL DEFAULT '{"x":-269.4,"y":-955.3,"z":31.2,"heading":205.8}',

	PRIMARY KEY (`identifier`)
);

CREATE TABLE `items` (
	`name` VARCHAR(50) NOT NULL,
	`label` VARCHAR(50) NOT NULL,
	`weight` INT NOT NULL DEFAULT 1,
	`rare` TINYINT NOT NULL DEFAULT 0,
	`can_remove` TINYINT NOT NULL DEFAULT 1,

	PRIMARY KEY (`name`)
);

CREATE TABLE `job_grades` (
	`id` INT NOT NULL AUTO_INCREMENT,
	`job_name` VARCHAR(50) DEFAULT NULL,
	`grade` INT NOT NULL,
	`name` VARCHAR(50) NOT NULL,
	`label` VARCHAR(50) NOT NULL,
	`salary` INT NOT NULL,
	`skin_male` LONGTEXT NOT NULL,
	`skin_female` LONGTEXT NOT NULL,

	PRIMARY KEY (`id`)
);

INSERT INTO `job_grades` VALUES (1,'unemployed',0,'unemployed','Unemployed',200,'{}','{}');

CREATE TABLE `jobs` (
	`name` VARCHAR(50) NOT NULL,
	`label` VARCHAR(50) DEFAULT NULL,

	PRIMARY KEY (`name`)
);

INSERT INTO `jobs` VALUES ('unemployed','Unemployed');

ALTER TABLE `users`
	ADD COLUMN `firstname` VARCHAR(16) NULL DEFAULT NULL,
	ADD COLUMN `lastname` VARCHAR(16) NULL DEFAULT NULL,
	ADD COLUMN `dateofbirth` VARCHAR(10) NULL DEFAULT NULL,
	ADD COLUMN `sex` VARCHAR(1) NULL DEFAULT NULL,
	ADD COLUMN `height` INT NULL DEFAULT NULL
;

CREATE TABLE `ox_inventory` (
	`owner` varchar(60) DEFAULT NULL,
	`name` varchar(100) NOT NULL,
	`data` longtext DEFAULT NULL,
	`lastupdated` timestamp NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
	UNIQUE KEY `owner` (`owner`,`name`)
);

-- Setup new columns for vehicle stashes, and actually index owner
ALTER TABLE `owned_vehicles`
	ADD COLUMN `trunk` LONGTEXT NULL,
	ADD COLUMN `glovebox` LONGTEXT NULL,
	ADD INDEX `owner` (`owner`)
;

ALTER TABLE `user_licenses`
	ADD INDEX `owner` (`owner`)
;

-- Now I'm just being too kind
ALTER TABLE `vehicles`
	ADD INDEX `category` (`category`
);
