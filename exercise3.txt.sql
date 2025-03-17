-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `mydb` ;
USE `mydb` ;

-- -----------------------------------------------------
-- Table `mydb`.`doctor`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`doctor` (
  `Name` VARCHAR(40) NOT NULL,
  `Date_of_birth` DATE NOT NULL,
  `Address` VARCHAR(45) NOT NULL,
  `Salary` FLOAT NULL,
  PRIMARY KEY (`Name`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Medical`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Medical` (
  `Overtime_rate` FLOAT UNSIGNED NOT NULL,
  `doctor_Name` VARCHAR(40) NOT NULL,
  PRIMARY KEY (`Overtime_rate`, `doctor_Name`),
  INDEX `fk_Medical_doctor1_idx` (`doctor_Name` ASC) VISIBLE,
  CONSTRAINT `fk_Medical_doctor1`
    FOREIGN KEY (`doctor_Name`)
    REFERENCES `mydb`.`doctor` (`Name`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Specialist`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Specialist` (
  `Field_area` INT NOT NULL,
  `doctor_Name` VARCHAR(40) NOT NULL,
  PRIMARY KEY (`doctor_Name`, `Field_area`),
  CONSTRAINT `fk_Specialist_doctor1`
    FOREIGN KEY (`doctor_Name`)
    REFERENCES `mydb`.`doctor` (`Name`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Patient`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Patient` (
  `Name` INT NOT NULL,
  `Address` VARCHAR(45) NULL,
  `Phone_number` VARCHAR(45) NULL,
  `Date_of_birth` DATE NULL,
  `doctor_Name` VARCHAR(40) NOT NULL,
  PRIMARY KEY (`Name`, `doctor_Name`),
  INDEX `fk_Patient_doctor1_idx` (`doctor_Name` ASC) VISIBLE,
  CONSTRAINT `fk_Patient_doctor1`
    FOREIGN KEY (`doctor_Name`)
    REFERENCES `mydb`.`doctor` (`Name`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Appointment`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Appointment` (
  `Date` DATE NOT NULL,
  `time` TIME NOT NULL,
  `Patient_Name` INT NOT NULL,
  `Patient_doctor_Name` VARCHAR(40) NOT NULL,
  PRIMARY KEY (`Date`, `time`, `Patient_Name`, `Patient_doctor_Name`),
  INDEX `fk_Appointment_Patient1_idx` (`Patient_Name` ASC, `Patient_doctor_Name` ASC) VISIBLE,
  CONSTRAINT `fk_Appointment_Patient1`
    FOREIGN KEY (`Patient_Name` , `Patient_doctor_Name`)
    REFERENCES `mydb`.`Patient` (`Name` , `doctor_Name`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Payment`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Payment` (
  `Details` VARCHAR(50) NOT NULL,
  `Method` ENUM('cash', 'card') NOT NULL,
  PRIMARY KEY (`Details`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Bill`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Bill` (
  `Total` FLOAT NOT NULL,
  `Appointment_Date` DATE NOT NULL,
  `Appointment_time` TIME NOT NULL,
  `Appointment_Patient_Name` INT NOT NULL,
  `Appointment_Patient_doctor_Name` VARCHAR(40) NOT NULL,
  PRIMARY KEY (`Appointment_Date`, `Appointment_time`, `Appointment_Patient_Name`, `Appointment_Patient_doctor_Name`),
  CONSTRAINT `fk_Bill_Appointment1`
    FOREIGN KEY (`Appointment_Date` , `Appointment_time` , `Appointment_Patient_Name` , `Appointment_Patient_doctor_Name`)
    REFERENCES `mydb`.`Appointment` (`Date` , `time` , `Patient_Name` , `Patient_doctor_Name`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Payment_has_Bill`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Payment_has_Bill` (
  `Payment_Details` VARCHAR(50) NOT NULL,
  `Bill_Appointment_Date` DATE NOT NULL,
  `Bill_Appointment_time` TIME NOT NULL,
  `Bill_Appointment_Patient_Name` INT NOT NULL,
  `Bill_Appointment_Patient_doctor_Name` VARCHAR(40) NOT NULL,
  PRIMARY KEY (`Payment_Details`, `Bill_Appointment_Date`, `Bill_Appointment_time`, `Bill_Appointment_Patient_Name`, `Bill_Appointment_Patient_doctor_Name`),
  INDEX `fk_Payment_has_Bill_Bill1_idx` (`Bill_Appointment_Date` ASC, `Bill_Appointment_time` ASC, `Bill_Appointment_Patient_Name` ASC, `Bill_Appointment_Patient_doctor_Name` ASC) VISIBLE,
  INDEX `fk_Payment_has_Bill_Payment1_idx` (`Payment_Details` ASC) VISIBLE,
  CONSTRAINT `fk_Payment_has_Bill_Payment1`
    FOREIGN KEY (`Payment_Details`)
    REFERENCES `mydb`.`Payment` (`Details`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Payment_has_Bill_Bill1`
    FOREIGN KEY (`Bill_Appointment_Date` , `Bill_Appointment_time` , `Bill_Appointment_Patient_Name` , `Bill_Appointment_Patient_doctor_Name`)
    REFERENCES `mydb`.`Bill` (`Appointment_Date` , `Appointment_time` , `Appointment_Patient_Name` , `Appointment_Patient_doctor_Name`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
