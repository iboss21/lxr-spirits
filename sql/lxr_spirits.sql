-- ═══════════════════════════════════════════════════════════════════════════════
-- 🐺 LXR-SPIRITS — SQL SCHEMA
-- wolves.land | The Lux Empire | iBoss21 | © 2026
-- Resource identity locked to: lxr-spirits
-- ═══════════════════════════════════════════════════════════════════════════════

CREATE TABLE IF NOT EXISTS `lxr_spirits_profiles` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `char_key` VARCHAR(96) NOT NULL,
  `identifier` VARCHAR(96) DEFAULT NULL,
  `citizenid` VARCHAR(96) DEFAULT NULL,
  `charid` VARCHAR(96) DEFAULT NULL,
  `player_name` VARCHAR(128) DEFAULT NULL,
  `spirit` VARCHAR(50) NOT NULL,
  `label` VARCHAR(80) DEFAULT NULL,
  `title` VARCHAR(128) DEFAULT NULL,
  `meaning` TEXT DEFAULT NULL,
  `element` VARCHAR(64) DEFAULT NULL,
  `temperament` VARCHAR(64) DEFAULT NULL,
  `weakness` VARCHAR(255) DEFAULT NULL,
  `bond` INT NOT NULL DEFAULT 0,
  `omen` VARCHAR(80) DEFAULT NULL,
  `location_id` VARCHAR(96) DEFAULT NULL,
  `metadata` LONGTEXT DEFAULT NULL,
  `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uniq_lxr_spirit_char` (`char_key`),
  KEY `idx_lxr_spirit` (`spirit`),
  KEY `idx_lxr_spirit_identifier` (`identifier`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS `lxr_spirits_logs` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `char_key` VARCHAR(96) DEFAULT NULL,
  `identifier` VARCHAR(96) DEFAULT NULL,
  `player_name` VARCHAR(128) DEFAULT NULL,
  `ritual_type` VARCHAR(50) DEFAULT NULL,
  `location_id` VARCHAR(96) DEFAULT NULL,
  `spirit` VARCHAR(50) DEFAULT NULL,
  `result` VARCHAR(50) DEFAULT NULL,
  `metadata` LONGTEXT DEFAULT NULL,
  `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `idx_lxr_spirits_logs_char` (`char_key`),
  KEY `idx_lxr_spirits_logs_type` (`ritual_type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS `lxr_spirits_cooldowns` (
  `char_key` VARCHAR(96) NOT NULL,
  `ritual_type` VARCHAR(50) NOT NULL,
  `cooldown_until` INT NOT NULL DEFAULT 0,
  PRIMARY KEY (`char_key`, `ritual_type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
