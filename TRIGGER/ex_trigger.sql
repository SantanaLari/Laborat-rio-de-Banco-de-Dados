CREATE DATABASE ex_FuncaoTriggers
go
use ex_FuncaoTriggers

CREATE TABLE Produto
(
Codigo			INT				NOT NULL,
Nome			VARCHAR(100)	NOT NULL,
Descricao		VARCHAR(100)	NOT NULL,
Valor_Unitario	DECIMAL(7,2)	NOT NULL
PRIMARY KEY(Codigo)
)

CREATE TABLE Estoque 
(
Codigo_Produto		INT			NOT NULL, 
Qtd_Estoque			INT			NOT NULL,
Estoque_Minimo		INT			NOT NULL
PRIMARY KEY(Codigo_Produto)
FOREIGN KEY(Codigo_Produto) REFERENCES Produto(Codigo)
)

CREATE TABLE Venda
(
Nota_Fiscal			INT			NOT NULL,
Codigo_Produto		INT			NOT NULL,
Quantidade			INT			NOT NULL
PRIMARY KEY(Nota_Fiscal),
FOREIGN KEY(Codigo_Produto) REFERENCES Produto(Codigo)
)

INSERT INTO Produto VALUES
(1, 'Notebook', 'Produto eletronico da DELL', 2100.0),
(2, 'Livro', 'Produto da serie A Selecao', 59.0),
(3, 'Celular', 'Produto eletronico da Motorola', 1200.0)

INSERT INTO Produto VALUES
(4, 'TV', 'Produto eletronico da Philco', 2000.0)

INSERT INTO Produto VALUES
(5, 'Playstation3', '4002-8922 Bom dia e Cia', 3000.0)

INSERT INTO estoque VALUES
(1, 5, 10), --quantidade no estoque está abaixo da minima
(2, 10, 5), --quantidade no estoque está acima
(3, 10, 10), --quantidade no estoque vai ficar abaixo na proxima venda
(4, 0, 5) --não tem no estoque

INSERT INTO estoque VALUES
(5, 25, 10) --ta perfeito

--TRIGGER
CREATE TRIGGER t_verificaEstoque ON venda
AFTER INSERT
AS
BEGIN
	DECLARE @qtd INT, --quantidade que o cliente quer comprar
			@cod INT, --codigo do produto que o cliente quer
			@nf INT --nota fiscal da venda
			
	DECLARE @estoque INT, --estoque do produto (tabela estoque)
			@estoqueMinimo INT,
			@totalEstoque INT

	SET @nf = (SELECT Nota_Fiscal FROM inserted)
	SET @cod = (SELECT Codigo_Produto FROM inserted)
	SET @qtd = (SELECT Quantidade FROM inserted)
	SET @estoque = (SELECT Qtd_Estoque FROM Estoque WHERE Codigo_Produto = @cod)
	SET @estoqueMinimo = (SELECT Estoque_Minimo FROM Estoque WHERE Codigo_Produto = @cod)
	

	PRINT @nf
	PRINT @cod
	PRINT @qtd
	PRINT @estoque

	IF (@qtd < @estoque AND @qtd != 0)
	BEGIN
		PRINT 'Venda realizada com sucesso'
		IF (@estoque < @estoqueMinimo)
		BEGIN
			RAISERROR('A quantidade em estoque do produto está ABAIXO DO MINIMO!', 16, 1)
		END
		ELSE
		BEGIN
			SET @totalEstoque = @estoque - @qtd
			IF(@totalEstoque < @estoqueMinimo)
			BEGIN
				RAISERROR('A quantidade em estoque ficará ABAIXO DO MINIMO ao concluir a venda!', 16, 1)
			END
			ELSE
			BEGIN
				PRINT 'Ta tudo ok, meu rei.'
			END
		END
	END
	ELSE
	BEGIN
		ROLLBACK TRANSACTION
		RAISERROR('Venda não autorizada', 16, 1)
	END
END

DROP TRIGGER t_verificaEstoque

--Venda nao disponivel
INSERT INTO venda VALUES
(111, 4, 0)

--Venda disponivel (e ficará com estoque abaixo depois da compra)
INSERT INTO venda VALUES
(222, 3, 5)

--Estoque vai ficar abaixo do minimo apos a compra
INSERT INTO venda VALUES
(333, 2, 6)

--Estoque já está abaixo do minimo
INSERT INTO venda VALUES
(444, 1, 1) 

--Ta tudo ok
INSERT INTO venda VALUES
(555, 5, 1)


--FUNCTION
ALTER FUNCTION f_nf(@nota_fiscal INT)
RETURNS @table TABLE(
Nota_Fiscal			INT,
Codigo_Produto		INT,
Nome_Produto		VARCHAR(100),
Descricao_Produto	VARCHAR(100),
Valor_Unitario		DECIMAL(7,2),
Quantidade			INT,
Valor_Total			DECIMAL(7,2)	
)
AS
BEGIN
	DECLARE @nf INT,
			@codP INT,
			@nome VARCHAR(100),
			@desc VARCHAR(100),
			@valorU DECIMAL(7,2),
			@qtd INT,
			@valorT DECIMAL(7,2)

	SET @nf = @nota_fiscal
	SET @codP = (SELECT Codigo_Produto FROM Venda WHERE Nota_Fiscal = @nota_fiscal)
	SET @nome = (SELECT Nome FROM Venda, Produto WHERE Codigo_Produto = Codigo AND Nota_Fiscal = @nota_fiscal)
	SET @desc = (SELECT Descricao FROM Venda, Produto WHERE Codigo_Produto = Codigo AND Nota_Fiscal = @nota_fiscal)
	SET @valorU = (SELECT Valor_Unitario FROM Venda, Produto WHERE Codigo_Produto = Codigo AND Nota_Fiscal = @nota_fiscal)
	SET @qtd = (SELECT Quantidade FROM Venda WHERE Nota_Fiscal = @nota_fiscal)
	SET @valorT = @valorU * @qtd

	INSERT INTO @table VALUES
	(@nf, @codP, @nome, @desc, @valorU, @qtd, @valorT)

	RETURN
END

SELECT * FROM f_nf(333)
SELECT * FROM f_nf(444)

SELECT * FROM venda
