CREATE DATABASE meu_banco_de_dados;
USE meu_banco_de_dados;

-- Criação do banco de dados e tabelas
CREATE DATABASE IF NOT EXISTS Empresa;
USE Empresa;

CREATE TABLE DEPARTAMENTO (
    DNome VARCHAR(50),
    Codigo INT,
    Gerente INT,
    PRIMARY KEY (Codigo)
);

CREATE TABLE EMPREGADO (
    ENome VARCHAR(50),
    CPF INT,
    Endereco VARCHAR(100),
    Nasc DATE,
    Sexo CHAR(1),
    Salario FLOAT,
    CDep INT,
    PRIMARY KEY (CPF),
    FOREIGN KEY (CDep) REFERENCES DEPARTAMENTO(Codigo)
);

CREATE TABLE TAREFA (
    CPF INT,
    PCodigo VARCHAR(10),
    Horas INT,
    PRIMARY KEY (CPF, PCodigo),
    FOREIGN KEY (CPF) REFERENCES EMPREGADO(CPF)
);

CREATE TABLE PROJETO (
    PNome VARCHAR(50),
    PCodigo VARCHAR(10),
    Cidade VARCHAR(50),
    CDep INT,
    PRIMARY KEY (PCodigo),
    FOREIGN KEY (CDep) REFERENCES DEPARTAMENTO(Codigo)
);

-- Inserção de dados nas tabelas
INSERT INTO DEPARTAMENTO (DNome, Codigo, Gerente) VALUES
('Pesquisa', 3, 1234),
('Marketing', 2, 6543),
('Administração', 4, 8765);

INSERT INTO EMPREGADO (ENome, CPF, Endereco, Nasc, Sexo, Salario, CDep) VALUES
('Carlos', 1234, 'Rua 1', '1962-02-02', 'M', 8000, 3),
('Maria', 4321, 'Rua 1', '1962-02-03', 'F', 10000, 2),
('Paulo', 5678, 'Rua 1', '1962-02-03', 'M', 6000, 3),
('Tiago', 8765, 'Rua 1', '1962-02-05', 'M', 7000, 4),
('Ana', 3456, 'Rua 1', '1962-02-06', 'F', 12000, 2),
('Clara', 6543, 'Rua 1', '1962-02-07', 'F', 8000, 2);

INSERT INTO TAREFA (CPF, PCodigo, Horas) VALUES
(1234, 'PA', 30),
(1234, 'PB', 10),
(4321, 'PA', 5),
(4321, 'PB', 4),
(5678, 'PA', 5),
(8765, 'PD', 8),
(8765, 'PB', 7),
(3456, 'PA', 9),
(3456, 'PB', 10),
(3456, 'PD', 40),
(6543, 'PB', 8);

INSERT INTO PROJETO (PNome, PCodigo, Cidade, CDep) VALUES
('Produto A', 'PA', 'Fortaleza', 3),
('Produto B', 'PB', 'Maranguape', 4),
('Produto C', 'PC', 'Maracanã', 4),
('Produto D', 'PD', 'Baturité', 2);


SELECT * FROM DEPARTAMENTO;
SELECT * FROM PROJETO;
SELECT * FROM TAREFA;
SELECT * FROM EMPREGADO;


SHOW TABLES;

-- Consultas descritas no arquivo

USE Empresa;

SELECT ENome, Salario 
FROM EMPREGADO 
WHERE CDep = (SELECT Codigo FROM DEPARTAMENTO WHERE DNome = 'Marketing');


SELECT CPF 
FROM EMPREGADO 
WHERE CDep = (SELECT Codigo FROM DEPARTAMENTO WHERE DNome = 'Pesquisa') 
OR CPF IN (SELECT Gerente FROM DEPARTAMENTO WHERE Codigo = (SELECT Codigo FROM DEPARTAMENTO WHERE DNome = 'Pesquisa'));


SELECT PNome, Cidade 
FROM PROJETO 
WHERE PCodigo IN (SELECT PCodigo FROM TAREFA WHERE Horas > 30);


SELECT E.ENome, E.Nasc 
FROM EMPREGADO E
JOIN DEPARTAMENTO D ON E.CPF = D.Gerente;


SELECT ENome, Endereco 
FROM EMPREGADO 
WHERE CDep = (SELECT Codigo FROM DEPARTAMENTO WHERE DNome = 'Pesquisa');


SELECT P.PCodigo, D.DNome, E.ENome 
FROM PROJETO P
JOIN DEPARTAMENTO D ON P.CDep = D.Codigo
JOIN EMPREGADO E ON D.Gerente = E.CPF
WHERE P.Cidade = 'Fortaleza';


SELECT ENome, Sexo 
FROM EMPREGADO 
WHERE CPF NOT IN (SELECT Gerente FROM DEPARTAMENTO);
