-- MySQL Script generated by MySQL Workbench
-- Thứ tư, 16 Tháng năm Năm 2018 09:09:26 +07
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema jcart
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `jcart` ;

-- -----------------------------------------------------
-- Schema jcart
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `jcart` ;
USE `jcart` ;

-- -----------------------------------------------------
-- Table `jcart`.`users`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `jcart`.`users` (
  `id` INT(11) NOT NULL,
  `name` VARCHAR(255) NOT NULL,
  `email` VARCHAR(255) NOT NULL,
  `password` VARCHAR(255) NOT NULL,
  `password_reset_token` VARCHAR(255) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `jcart`.`roles`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `jcart`.`roles` (
  `id` INT NOT NULL,
  `name` VARCHAR(255) NOT NULL,
  `description` VARCHAR(255) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `jcart`.`permissions`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `jcart`.`permissions` (
  `id` INT NOT NULL,
  `name` VARCHAR(45) NOT NULL,
  `description` VARCHAR(45) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `jcart`.`user_role`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `jcart`.`user_role` (
  `user_id` INT(11) NOT NULL,
  `role_id` INT NOT NULL,
  INDEX `fk_table1_roles1_idx` (`role_id` ASC),
  CONSTRAINT `fk_table1_users1`
    FOREIGN KEY (`user_id`)
    REFERENCES `jcart`.`users` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_table1_roles1`
    FOREIGN KEY (`role_id`)
    REFERENCES `jcart`.`roles` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `jcart`.`role_permission`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `jcart`.`role_permission` (
  `role_id` INT NOT NULL,
  `perm_id` INT NOT NULL,
  INDEX `fk_role_permission_permissions1_idx` (`perm_id` ASC),
  CONSTRAINT `fk_role_permission_roles1`
    FOREIGN KEY (`role_id`)
    REFERENCES `jcart`.`roles` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_role_permission_permissions1`
    FOREIGN KEY (`perm_id`)
    REFERENCES `jcart`.`permissions` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `jcart`.`categories`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `jcart`.`categories` (
  `id` INT NOT NULL,
  `name` VARCHAR(45) NOT NULL,
  `disp_order` INT(11) NULL,
  `disabled` BIT(1) NOT NULL,
  `description` VARCHAR(1024) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `jcart`.`products`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `jcart`.`products` (
  `cat_id` INT NULL,
  `id` INT(11) NOT NULL,
  `description` VARCHAR(255) NULL,
  `sku` VARCHAR(255) NULL,
  `price` DECIMAL(19,2) NULL,
  `image_url` VARCHAR(255) NULL,
  `disabled` BIT(1) NULL,
  `created_on` DATETIME NULL,
  `name` VARCHAR(45) NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_table2_categories1`
    FOREIGN KEY (`cat_id`)
    REFERENCES `jcart`.`categories` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `jcart`.`customers`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `jcart`.`customers` (
  `id` INT NOT NULL,
  `firstname` VARCHAR(45) NOT NULL,
  `lastname` VARCHAR(45) NULL,
  `email` VARCHAR(45) NULL,
  `phone` VARCHAR(45) NULL,
  `password` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `jcart`.`payments`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `jcart`.`payments` (
  `id` INT NOT NULL,
  `cc_number` VARCHAR(255) NULL,
  `cvv` VARCHAR(45) NULL,
  `amount` VARCHAR(45) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `jcart`.`addresses`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `jcart`.`addresses` (
  `id` INT NOT NULL,
  `address_line1` VARCHAR(45) NULL,
  `address_line2` VARCHAR(45) NULL,
  `city` VARCHAR(45) NULL,
  `state` VARCHAR(45) NULL,
  `zip_code` VARCHAR(45) NULL,
  `country` VARCHAR(45) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `jcart`.`orders`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `jcart`.`orders` (
  `id` INT NOT NULL,
  `order_number` VARCHAR(45) NOT NULL,
  `status` VARCHAR(45) NULL,
  `created_on` DATETIME NULL,
  `cust_id` INT NULL,
  `payment_id` INT NULL,
  `delivery_addr_id` INT NULL,
  `billing_addr_id` INT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_orders_customers1_idx` (`cust_id` ASC),
  INDEX `fk_orders_payments1_idx` (`payment_id` ASC),
  INDEX `fk_orders_addresses1_idx` (`delivery_addr_id` ASC),
  INDEX `fk_orders_addresses2_idx` (`billing_addr_id` ASC),
  CONSTRAINT `fk_orders_customers1`
    FOREIGN KEY (`cust_id`)
    REFERENCES `jcart`.`customers` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_orders_payments1`
    FOREIGN KEY (`payment_id`)
    REFERENCES `jcart`.`payments` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_orders_addresses1`
    FOREIGN KEY (`delivery_addr_id`)
    REFERENCES `jcart`.`addresses` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_orders_addresses2`
    FOREIGN KEY (`billing_addr_id`)
    REFERENCES `jcart`.`addresses` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `jcart`.`order_items`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `jcart`.`order_items` (
  `id` INT NOT NULL,
  `quantity` INT NULL,
  `price` DECIMAL(19,2) NULL,
  `product_id` INT(11) NULL,
  `order_id` INT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_order_items_products1_idx` (`product_id` ASC),
  INDEX `fk_order_items_orders1_idx` (`order_id` ASC),
  CONSTRAINT `fk_order_items_products1`
    FOREIGN KEY (`product_id`)
    REFERENCES `jcart`.`products` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_order_items_orders1`
    FOREIGN KEY (`order_id`)
    REFERENCES `jcart`.`orders` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
