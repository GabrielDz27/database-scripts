/*
Usado pra banco relacional de um projeto integrador. Sobre despesas...
*/

-- DROP DATABASE PayIt;
CREATE DATABASE PayIt;
USE PayIt;
CREATE TABLE Usuario (
    idUser INT(3) NOT NULL PRIMARY KEY AUTO_INCREMENT,
    email VARCHAR(250) NOT NULL,
    senha VARCHAR(10)
);
CREATE TABLE Despesa(
    idDespesa INT(3) NOT NULL PRIMARY KEY AUTO_INCREMENT,
    fk_idUser INT(3) NOT NULL,
    nome VARCHAR (250) NOT NULL,
    valor INT (250),
    status BOOLEAN,
    diasRestante INT(250) NOT NULL,
    descricao VARCHAR(250),
    FOREIGN KEY(fk_idUser) REFERENCES Usuario(idUser)
);
CREAte TABLE Anexo(
    idAnexo INT (3) NOT NULL PRIMARY KEY AUTO_INCREMENT,
    caminho VARCHAR(250),
    fk_idDespesa INT (3) NOT NULL,
    FOREING KEY(fk_idDespesa) REFERENCES Despesa(idDespesa)
);
CREATE TABLE Localizacao(
    idLocalizacao INT (3) NOT NULL PRIMARY KEY AUTO_INCREMENT,
    endereco VARCHAR(250),
    bairro VARCHAR(250),
    cidade VARCHAR(250),
    fk_idDespesa INT (3) NOT NULL,
    FOREING KEY(fk_idDespesa) REFERENCES Despesa(idDespesa)
);
CREATE TABLE Notificacao(
    idNotificacao INT(3) NOT NULL PRIMARY KEY AUTO_INCREMENT,
    diasAntes INT(250),
    fk_idDespesa INT (3) NOT NULL,
    FOREING KEY(fk_idDespesa) REFERENCES Despesa(idDespesa)
);
CREATE TABLE Recorrente(
    id INT(3) NOT NULL PRIMARY KEY AUTO_INCREMENT,
    mensalAnual INT(250),
    diaInicial DATETIME,
    fk_idDespesa INT (3) NOT NULL,
    FOREING KEY(fk_idDespesa) REFERENCES Despesa(idDespesa)
);
CREATE TABLE Parcelado(
    id INT(3) NOT NULL PRIMARY KEY AUTO_INCREMENT,
    quantidadeParcelas INT(250),
    diaInicial DATETIME,
    fk_idDespesa INT (3) NOT NULL,
    FOREING KEY(fk_idDespesa) REFERENCES Despesa(idDespesa)
);
CREATE TABLE Unico(
    id INT(3) NOT NULL PRIMARY KEY AUTO_INCREMENT,
    dataVencimento DATETIME,
    fk_idDespesa INT (3) NOT NULL,
    FOREING KEY(fk_idDespesa) REFERENCES Despesa(idDespesa)
);