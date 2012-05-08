SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL';

CREATE SCHEMA IF NOT EXISTS `eusse_jewelry` DEFAULT CHARACTER SET latin1 COLLATE latin1_swedish_ci ;
USE `eusse_jewelry` ;

-- -----------------------------------------------------
-- Table `eusse_jewelry`.`groups`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `eusse_jewelry`.`groups` (
  `id` INT NOT NULL AUTO_INCREMENT ,
  `name` VARCHAR(45) NOT NULL ,
  `description` TEXT NULL ,
  `order` INT NOT NULL ,
  PRIMARY KEY (`id`) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `eusse_jewelry`.`users`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `eusse_jewelry`.`users` (
  `id` INT NOT NULL AUTO_INCREMENT ,
  `name` VARCHAR(45) NOT NULL ,
  `lastname` VARCHAR(45) NOT NULL ,
  `email` VARCHAR(45) NOT NULL ,
  `telephone` VARCHAR(45) NOT NULL ,
  `password` VARCHAR(45) NULL ,
  `cellphone` VARCHAR(45) NULL ,
  `identitycard` VARCHAR(45) NULL ,
  `group_id` INT NOT NULL ,
  `created` TIMESTAMP NOT NULL ,
  `parent_id` INT NULL ,
  `lft` INT NULL ,
  `rght` INT NULL ,
  PRIMARY KEY (`id`) ,
  INDEX `users_group` (`group_id` ASC) ,
  INDEX `users_user` (`parent_id` ASC) ,
  CONSTRAINT `users_group`
    FOREIGN KEY (`group_id` )
    REFERENCES `eusse_jewelry`.`groups` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `users_user`
    FOREIGN KEY (`parent_id` )
    REFERENCES `eusse_jewelry`.`users` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `eusse_jewelry`.`statuses`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `eusse_jewelry`.`statuses` (
  `id` INT NOT NULL AUTO_INCREMENT ,
  `name` VARCHAR(45) NOT NULL ,
  `description` TEXT NULL ,
  `order` INT NOT NULL ,
  PRIMARY KEY (`id`) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `eusse_jewelry`.`orders`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `eusse_jewelry`.`orders` (
  `id` INT NOT NULL AUTO_INCREMENT ,
  `user_id` INT NOT NULL ,
  `status_id` INT NOT NULL ,
  `address` MEDIUMTEXT NOT NULL ,
  `created` DATETIME NOT NULL ,
  `sent` DATETIME NULL ,
  PRIMARY KEY (`id`) ,
  INDEX `orders_user` (`user_id` ASC) ,
  INDEX `orders_status` (`status_id` ASC) ,
  CONSTRAINT `orders_user`
    FOREIGN KEY (`user_id` )
    REFERENCES `eusse_jewelry`.`users` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `orders_status`
    FOREIGN KEY (`status_id` )
    REFERENCES `eusse_jewelry`.`statuses` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `eusse_jewelry`.`categories`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `eusse_jewelry`.`categories` (
  `id` INT NOT NULL AUTO_INCREMENT ,
  `name` VARCHAR(45) NOT NULL ,
  `parent_id` INT NULL ,
  `lft` INT NULL ,
  `rght` INT NULL ,
  `published` TINYINT NOT NULL ,
  PRIMARY KEY (`id`) ,
  INDEX `categories_category` (`parent_id` ASC) ,
  CONSTRAINT `categories_category`
    FOREIGN KEY (`parent_id` )
    REFERENCES `eusse_jewelry`.`categories` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `eusse_jewelry`.`packages`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `eusse_jewelry`.`packages` (
  `id` INT NOT NULL AUTO_INCREMENT ,
  `name` VARCHAR(45) NOT NULL ,
  `order` INT NOT NULL ,
  `category_id` INT NOT NULL ,
  `published` TINYINT NOT NULL ,
  PRIMARY KEY (`id`) ,
  INDEX `packages_category` (`category_id` ASC) ,
  CONSTRAINT `packages_category`
    FOREIGN KEY (`category_id` )
    REFERENCES `eusse_jewelry`.`categories` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `eusse_jewelry`.`products`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `eusse_jewelry`.`products` (
  `id` INT NOT NULL AUTO_INCREMENT ,
  `reference` VARCHAR(45) NOT NULL ,
  `name` VARCHAR(45) NOT NULL ,
  `description` TEXT NOT NULL ,
  `points` FLOAT NOT NULL ,
  `purchase_price` FLOAT NOT NULL ,
  `sale_price` FLOAT NOT NULL ,
  `order` INT NOT NULL ,
  `package_id` INT NOT NULL ,
  `created` DATETIME NOT NULL ,
  PRIMARY KEY (`id`) ,
  INDEX `products_package` (`package_id` ASC) ,
  CONSTRAINT `products_package`
    FOREIGN KEY (`package_id` )
    REFERENCES `eusse_jewelry`.`packages` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `eusse_jewelry`.`product_orders`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `eusse_jewelry`.`product_orders` (
  `id` INT NOT NULL AUTO_INCREMENT ,
  `product_id` INT NOT NULL ,
  `order_id` INT NOT NULL ,
  `quantity` INT NOT NULL ,
  `value` FLOAT NOT NULL ,
  PRIMARY KEY (`id`) ,
  INDEX `productOrders_order` (`order_id` ASC) ,
  INDEX `productOrders_product` (`product_id` ASC) ,
  CONSTRAINT `productOrders_order`
    FOREIGN KEY (`order_id` )
    REFERENCES `eusse_jewelry`.`orders` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `productOrders_product`
    FOREIGN KEY (`product_id` )
    REFERENCES `eusse_jewelry`.`products` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `eusse_jewelry`.`images`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `eusse_jewelry`.`images` (
  `id` INT NOT NULL AUTO_INCREMENT ,
  `product_id` INT NOT NULL ,
  `name` VARCHAR(45) NOT NULL ,
  `order` INT NOT NULL ,
  PRIMARY KEY (`id`) ,
  INDEX `images_product` (`product_id` ASC) ,
  CONSTRAINT `images_product`
    FOREIGN KEY (`product_id` )
    REFERENCES `eusse_jewelry`.`products` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `eusse_jewelry`.`balances`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `eusse_jewelry`.`balances` (
  `id` INT NOT NULL AUTO_INCREMENT ,
  `order_id` INT NOT NULL ,
  `user_id` INT NOT NULL ,
  `value` INT NOT NULL ,
  `subject` VARCHAR(45) NOT NULL ,
  `date` TIMESTAMP NOT NULL ,
  PRIMARY KEY (`id`) ,
  INDEX `balances_user` (`user_id` ASC) ,
  INDEX `balances_order` (`order_id` ASC) ,
  CONSTRAINT `balances_user`
    FOREIGN KEY (`user_id` )
    REFERENCES `eusse_jewelry`.`users` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `balances_order`
    FOREIGN KEY (`order_id` )
    REFERENCES `eusse_jewelry`.`orders` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `eusse_jewelry`.`settings`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `eusse_jewelry`.`settings` (
  `id` INT NOT NULL AUTO_INCREMENT ,
  `user_id` INT NULL ,
  `key` VARCHAR(45) NOT NULL ,
  `value` TEXT NOT NULL ,
  `description` VARCHAR(45) NULL ,
  PRIMARY KEY (`id`) ,
  INDEX `settings_user` (`user_id` ASC) ,
  CONSTRAINT `settings_user`
    FOREIGN KEY (`user_id` )
    REFERENCES `eusse_jewelry`.`users` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `eusse_jewelry`.`acos`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `eusse_jewelry`.`acos` (
  `id` INT(10) NOT NULL AUTO_INCREMENT ,
  `parent_id` INT(10) NULL ,
  `model` VARCHAR(255) NULL ,
  `foreign_key` INT(10) NULL ,
  `alias` VARCHAR(255) NULL ,
  `lft` INT(10) NULL ,
  `rght` INT(10) NULL ,
  PRIMARY KEY (`id`) ,
  INDEX `acos_aco` (`parent_id` ASC) ,
  CONSTRAINT `acos_aco`
    FOREIGN KEY (`parent_id` )
    REFERENCES `eusse_jewelry`.`acos` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `eusse_jewelry`.`aros`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `eusse_jewelry`.`aros` (
  `id` INT(10) NOT NULL AUTO_INCREMENT ,
  `parent_id` INT(10) NULL ,
  `model` VARCHAR(255) NULL ,
  `foreign_key` INT(10) NULL ,
  `alias` VARCHAR(255) NULL ,
  `lft` INT(10) NULL ,
  `rght` INT(10) NULL ,
  PRIMARY KEY (`id`) ,
  INDEX `aros_aro` (`parent_id` ASC) ,
  CONSTRAINT `aros_aro`
    FOREIGN KEY (`parent_id` )
    REFERENCES `eusse_jewelry`.`aros` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `eusse_jewelry`.`aros_acos`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `eusse_jewelry`.`aros_acos` (
  `id` INT(10) NOT NULL AUTO_INCREMENT ,
  `aro_id` INT(10) NOT NULL ,
  `aco_id` INT(10) NOT NULL ,
  `_create` VARCHAR(2) NOT NULL ,
  `_read` VARCHAR(2) NOT NULL ,
  `_update` VARCHAR(2) NOT NULL ,
  `_delete` VARCHAR(2) NOT NULL ,
  PRIMARY KEY (`id`) ,
  INDEX `arosAcos_aco` (`aco_id` ASC) ,
  INDEX `arosAcos_aro` (`aro_id` ASC) ,
  CONSTRAINT `arosAcos_aco`
    FOREIGN KEY (`aco_id` )
    REFERENCES `eusse_jewelry`.`acos` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `arosAcos_aro`
    FOREIGN KEY (`aro_id` )
    REFERENCES `eusse_jewelry`.`aros` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `eusse_jewelry`.`audits`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `eusse_jewelry`.`audits` (
  `id` INT NOT NULL ,
  `event` VARCHAR(255) NOT NULL ,
  `model` VARCHAR(255) NOT NULL ,
  `entity_id` INT NOT NULL ,
  `json_object` TEXT NOT NULL ,
  `description` VARCHAR(45) NULL ,
  `user_id` INT NULL ,
  `created` DATETIME NOT NULL ,
  PRIMARY KEY (`id`) ,
  INDEX `audits_user` (`user_id` ASC) ,
  CONSTRAINT `audits_user`
    FOREIGN KEY (`user_id` )
    REFERENCES `eusse_jewelry`.`users` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `eusse_jewelry`.`audit_deltas`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `eusse_jewelry`.`audit_deltas` (
  `id` INT NOT NULL ,
  `audit_id` INT NOT NULL ,
  `property_name` VARCHAR(255) NOT NULL ,
  `old_value` VARCHAR(255) NULL ,
  ` new_value` VARCHAR(255) NULL ,
  PRIMARY KEY (`id`) ,
  INDEX `auditDeltas_audit` (`audit_id` ASC) ,
  CONSTRAINT `auditDeltas_audit`
    FOREIGN KEY (`audit_id` )
    REFERENCES `eusse_jewelry`.`audits` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `eusse_jewelry`.`product_translations`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `eusse_jewelry`.`product_translations` (
  `id` INT NOT NULL AUTO_INCREMENT ,
  `locale` VARCHAR(6) NOT NULL ,
  `model` VARCHAR(255) NOT NULL DEFAULT 'Product' ,
  `foreign_key` INT NOT NULL ,
  `field` VARCHAR(255) NOT NULL ,
  `content` MEDIUMTEXT NULL ,
  PRIMARY KEY (`id`) ,
  INDEX `locale` (`locale` ASC) ,
  INDEX `field` (`field` ASC) ,
  INDEX `productTranslations_product` (`foreign_key` ASC) ,
  CONSTRAINT `productTranslations_product`
    FOREIGN KEY (`foreign_key` )
    REFERENCES `eusse_jewelry`.`products` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `eusse_jewelry`.`package_translations`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `eusse_jewelry`.`package_translations` (
  `id` INT NOT NULL AUTO_INCREMENT ,
  `locale` VARCHAR(6) NOT NULL ,
  `model` VARCHAR(255) NOT NULL DEFAULT 'Package' ,
  `foreign_key` INT NOT NULL ,
  `field` VARCHAR(255) NOT NULL ,
  `content` MEDIUMTEXT NULL ,
  PRIMARY KEY (`id`) ,
  INDEX `locale` (`locale` ASC) ,
  INDEX `field` (`field` ASC) ,
  INDEX `packageTranslations_package` (`foreign_key` ASC) ,
  CONSTRAINT `packageTranslations_package`
    FOREIGN KEY (`foreign_key` )
    REFERENCES `eusse_jewelry`.`packages` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `eusse_jewelry`.`category_translations`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `eusse_jewelry`.`category_translations` (
  `id` INT NOT NULL AUTO_INCREMENT ,
  `locale` VARCHAR(6) NOT NULL ,
  `model` VARCHAR(255) NOT NULL ,
  `foreign_key` INT NOT NULL ,
  `field` VARCHAR(255) NOT NULL ,
  `content` MEDIUMTEXT NULL ,
  PRIMARY KEY (`id`) ,
  INDEX `locale` (`locale` ASC) ,
  INDEX `field` (`field` ASC) ,
  INDEX `categoryTanslations_category` (`foreign_key` ASC) ,
  CONSTRAINT `categoryTanslations_category`
    FOREIGN KEY (`foreign_key` )
    REFERENCES `eusse_jewelry`.`categories` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `eusse_jewelry`.`status_translations`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `eusse_jewelry`.`status_translations` (
  `id` INT NOT NULL AUTO_INCREMENT ,
  `locale` VARCHAR(6) NOT NULL ,
  `model` VARCHAR(255) NOT NULL DEFAULT 'Status' ,
  `foreign_key` INT NOT NULL ,
  `field` VARCHAR(255) NOT NULL ,
  `content` MEDIUMTEXT NULL ,
  PRIMARY KEY (`id`) ,
  INDEX `locale` (`locale` ASC) ,
  INDEX `field` (`field` ASC) ,
  INDEX `statusTranslations_status` (`foreign_key` ASC) ,
  CONSTRAINT `statusTranslations_status`
    FOREIGN KEY (`foreign_key` )
    REFERENCES `eusse_jewelry`.`statuses` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;



SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
