CREATE DATABASE exercicioCursores
use exercicioCursores

create table envio (
CPF varchar(20),
NR_LINHA_ARQUIV	int,
CD_FILIAL int,
DT_ENVIO datetime,
NR_DDD int,
NR_TELEFONE	varchar(10),
NR_RAMAL varchar(10),
DT_PROCESSAMENT	datetime,
NM_ENDERECO varchar(200),
NR_ENDERECO int,
NM_COMPLEMENTO	varchar(50),
NM_BAIRRO varchar(100),
NR_CEP varchar(10),
NM_CIDADE varchar(100),
NM_UF varchar(2)
)

create table endereço(
CPF varchar(20),
CEP	varchar(10),
PORTA	int,
ENDEREÇO	varchar(200),
COMPLEMENTO	varchar(100),
BAIRRO	varchar(100),
CIDADE	varchar(100),
UF Varchar(2)
)

create procedure sp_insereenvio
as
declare @cpf as int
declare @cont1 as int
declare @cont2 as int
declare @conttotal as int
set @cpf = 11111
set @cont1 = 1
set @cont2 = 1
set @conttotal = 1
	while @cont1 <= @cont2 and @cont2 < = 100
			begin
				insert into envio (CPF, NR_LINHA_ARQUIV, DT_ENVIO)
				values (cast(@cpf as varchar(20)), @cont1,GETDATE())
				insert into endereço (CPF,PORTA,ENDEREÇO)
				values (@cpf,@conttotal,CAST(@cont2 as varchar(3))+'Rua '+CAST(@conttotal as varchar(5)))
				set @cont1 = @cont1 + 1
				set @conttotal = @conttotal + 1
				if @cont1 > = @cont2
					begin
						set @cont1 = 1
						set @cont2 = @cont2 + 1
						set @cpf = @cpf + 1
					end
	end

exec sp_insereenvio

CREATE PROCEDURE sp_insereEndereco(@cpf INT)
AS
	DECLARE @linha INT,
			@dt_envio DATETIME,
			@endereco VARCHAR(100), --tabela endereco
			@porta INT

	DECLARE c CURSOR FOR
		SELECT NR_LINHA_ARQUIV, DT_ENVIO FROM envio WHERE CPF = @cpf
	OPEN c
	FETCH NEXT FROM c INTO @linha, @dt_envio 
	WHILE @@FETCH_STATUS = 0 
	BEGIN
	--	PRINT @linha
	--	PRINT @dt_envio
		-------------------------------------------------
		DECLARE c1 CURSOR FOR
			SELECT DISTINCT PORTA, ENDEREÇO FROM endereço WHERE PORTA = @linha
		OPEN c1
		FETCH NEXT FROM c1 INTO @porta, @endereco
		WHILE @@FETCH_STATUS = 0
		BEGIN
		--	PRINT @endereco
		--	PRINT '----------------------------'
			UPDATE envio
			SET NM_ENDERECO = @endereco
			WHERE CPF = @cpf
				  AND NR_LINHA_ARQUIV = @porta
		FETCH NEXT FROM c1 INTO @porta, @endereco
		END
		CLOSE c1
		DEALLOCATE c1
		--------------------------------------------------
		FETCH NEXT FROM c INTO @linha, @dt_envio
	END
	CLOSE c
	DEALLOCATE c

EXEC sp_insereEndereco @cpf = 11129

