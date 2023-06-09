-- MySQL Script generated by MySQL Workbench
-- Thu May 18 21:28:17 2023
-- Model: New Model    Version: 1.0
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
CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8 ;
USE `mydb` ;

-- -----------------------------------------------------
-- Table `mydb`.`Cantina`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Cantina` (
  `idCantina` INT NOT NULL AUTO_INCREMENT,
  `CNPJ` VARCHAR(18) NOT NULL,
  `RazaoSocial` VARCHAR(100) NOT NULL,
  `NomeFantasia` VARCHAR(100) NOT NULL,
  `Email` VARCHAR(100) NOT NULL,
  `Escola` VARCHAR(100) NOT NULL,
  `Endereco` VARCHAR(250) NOT NULL,
  `Cidade` VARCHAR(100) NOT NULL,
  `Estado` CHAR(2) NOT NULL,
  PRIMARY KEY (`idCantina`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Aluno`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Aluno` (
  `idAluno` INT NOT NULL AUTO_INCREMENT,
  `Nome` VARCHAR(40) NOT NULL,
  `Sobrenome` VARCHAR(45) NOT NULL,
  `Telefone` VARCHAR(16) NOT NULL,
  `Sexo` CHAR(1) NOT NULL,
  `Email` VARCHAR(255) NOT NULL,
  `Cantina_idCantina` INT NOT NULL,
  PRIMARY KEY (`idAluno`),
  INDEX `fk_Alunos_Cantina_idx` (`Cantina_idCantina` ASC) VISIBLE,
  CONSTRAINT `fk_Alunos_Cantina`
    FOREIGN KEY (`Cantina_idCantina`)
    REFERENCES `mydb`.`Cantina` (`idCantina`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Categoria`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Categoria` (
  `idCategoria` INT NOT NULL AUTO_INCREMENT,
  `Nome` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idCategoria`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Lanche`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Lanche` (
  `idLanche` INT NOT NULL AUTO_INCREMENT,
  `Nome` VARCHAR(45) NOT NULL,
  `Valor` DECIMAL(3,2) NOT NULL,
  `Imagem` MEDIUMBLOB NULL,
  `Descricao` VARCHAR(500) NULL,
  `Cantina_idCantina` INT NOT NULL,
  `Categoria_idCategoria` INT NOT NULL,
  PRIMARY KEY (`idLanche`),
  INDEX `fk_Lanche_Cantina1_idx` (`Cantina_idCantina` ASC) VISIBLE,
  INDEX `fk_Lanche_Categoria1_idx` (`Categoria_idCategoria` ASC) VISIBLE,
  CONSTRAINT `fk_Lanche_Cantina1`
    FOREIGN KEY (`Cantina_idCantina`)
    REFERENCES `mydb`.`Cantina` (`idCantina`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Lanche_Categoria1`
    FOREIGN KEY (`Categoria_idCategoria`)
    REFERENCES `mydb`.`Categoria` (`idCategoria`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Pedido`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Pedido` (
  `idPedido` INT NOT NULL AUTO_INCREMENT,
  `Data` DATE NOT NULL,
  `Status` VARCHAR(15) NOT NULL,
  `Cantina_idCantina` INT NOT NULL,
  `Aluno_idAluno` INT NOT NULL,
  PRIMARY KEY (`idPedido`),
  INDEX `fk_Pedido_Cantina1_idx` (`Cantina_idCantina` ASC) VISIBLE,
  INDEX `fk_Pedido_Alunos1_idx` (`Aluno_idAluno` ASC) VISIBLE,
  CONSTRAINT `fk_Pedido_Cantina1`
    FOREIGN KEY (`Cantina_idCantina`)
    REFERENCES `mydb`.`Cantina` (`idCantina`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Pedido_Alunos1`
    FOREIGN KEY (`Aluno_idAluno`)
    REFERENCES `mydb`.`Aluno` (`idAluno`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Pagamento`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Pagamento` (
  `idPagamento` INT NOT NULL AUTO_INCREMENT,
  `FormaPagamento` VARCHAR(45) NOT NULL,
  `Data` DATE NOT NULL,
  `Aluno_idAluno` INT NOT NULL,
  PRIMARY KEY (`idPagamento`),
  INDEX `fk_Pagamento_Aluno1_idx` (`Aluno_idAluno` ASC) VISIBLE,
  CONSTRAINT `fk_Pagamento_Aluno1`
    FOREIGN KEY (`Aluno_idAluno`)
    REFERENCES `mydb`.`Aluno` (`idAluno`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Itens_Carrinho`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Itens_Carrinho` (
  `Lanche_idLanche` INT NOT NULL,
  `Pedido_idPedido` INT NOT NULL,
  `data` DATETIME NOT NULL,
  `Quantidade` INT NOT NULL,
  PRIMARY KEY (`Lanche_idLanche`, `Pedido_idPedido`),
  INDEX `fk_Pedido_tem_Lanche_Pedido1_idx` (`Pedido_idPedido` ASC) VISIBLE,
  CONSTRAINT `fk_Pedido_tem_Lanche_Lanche1`
    FOREIGN KEY (`Lanche_idLanche`)
    REFERENCES `mydb`.`Lanche` (`idLanche`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Pedido_tem_Lanche_Pedido1`
    FOREIGN KEY (`Pedido_idPedido`)
    REFERENCES `mydb`.`Pedido` (`idPedido`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Comentario`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Comentario` (
  `idComentario` INT NOT NULL AUTO_INCREMENT,
  `Estrelas` TINYINT(5) NOT NULL,
  `Titulo` VARCHAR(45) NULL,
  `Descricao` VARCHAR(500) NULL,
  `Aluno_idAluno` INT NOT NULL,
  `Lanche_idLanche` INT NOT NULL,
  PRIMARY KEY (`idComentario`),
  INDEX `fk_Comentario_Aluno1_idx` (`Aluno_idAluno` ASC) VISIBLE,
  INDEX `fk_Comentario_Lanche1_idx` (`Lanche_idLanche` ASC) VISIBLE,
  CONSTRAINT `fk_Comentario_Aluno1`
    FOREIGN KEY (`Aluno_idAluno`)
    REFERENCES `mydb`.`Aluno` (`idAluno`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Comentario_Lanche1`
    FOREIGN KEY (`Lanche_idLanche`)
    REFERENCES `mydb`.`Lanche` (`idLanche`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Responsavel`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Responsavel` (
  `idResponsavel` INT NOT NULL AUTO_INCREMENT,
  `Nome` VARCHAR(80) NOT NULL,
  `CPF` VARCHAR(11) NOT NULL,
  `Cantina_idCantina` INT NOT NULL,
  PRIMARY KEY (`idResponsavel`),
  INDEX `fk_Responsavel_Cantina1_idx` (`Cantina_idCantina` ASC) VISIBLE,
  CONSTRAINT `fk_Responsavel_Cantina1`
    FOREIGN KEY (`Cantina_idCantina`)
    REFERENCES `mydb`.`Cantina` (`idCantina`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
