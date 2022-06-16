DROP DATABASE IF EXISTS ProjetoFinal_BD;
CREATE DATABASE ProjetoFinal_BD;
USE ProjetoFinal_BD;

DROP USER douglas@localhost;
CREATE USER douglas@localhost IDENTIFIED BY 'dba';
GRANT ALL PRIVILEGES ON *.* TO douglas@localhost;
FLUSH PRIVILEGES;

CREATE TABLE Dono (
    Nome VARCHAR(45) NOT NULL,
	Cpf VARCHAR(25) NOT NULL,
    Cnpj VARCHAR(25) NOT NULL,
    Telefone VARCHAR(20),
    Idade TINYINT,
    PRIMARY KEY(Cnpj)
);

CREATE TABLE Empresa (
	Id INT NOT NULL,
    Nome VARCHAR(40),
    CnpjDono VARCHAR(25) NOT NULL,
    Telefone VARCHAR(20),
    DataCriacao VARCHAR(20),
    Localizacao VARCHAR(30),
    PRIMARY KEY(Id),
    CONSTRAINT fk1
    FOREIGN KEY(CnpjDono)
    REFERENCES Dono (Cnpj)
    ON DELETE CASCADE
    ON UPDATE CASCADE
);

CREATE TABLE Funcionarios (
	PNome VARCHAR(20),
    Sobrenome VARCHAR(25),
    SSN VARCHAR(20) NOT NULL,
    Idade INT NOT NULL,
    Sexo BIT, #0 para F e 1 para M
    Salario DECIMAL(10,2),
    SSN_Supervisor VARCHAR(20),
    IdEmpresa INT NOT NULL,
    
    PRIMARY KEY(SSN),
    CONSTRAINT fk2
    FOREIGN KEY(SSN_Supervisor)
    REFERENCES Funcionarios (SSN)
    ON DELETE SET NULL
    ON UPDATE CASCADE,
    FOREIGN KEY(IdEmpresa)
    REFERENCES Empresa (Id)
    ON UPDATE CASCADE
    ON DELETE CASCADE
);
	
CREATE TABLE Clientes (
	Nome VARCHAR(45),
	Cpf VARCHAR(25) NOT NULL,
    IdEmpresa INT NOT NULL,
    Descrição VARCHAR(15),
    DataPrimeiraCompra VARCHAR(20),
    Telefone VARCHAR(20),
    PRIMARY KEY(Cpf),
    CONSTRAINT fk3
    FOREIGN KEY(IdEmpresa)
    REFERENCES Empresa (Id)
    ON DELETE CASCADE
    ON UPDATE CASCADE
);

CREATE TABLE Serviços (
	IdEmpresa INT,
    CpfCliente VARCHAR(25),
    CONSTRAINT fk4
    FOREIGN KEY(IdEmpresa)
    REFERENCES Empresa (Id)
    ON UPDATE CASCADE
    ON DELETE CASCADE,
    CONSTRAINT fk5
    FOREIGN KEY(CpfCliente)
    REFERENCES Clientes (Cpf)
    ON UPDATE CASCADE
    ON DELETE CASCADE,
    PRIMARY KEY(IdEmpresa, CpfCliente)
);
    
CREATE TABLE Possiveis_Clientes (
	Nome VARCHAR(45),
    IdEmpresaProcurada INT NOT NULL,
    Cpf VARCHAR(25) NOT NULL,
    DataContato VARCHAR(20),
    Telefone VARCHAR(20),
    PRIMARY KEY(Cpf),
    CONSTRAINT fk6
    FOREIGN KEY(IdEmpresaProcurada)
    REFERENCES Empresa (Id)
    ON UPDATE CASCADE
    ON DELETE CASCADE
);

#Criação do Dono das Empresas
INSERT INTO Dono VALUES ('Ricardo', '111.798.876-70', '63.865.302/0001-42', '98821-4957', 40);

#Criação de duas Empresas pertencentes ao mesmo Dono
INSERT INTO Empresa VALUES (1, 'Tecnologia Pals', '63.865.302/0001-42', '97754-8695', '10/05/2021', 'Pouso Alegre - MG');
INSERT INTO Empresa VALUES (2, 'Metaverso Pod', '63.865.302/0001-42', '95345-6853', '12/08/2021', 'Santa Rita do Sapucaí - MG');

#Criação dos Funcionarios para as duas Empresas
INSERT INTO Funcionarios VALUES ('Robson', 'Pereira', '540-50-0757', 28, 1, 3000.00, '540-50-0757', 1);  
INSERT INTO Funcionarios VALUES ('Maria', 'Souza', '213-10-1697', 25, 0, 2000.00, '540-50-0757', 1);  
INSERT INTO Funcionarios VALUES ('Rafaela', 'Lima', '252-54-5204', 25, 0, 2800.00, '252-54-5204', 2); 

#Criaçao de dois Clientes
INSERT INTO Clientes VALUES ('Marcos', '035.829.190-99', 1, 'Classe alta', '26/06/2021', '95743-5425');

#Criação de um Possível Cliente
INSERT INTO Possiveis_Clientes VALUES ('Isabella', 1, '162.551.311-90', '02/11/2021', '97295-5934');
INSERT INTO Possiveis_Clientes VALUES ('Lila', 2, '371.486.108-42', '18/01/2022', '96332-9864');

SELECT * FROM Dono;
SELECT * FROM Empresa;
SELECT * FROM Funcionarios;
SELECT * FROM Clientes;
SELECT * FROM Possiveis_Clientes;

UPDATE Dono SET Idade = 42 WHERE Cnpj = '63.865.302/0001-42';
UPDATE Funcionarios SET Salario = '3400.00' WHERE SSN = '540-50-0757';

SELECT * FROM Dono;
SELECT PNome, Salario FROM Funcionarios WHERE SSN = '540-50-0757';

DELETE FROM Possiveis_Clientes WHERE Cpf = '371.486.108-42';
DELETE FROM Funcionarios WHERE SSN = '213-10-1697';

SELECT * FROM Possiveis_Clientes;
SELECT * FROM Funcionarios;