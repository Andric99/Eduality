-- MySQL Script generated by MySQL Workbench
-- Mon May  4 12:38:52 2020
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema Eduality
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema Eduality
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `Eduality` DEFAULT CHARACTER SET utf8 ;
USE `Eduality` ;

-- -----------------------------------------------------
-- Table `Eduality`.`User`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Eduality`.`User` (
  `idUser` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NULL,
  `isExpert` TINYINT NOT NULL,
  `user` VARCHAR(45) NOT NULL,
  `password` VARCHAR(45) NOT NULL,
  `email` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idUser`, `user`),
  UNIQUE INDEX `idUser_UNIQUE` (`idUser` ASC) VISIBLE,
  UNIQUE INDEX `user_UNIQUE` (`user` ASC) VISIBLE,
  UNIQUE INDEX `email_UNIQUE` (`email` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Eduality`.`Post`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Eduality`.`Post` (
  `idPost` INT NOT NULL AUTO_INCREMENT,
  `idUser` INT NOT NULL,
  PRIMARY KEY (`idPost`, `idUser`),
  INDEX `idUser_idx` (`idUser` ASC) VISIBLE,
  CONSTRAINT `idUser`
    FOREIGN KEY (`idUser`)
    REFERENCES `Eduality`.`User` (`user`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Eduality`.`Report`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Eduality`.`Report` (
  `idReport` INT NOT NULL AUTO_INCREMENT,
  `idPost` INT NOT NULL,
  PRIMARY KEY (`idReport`, `idPost`),
  INDEX `idPost_idx` (`idPost` ASC) VISIBLE,
  CONSTRAINT `idPost`
    FOREIGN KEY (`idPost`)
    REFERENCES `Eduality`.`Post` (`idPost`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Eduality`.`Issue`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Eduality`.`Issue` (
  `reason` VARCHAR(45) NOT NULL,
  `reportId` INT NOT NULL,
  PRIMARY KEY (`reason`, `reportId`),
  INDEX `reportId_idx` (`reportId` ASC) VISIBLE,
  CONSTRAINT `reportId`
    FOREIGN KEY (`reportId`)
    REFERENCES `Eduality`.`Report` (`idReport`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Eduality`.`Topic`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Eduality`.`Topic` (
  `idTopic` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NULL,
  `description` VARCHAR(220) NULL,
  `idPost` INT NOT NULL,
  PRIMARY KEY (`idTopic`, `idPost`),
  INDEX `idPost_idx` (`idPost` ASC) VISIBLE,
  CONSTRAINT `idPost`
    FOREIGN KEY (`idPost`)
    REFERENCES `Eduality`.`Post` (`idPost`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Eduality`.`Award`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Eduality`.`Award` (
  `idAward` INT NOT NULL,
  `Type` VARCHAR(45) NOT NULL,
  `dateAchieved` DATE NOT NULL,
  `description` VARCHAR(220) NULL,
  `idPost` INT NOT NULL,
  `idUser` INT NOT NULL,
  PRIMARY KEY (`idAward`, `Type`, `idPost`, `idUser`),
  INDEX `idPost_idx` (`idPost` ASC) VISIBLE,
  INDEX `idUser_idx` (`idUser` ASC) VISIBLE,
  CONSTRAINT `idPost`
    FOREIGN KEY (`idPost`)
    REFERENCES `Eduality`.`Post` (`idPost`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `idUser`
    FOREIGN KEY (`idUser`)
    REFERENCES `Eduality`.`Post` (`idUser`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Eduality`.`Content`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Eduality`.`Content` (
  `idContent` INT NOT NULL AUTO_INCREMENT,
  `idPost` INT NOT NULL,
  `idUser` INT NOT NULL,
  `title` VARCHAR(45) NOT NULL,
  `body` VARCHAR(500) NULL,
  `uploadTime` DATE NOT NULL,
  `upvotes` INT NOT NULL DEFAULT 0,
  PRIMARY KEY (`idContent`, `idUser`, `idPost`),
  INDEX `idUser_idx` (`idUser` ASC) VISIBLE,
  INDEX `idPost_idx` (`idPost` ASC, `idUser` ASC) VISIBLE,
  CONSTRAINT `idUser`
    FOREIGN KEY (`idUser`)
    REFERENCES `Eduality`.`Post` (`idUser`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `idPost`
    FOREIGN KEY (`idPost` , `idUser`)
    REFERENCES `Eduality`.`Post` (`idPost` , `idUser`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Eduality`.`Comment`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Eduality`.`Comment` (
  `idComment` INT NOT NULL AUTO_INCREMENT,
  `idPost` INT NULL,
  `idUser` INT NULL,
  `highlighted` TINYINT NULL,
  `content` VARCHAR(220) NULL,
  PRIMARY KEY (`idComment`),
  INDEX `idUser_idx` (`idUser` ASC) VISIBLE,
  INDEX `idPost_idx` (`idPost` ASC) VISIBLE,
  CONSTRAINT `idUser`
    FOREIGN KEY (`idUser`)
    REFERENCES `Eduality`.`Post` (`idUser`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `idPost`
    FOREIGN KEY (`idPost`)
    REFERENCES `Eduality`.`Post` (`idPost`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;