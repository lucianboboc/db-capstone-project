-- MySQL Script generated by MySQL Workbench
-- Sat Sep 23 13:28:07 2023
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema LittleLemonDB
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema LittleLemonDB
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `LittleLemonDB` DEFAULT CHARACTER SET utf8 ;
USE `LittleLemonDB` ;

-- -----------------------------------------------------
-- Table `LittleLemonDB`.`customers`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `LittleLemonDB`.`customers` (
  `customer_id` INT NOT NULL,
  `first_name` VARCHAR(45) NULL,
  `last_name` VARCHAR(45) NULL,
  PRIMARY KEY (`customer_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `LittleLemonDB`.`bookings`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `LittleLemonDB`.`bookings` (
  `booking_id` INT NOT NULL,
  `date` DATETIME NULL,
  `table_no` INT NULL,
  `customer_id` INT NULL,
  PRIMARY KEY (`booking_id`),
  INDEX `bookings_customer_id_idx` (`customer_id` ASC) VISIBLE,
  CONSTRAINT `bookings_customer_id`
    FOREIGN KEY (`customer_id`)
    REFERENCES `LittleLemonDB`.`customers` (`customer_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `LittleLemonDB`.`menu_items`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `LittleLemonDB`.`menu_items` (
  `menu_item_id` INT NOT NULL,
  `cousine_name` VARCHAR(45) NULL,
  `dessert_name` VARCHAR(45) NULL,
  `course_name` VARCHAR(45) NULL,
  `drink_name` VARCHAR(45) NULL,
  `starter_name` VARCHAR(45) NULL,
  PRIMARY KEY (`menu_item_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `LittleLemonDB`.`menu`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `LittleLemonDB`.`menu` (
  `menu_id` INT NOT NULL,
  `menu_name` VARCHAR(45) NULL,
  `cuisine` VARCHAR(45) NULL,
  `menu_item_id` INT NULL,
  PRIMARY KEY (`menu_id`),
  INDEX `menu_item_id_idx` (`menu_item_id` ASC) VISIBLE,
  CONSTRAINT `menu_item_id`
    FOREIGN KEY (`menu_item_id`)
    REFERENCES `LittleLemonDB`.`menu_items` (`menu_item_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `LittleLemonDB`.`orders`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `LittleLemonDB`.`orders` (
  `order_id` INT NOT NULL,
  `order_date` DATETIME NULL,
  `quantity` INT NULL,
  `total` DECIMAL(6,2) NULL,
  `menu_id` INT NULL,
  `customer_id` INT NULL,
  PRIMARY KEY (`order_id`),
  INDEX `menu_id_idx` (`menu_id` ASC) VISIBLE,
  INDEX `customer_id_idx` (`customer_id` ASC) VISIBLE,
  CONSTRAINT `menu_id`
    FOREIGN KEY (`menu_id`)
    REFERENCES `LittleLemonDB`.`menu` (`menu_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `customer_id`
    FOREIGN KEY (`customer_id`)
    REFERENCES `LittleLemonDB`.`customers` (`customer_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `LittleLemonDB`.`delivery_status`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `LittleLemonDB`.`delivery_status` (
  `order_id` INT NULL,
  `delivery_date` DATETIME NULL,
  `status` VARCHAR(45) NULL,
  INDEX `order_id_idx` (`order_id` ASC) VISIBLE,
  CONSTRAINT `order_id`
    FOREIGN KEY (`order_id`)
    REFERENCES `LittleLemonDB`.`orders` (`order_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `LittleLemonDB`.`staff`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `LittleLemonDB`.`staff` (
  `staff_id` INT NOT NULL,
  `role` VARCHAR(45) NULL,
  `salary` DECIMAL(6,2) NULL,
  PRIMARY KEY (`staff_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `LittleLemonDB`.`address`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `LittleLemonDB`.`address` (
  `street_name` VARCHAR(255) NOT NULL,
  `street_number` VARCHAR(45) NULL,
  `city` VARCHAR(45) NULL,
  `state` VARCHAR(45) NULL,
  `postal_code` VARCHAR(45) NULL,
  `customer_id` INT NULL,
  PRIMARY KEY (`street_name`),
  INDEX `address_customer_id_idx` (`customer_id` ASC) VISIBLE,
  CONSTRAINT `address_customer_id`
    FOREIGN KEY (`customer_id`)
    REFERENCES `LittleLemonDB`.`customers` (`customer_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
