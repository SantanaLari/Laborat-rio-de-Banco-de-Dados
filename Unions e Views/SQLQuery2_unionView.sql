CREATE DATABASE exAula01
use exAula01

CREATE TABLE Motorista
(
codigo			int				not null,
nome			varchar(40)		not null,
naturalidade	varchar(40)		not null
PRIMARY KEY(codigo)
)

CREATE TABLE Onibus
(
placa		char(7)			not null,
marca		varchar(15)		not null,
ano			int				not null,
descricao	varchar(20)		not null
PRIMARY KEY(placa)
)

CREATE TABLE Viagem
(
codigo			int			not null,
onibus			char(7)		not null,
motorista		int			not null,
hora_saida		int			not null,
hora_chegada	int			not null,
partida			varchar(40)	not null,
destino			varchar(40)	not null,
PRIMARY KEY(codigo),
FOREIGN KEY(onibus)		REFERENCES Onibus(placa),
FOREIGN KEY(motorista)	REFERENCES Motorista(codigo)
)

SELECT * FROM Motorista
SELECT * FROM Onibus
SELECT * FROM Viagem

--'1) Criar um Union das tabelas Motorista e ônibus, com as colunas ID (Código e Placa) e Nome (Nome e Marca)
SELECT CAST(mt.codigo AS varchar) AS ID,
	   mt.nome AS Nome 
FROM Motorista mt
UNION
SELECT ob.placa AS ID,
	   ob.marca	AS Nome
FROM Onibus ob

--'2) Criar uma View (Chamada v_motorista_onibus) do Union acima
CREATE VIEW v_motorista_onibus
AS
SELECT CAST(mt.codigo AS varchar) AS ID,
	   mt.nome AS Nome 
FROM Motorista mt
UNION
SELECT ob.placa AS ID,
	   ob.marca	AS Nome
FROM Onibus ob

SELECT * FROM v_motorista_onibus

--'3) Criar uma View (Chamada v_descricao_onibus) que mostre o Código da Viagem, o Nome do motorista, a placa do ônibus (Formato XXX-0000), a Marca do ônibus, o Ano do ônibus e a descrição do onibus
CREATE VIEW v_descricao_onibus
AS
SELECT vg.codigo, mt.nome, SUBSTRING(ob.placa,1,3) + '-' + SUBSTRING(ob.placa,3,4) AS placa, 
		ob.marca, ob.ano, ob.descricao
FROM Motorista mt, Onibus ob, Viagem vg
WHERE mt.codigo = vg.motorista
	AND ob.placa = vg.onibus

--'4) Criar uma View (Chamada v_descricao_viagem) que mostre o Código da viagem, a placa do ônibus(Formato XXX-0000), 
--a Hora da Saída da viagem (Formato HH:00), a Hora da Chegada da viagem (Formato HH:00), partida e destino
CREATE VIEW v_descricao_viagem
AS
SELECT vg.codigo, SUBSTRING(ob.placa,1,3) + '-' + SUBSTRING(ob.placa,3,4) AS placa,
	SUBSTRING(CAST(vg.hora_saida AS varchar),1,2) + ':00' AS saida, 
	SUBSTRING(CAST(vg.hora_chegada AS varchar),1,2) + '00' AS chegada,
	vg.partida,
	vg.destino
FROM Viagem vg, Onibus ob
WHERE ob.placa = vg.onibus
