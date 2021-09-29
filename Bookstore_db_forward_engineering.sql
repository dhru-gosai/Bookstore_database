-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema Assessment_3A
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema Assessment_3A
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `Assessment_3A` DEFAULT CHARACTER SET utf8 ;
USE `Assessment_3A` ;

-- -----------------------------------------------------
-- Table `Assessment_3A`.`Author`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Assessment_3A`.`Author` (
  `Author_Num` INT NOT NULL,
  `Author_Last` VARCHAR(45) NULL,
  `Author_First` VARCHAR(45) NULL,
  PRIMARY KEY (`Author_Num`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Assessment_3A`.`Publisher`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Assessment_3A`.`Publisher` (
  `Publisher_code` VARCHAR(10) NOT NULL,
  `Publisher_Name` VARCHAR(45) NULL,
  `Publisher_City` VARCHAR(20) NULL,
  PRIMARY KEY (`Publisher_code`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Assessment_3A`.`Book`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Assessment_3A`.`Book` (
  `Book_Code` INT NOT NULL,
  `Book_Title` VARCHAR(100) NULL,
  `Book_Type` VARCHAR(45) NULL,
  `Book_Paperback` VARCHAR(10) NULL,
  `Publisher_Code` VARCHAR(10) NULL,
  PRIMARY KEY (`Book_Code`),
  INDEX `fk_Book_Publisher1_idx` (`Publisher_Code` ASC) VISIBLE,
  CONSTRAINT `fk_Book_Publisher1`
    FOREIGN KEY (`Publisher_Code`)
    REFERENCES `Assessment_3A`.`Publisher` (`Publisher_code`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Assessment_3A`.`Branch`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Assessment_3A`.`Branch` (
  `Branch_Num` INT NOT NULL,
  `Branch_Name` VARCHAR(25) NULL,
  `Branch_Location` VARCHAR(50) NULL,
  PRIMARY KEY (`Branch_Num`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Assessment_3A`.`Copy`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Assessment_3A`.`Copy` (
  `Copy_Num` INT NOT NULL,
  `Branch_Num` INT NOT NULL,
  `Book_Code` INT NOT NULL,
  `Copy_Quality` VARCHAR(45) NULL,
  `Copy_Price` DECIMAL(8,2) NULL,
  PRIMARY KEY (`Copy_Num`, `Branch_Num`, `Book_Code`),
  INDEX `fk_Copy_Book1_idx` (`Book_Code` ASC) VISIBLE,
  INDEX `fk_Copy_Branch1_idx` (`Branch_Num` ASC) VISIBLE,
  CONSTRAINT `fk_Copy_Book1`
    FOREIGN KEY (`Book_Code`)
    REFERENCES `Assessment_3A`.`Book` (`Book_Code`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Copy_Branch1`
    FOREIGN KEY (`Branch_Num`)
    REFERENCES `Assessment_3A`.`Branch` (`Branch_Num`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Assessment_3A`.`Wrote`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Assessment_3A`.`Wrote` (
  `Author_Num` INT NOT NULL,
  `Book_Code` INT NOT NULL,
  `Wrote_Sequence` INT NULL,
  PRIMARY KEY (`Author_Num`, `Book_Code`),
  INDEX `fk_Wrote_Book1_idx` (`Book_Code` ASC) VISIBLE,
  CONSTRAINT `fk_Wrote_Author`
    FOREIGN KEY (`Author_Num`)
    REFERENCES `Assessment_3A`.`Author` (`Author_Num`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Wrote_Book1`
    FOREIGN KEY (`Book_Code`)
    REFERENCES `Assessment_3A`.`Book` (`Book_Code`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Assessment_3A`.`Computer`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Assessment_3A`.`Computer` (
  `Comp_Num` VARCHAR(10) NOT NULL,
  `Comp_PurchaseDate` DATE NULL,
  `Comp_Cost` INT NULL,
  `Comp_Description` VARCHAR(15) NULL,
  PRIMARY KEY (`Comp_Num`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Assessment_3A`.`Employee`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Assessment_3A`.`Employee` (
  `Emp_Num` INT NOT NULL,
  `Emp_Last` VARCHAR(45) NULL,
  `Emp_First` VARCHAR(45) NULL,
  `Branch_Num` INT NULL,
  PRIMARY KEY (`Emp_Num`),
  INDEX `fk_Employee_Branch1_idx` (`Branch_Num` ASC) VISIBLE,
  CONSTRAINT `fk_Employee_Branch1`
    FOREIGN KEY (`Branch_Num`)
    REFERENCES `Assessment_3A`.`Branch` (`Branch_Num`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Assessment_3A`.`Hire`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Assessment_3A`.`Hire` (
  `Comp_Num` VARCHAR(10) NOT NULL,
  `Hire_Start` DATE NOT NULL,
  `Hire_End` DATE NULL,
  `Emp_Num` INT NULL,
  PRIMARY KEY (`Comp_Num`, `Hire_Start`),
  INDEX `fk_Hire_Employee1_idx` (`Emp_Num` ASC) VISIBLE,
  CONSTRAINT `fk_Hire_Computer1`
    FOREIGN KEY (`Comp_Num`)
    REFERENCES `Assessment_3A`.`Computer` (`Comp_Num`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Hire_Employee1`
    FOREIGN KEY (`Emp_Num`)
    REFERENCES `Assessment_3A`.`Employee` (`Emp_Num`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
