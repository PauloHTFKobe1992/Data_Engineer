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
CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8mb3 ;
USE `mydb` ;

-- -----------------------------------------------------
-- Table `mydb`.`category`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`category` (
  `categoryId` INT NOT NULL,
  `categoryDescripcion` VARCHAR(255) NULL DEFAULT NULL,
  `path` VARCHAR(255) NULL DEFAULT NULL,
  PRIMARY KEY (`categoryId`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `mydb`.`customer`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`customer` (
  `customerId` INT NOT NULL,
  `email` VARCHAR(255) NULL DEFAULT NULL,
  `nombre` VARCHAR(45) NULL DEFAULT NULL,
  `apellido` VARCHAR(45) NULL DEFAULT NULL,
  `sexo` VARCHAR(1) NULL DEFAULT NULL,
  `direccion` VARCHAR(45) NULL DEFAULT NULL,
  `fechaNacimiento` DATE NULL DEFAULT NULL,
  `telefono` INT NULL DEFAULT NULL,
  `isBuyer` INT NULL DEFAULT NULL,
  `isSeller` INT NULL DEFAULT NULL,
  PRIMARY KEY (`customerId`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `mydb`.`company`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`company` (
  `idCompany` INT NOT NULL,
  `Customer_customerId` INT NOT NULL,
  `CNPJ` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`idCompany`),
  INDEX `fk_Company_Customer1_idx` (`Customer_customerId` ASC) VISIBLE,
  CONSTRAINT `fk_Company_Customer1`
    FOREIGN KEY (`Customer_customerId`)
    REFERENCES `mydb`.`customer` (`customerId`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `mydb`.`individualcustomer`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`individualcustomer` (
  `idIndividualCustomer` INT NOT NULL,
  `rg` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`idIndividualCustomer`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `mydb`.`item`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`item` (
  `itemId` INT NOT NULL,
  `categorryId` INT NOT NULL,
  `nombre` VARCHAR(100) NULL DEFAULT NULL,
  `descripcion` VARCHAR(255) NULL DEFAULT NULL,
  `precio` DECIMAL(10,0) NULL DEFAULT NULL,
  `estado` VARCHAR(45) NULL DEFAULT NULL,
  `fechaBaja` DATETIME NULL DEFAULT NULL,
  PRIMARY KEY (`itemId`),
  INDEX `fk_Item_Category1_idx` (`categorryId` ASC) VISIBLE,
  CONSTRAINT `fk_Item_Category1`
    FOREIGN KEY (`categorryId`)
    REFERENCES `mydb`.`category` (`categoryId`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `mydb`.`itemhistorico`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`itemhistorico` (
  `itemHistoricoId` INT NOT NULL,
  `precio` DECIMAL(10,0) NULL DEFAULT NULL,
  `estado` VARCHAR(45) NULL DEFAULT NULL,
  `audUptd` DATETIME NULL DEFAULT NULL,
  `Item_itemId` INT NOT NULL,
  PRIMARY KEY (`itemHistoricoId`),
  INDEX `fk_itemHistorico_Item1_idx` (`Item_itemId` ASC) VISIBLE,
  CONSTRAINT `fk_itemHistorico_Item1`
    FOREIGN KEY (`Item_itemId`)
    REFERENCES `mydb`.`item` (`itemId`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `mydb`.`order`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`order` (
  `orderId` INT NOT NULL,
  `Customer_customerId` INT NOT NULL,
  PRIMARY KEY (`orderId`),
  INDEX `fk_Order_Customer_idx` (`Customer_customerId` ASC) VISIBLE,
  CONSTRAINT `fk_Order_Customer`
    FOREIGN KEY (`Customer_customerId`)
    REFERENCES `mydb`.`customer` (`customerId`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `mydb`.`orderitem`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`orderitem` (
  `orderItemId` INT NOT NULL,
  `cantidad` INT NULL DEFAULT NULL,
  `precioUn` DECIMAL(10,0) NULL DEFAULT NULL,
  `Order_orderId` INT NOT NULL,
  `Item_itemId` INT NOT NULL,
  PRIMARY KEY (`orderItemId`),
  INDEX `fk_OrderItem_Order1_idx` (`Order_orderId` ASC) VISIBLE,
  INDEX `fk_OrderItem_Item1_idx` (`Item_itemId` ASC) VISIBLE,
  CONSTRAINT `fk_OrderItem_Item1`
    FOREIGN KEY (`Item_itemId`)
    REFERENCES `mydb`.`item` (`itemId`),
  CONSTRAINT `fk_OrderItem_Order1`
    FOREIGN KEY (`Order_orderId`)
    REFERENCES `mydb`.`order` (`orderId`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `mydb`.`orderstatus`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`orderstatus` (
  `orderStatusId` INT NOT NULL,
  `orderId` INT NOT NULL,
  `statusDescription` VARCHAR(45) NULL DEFAULT NULL,
  `isDefault` INT NULL DEFAULT NULL,
  `isFinal` INT NULL DEFAULT NULL,
  `autUpdt` DATETIME NULL DEFAULT NULL,
  `orderStatuscol` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`orderStatusId`),
  INDEX `fk_orderStatus_Order1_idx` (`orderId` ASC) VISIBLE,
  CONSTRAINT `fk_orderStatus_Order1`
    FOREIGN KEY (`orderId`)
    REFERENCES `mydb`.`order` (`orderId`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `mydb`.`selleritem`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`selleritem` (
  `idsellerItem` INT NOT NULL,
  `Item_itemId` INT NOT NULL,
  `sellerId` INT NOT NULL,
  PRIMARY KEY (`idsellerItem`),
  INDEX `fk_sellerItem_Item1_idx` (`Item_itemId` ASC) VISIBLE,
  INDEX `fk_sellerItem_Customer1_idx` (`sellerId` ASC) VISIBLE,
  CONSTRAINT `fk_sellerItem_Customer1`
    FOREIGN KEY (`sellerId`)
    REFERENCES `mydb`.`customer` (`customerId`),
  CONSTRAINT `fk_sellerItem_Item1`
    FOREIGN KEY (`Item_itemId`)
    REFERENCES `mydb`.`item` (`itemId`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
