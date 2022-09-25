CREATE DATABASE udf
GO
USE udf
GO
CREATE TABLE Funcionario
(
Codigo		INT NOT NULL,
Nome		VARCHAR(100) NOT NULL,
Salario		DECIMAL(7,2) NOT NULL
PRIMARY KEY(codigo)
)
GO
CREATE TABLE Dependente 
(
Codigo_Funcionario	 INT NOT NULL,
Nome_Dependente		 VARCHAR(100) NOT NULL,
Salario_Dependente	 DECIMAL(7,2) NOT NULL
PRIMARY KEY(Codigo_Funcionario),
FOREIGN KEY(Codigo_Funcionario) REFERENCES Funcionario(Codigo)
)

DECLARE @cod INT,
		@nome VARCHAR(100),
		@salario DECIMAL(7,2)
SET @cod = 1
		WHILE(@cod < 21)
		BEGIN
			SET @nome = 'Fulano ' + CAST(@cod AS VARCHAR)
			SET @salario = 1000 + (RAND() * 500) + 100
			INSERT INTO Funcionario VALUES
			(@cod, @nome, @salario)
		SET @cod = @cod + 1
		END

DECLARE @codF INT,
		@nomeP VARCHAR(100),
		@salario DECIMAL(7,2)
SET @codF = 1
		WHILE(@codF < 21)
		BEGIN 
			SET @nomeP = 'Beltrano ' + CAST(@codF * 5 as varchar)
			SET @salario = 900 + (RAND() * 300) + 100
			INSERT INTO Dependente VALUES
			(@codF, @nomeP, @salario)
		SET @codF = @codF + 1 
		END

SELECT * FROM Funcionario
SELECT * FROM Dependente

--Retorne uma tabela 
--Nome_funcionario, dependente, salario funcionario e dependente
CREATE FUNCTION tab ()
RETURNS @tabela TABLE (
Nome		VARCHAR(100) NOT NULL,
Nome_Dependente		 VARCHAR(100) NOT NULL,
Salario		DECIMAL(7,2) NOT NULL,
Salario_Dependente	 DECIMAL(7,2) NOT NULL
)
AS
BEGIN
	INSERT INTO @tabela (Nome, Nome_Dependente, Salario, Salario_Dependente)
		SELECT fn.Nome, dp.Nome_Dependente, fn.Salario, dp.Salario_Dependente 
		FROM Funcionario fn, Dependente dp
		WHERE dp.Codigo_Funcionario = fn.Codigo
	RETURN
END

SELECT * FROM tab()

--Scalar function que retorne a soma dos salarios dos depentendes + a dos funcionarios
CREATE FUNCTION somaSalario()
RETURNS DECIMAL(7,2)
AS
BEGIN
	DECLARE @total DECIMAL(7,2)
		
	SET @total = (SELECT (SUM(fn.Salario) + SUM(dp.Salario_Dependente))
				  FROM Funcionario fn, Dependente dp
				  WHERE dp.Codigo_Funcionario = fn.Codigo)
	RETURN(@total)
END

SELECT dbo.somaSalario()
