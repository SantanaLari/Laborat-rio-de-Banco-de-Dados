CREATE DATABASE exAlgoritmo
use exAlgoritmo

--a) fazer um algoritmo que leia 1 numero e mostre se são multiplos de 2,3,5 ou nenhum deles
DECLARE @var	INT
SET @var = RAND() * 100
PRINT(@var)
IF(@var % 2 = 0)
BEGIN
	PRINT('Multiplo de 2')
END
ELSE
IF(@var % 3 = 0)
BEGIN
	PRINT('Multiplo de 3')
END
ELSE
IF(@var % 5 = 0)
BEGIN
	PRINT('Multiplo de 5')
END
ELSE
BEGIN
	PRINT('Não é multiplo de nenhum')
END

--b) fazer um algoritmo que leia 3 numeros e mostre o maior e o menor
DECLARE @n1		INT,
		@n2		INT,
		@n3		INT,
		@maior  INT,
		@menor  INT
SET @n1 = RAND() * 100
SET	@n2 = RAND() * 100
SET	@n3 = RAND() * 100
PRINT(@n1)
PRINT(@n2)
PRINT(@n3)
IF (@n1 > @n2) AND (@n1 > @n3) AND (@n2 < @n3)
BEGIN
	SET @maior = @n1
	SET @menor = @n2
END
ELSE
IF (@n1 > @n2) AND (@n1 > @n3) AND (@n3 < @n2)
BEGIN
	SET @maior = @n1
	SET @menor = @n3
END
ELSE
IF (@n2 > @n1) AND (@n2 > @n3) AND (@n1 < @n3)
BEGIN
	SET @maior = @n2
	SET @menor = @n1
END
ELSE
IF (@n2 > @n1) AND (@n2 > @n3) AND (@n3 < @n1)
BEGIN
	SET @maior = @n2
	SET @menor = @n3
END
ELSE
IF (@n3 > @n1) AND (@n3 > @n2) AND (@n1 < @n2)
BEGIN
	SET @maior = @n3
	SET @menor = @n1
END
ELSE
IF (@n3 > @n1) AND (@n3 > @n2) AND (@n2 < @n1)
BEGIN
	SET @maior = @n3
	SET @menor = @n2
END

PRINT('Maior: ' + CAST(@maior AS VARCHAR))
PRINT('Menor: ' + CAST(@menor AS VARCHAR))

--c) fazer um algoritmo que calcule os 15 primeiros termos da serie
DECLARE @primeiro   INT,
        @segundo    INT,
        @aux        INT,
		@cont        INT
SET @cont = 1
SET @primeiro = 1
SET @segundo = 1
WHILE (@cont <= 15)
BEGIN
    SET @aux = @primeiro + @segundo
    PRINT(@primeiro + @segundo)
    SET @cont = @cont + 1
	SET @primeiro = @segundo
	SET @segundo = @aux
END

--d) fazer um algoritmo que separe uma frase, colocando todas as letras em maiusculo e em minusculo
--usar UPPER e LOWER
DECLARE @frase VARCHAR(100),
		@MAIUSCULO VARCHAR(100),
		@minusculo VARCHAR(100)
BEGIN
SET @frase = 'Laboratorio de Banco de Dados'
SET @MAIUSCULO = uPPER(@frase)
SET @minusculo = LOWER(@frase)
PRINT(@MAIUSCULO)
PRINT(@minusculo)
END


--e) fazer um algoritmo que inverts uma palavra 
--SubstriNG

DECLARE @palavra varchar(3),
		@invertida varchar(3)
SET @palavra = 'dia'
BEGIN
	SET @invertida = SUBSTRING(@palavra, 3,3) + SUBSTRING(@palavra, 2,1) + SUBSTRING(@palavra, 1,1)
END
PRINT(@invertida)
