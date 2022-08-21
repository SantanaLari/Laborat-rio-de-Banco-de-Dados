CREATE DATABASE escola
use escola

CREATE TABLE Aluno
(
RA		INT				NOT NULL,
Nome	VARCHAR(100)	NOT NULL,
Idade	INT				NOT NULL,
PRIMARY KEY(RA)
)

CREATE TABLE Disciplina
(
Codigo			INT				NOT NULL,
Nome			VARCHAR(80)		NOT NULL,
Carga_Horaria	INT				NOT NULL,
PRIMARY KEY(Codigo)
)

CREATE TABLE Curso
(
Codigo		INT				NOT NULL,
Nome		VARCHAR(50)		NOT NULL,
Area		VARCHAR(50)		NOT NULL,
PRIMARY KEY(Codigo)
)

CREATE TABLE Titulacao
(
Codigo		INT				NOT NULL,
Titulo		VARCHAR(40)		NOT NULL,
PRIMARY KEY(Codigo)
)

CREATE TABLE Professor
(
Registro		INT				NOT NULL,
Nome			VARCHAR(100)	NOT NULL,
tit				INT				NOT NULL
PRIMARY KEY(Registro),
FOREIGN KEY(tit) REFERENCES Titulacao(Codigo)
)

CREATE TABLE Aluno_Disciplina
(
DisciplinaCodigo	INT		NOT NULL,
AlunoRA				INT		NOT NULL,
PRIMARY KEY(AlunoRA, DisciplinaCodigo),
FOREIGN KEY(AlunoRA) REFERENCES Aluno(RA),
FOREIGN KEY(DisciplinaCodigo) REFERENCES Disciplina(Codigo)
)

CREATE TABLE Curso_Disciplina
(
CursoCodigo			INT		NOT NULL,
DisciplinaCodigo	INT		NOT NULL,
PRIMARY KEY(CursoCodigo, DisciplinaCodigo),
FOREIGN KEY(CursoCodigo) REFERENCES Curso(Codigo),
FOREIGN KEY(DisciplinaCodigo) REFERENCES Disciplina(Codigo)
)

CREATE TABLE Disciplina_Professor
(
DisciplinaCodigo	INT		NOT NULL,
ProfessorRegistro	INT		NOT NULL,
PRIMARY KEY(DisciplinaCodigo, ProfessorRegistro),
FOREIGN KEY(DisciplinaCodigo) REFERENCES Disciplina(Codigo),
FOREIGN KEY(ProfessorRegistro) REFERENCES Professor(Registro)
)

INSERT INTO Aluno VALUES
(3416, 'Diego Piovesan de Ramos', 18),
(3423, 'Leonardo Magalhães da Rosa', 17),
(3434, 'Luiza Cristina de Lima Martineli', 20),
(3440, 'Ivo André Figueira da Silva', 25),
(3443, 'Bruna Luisa Simioni', 37),
(3448, 'Thais Nicolini de Mello', 17),
(3457, 'Lucio Daniel Tamara Alves', 29),
(3459, 'Leonardo Rodrigues', 25),
(3465, 'Ederson Rafael Vieira', 19),
(3466, 'Daiana Zanrosso de Oliveira', 21),
(3467, 'Daniela Maurer', 23),
(3470, 'Alex Salvadori Paludo', 42),
(3471, 'Vinicius Schvartz', 19),
(3472, 'Mariana Chies Zampieri', 18),
(3482, 'Eduardo Cainan Gavski', 19),
(3483, 'Rednaldo Ortiz Doneda', 20),
(3499, 'Mayelen Zampieron', 22)

INSERT INTO Disciplina VALUES
(1, 'Laboratório de Banco de Dados', 80),
(2,	'Laboratório de Engenharia de Software', 80),
(3,	'Programação Linear e Aplicações', 80),
(4, 'Redes de Computadores', 80),
(5, 'Segurança da Informação', 40),
(6,	'Teste de Software', 80),
(7, 'Custos e Tarifas Logísticas', 80),
(8, 'Gestão de Estoques', 40),
(9, 'Fundamentos de Marketing', 40),
(10,'Métodos Quantitativos de Gestão', 80),
(11,'Gestão do Tráfego Urbano', 80),
(12,'Sistemas de Movimentação e Transporte', 40)

INSERT INTO Titulacao VALUES
(1, 'Especialista'),
(2, 'Mestre'),
(3, 'Doutor')

INSERT INTO Professor VALUES
(1111, 'Leandro', 2),
(1112, 'Antonio', 2),
(1113, 'Alexandre', 3),
(1114, 'Wellington', 2),
(1115, 'Luciano', 1),
(1116, 'Edson', 2),
(1117, 'Ana', 2),
(1118, 'Alfredo', 1),
(1119, 'Celio', 2),
(1120, 'Dewar', 3),
(1121, 'Julio', 1)

INSERT INTO Curso VALUES
(1, 'ADS', 'Ciências da Computação'),
(2, 'Logística', 'Engenharia Civil')

INSERT INTO Aluno_Disciplina VALUES
(1, 3416),
(4, 3416),
(1, 3423),
(2, 3423),
(5, 3423),
(6, 3423),
(2, 3434),
(5, 3434),
(6, 3434),
(1, 3440),
(5, 3443),
(6, 3443),
(4, 3448),
(5, 3448),
(6, 3448),
(2, 3457),
(4, 3457), 
(5, 3457),
(6, 3457),
(1, 3459),
(6, 3459),
(7, 3465),
(11,3465),
(8, 3466),
(11,3466),
(8, 3467),
(12,3467),
(8, 3470),
(9, 3470),
(11,3470),
(12,3470),
(7, 3471),
(7, 3472),
(12,3472),
(9, 3482),
(11,3482),
(8, 3483),
(11,3483),
(12,3483),
(8, 3499)

INSERT INTO Disciplina_Professor VALUES
(1, 1111),
(2, 1112),
(3, 1113),
(4, 1114),
(5, 1115),
(6, 1116),
(7, 1117),
(8, 1118),
(9, 1117),
(10,1119),
(11,1120),
(12,1121)

INSERT INTO Curso_Disciplina VALUES
(1,1),
(1,2),
(1,3),
(1,4),
(1,5),
(1,6),
(2,7),
(2,8),
(2,9),
(2,10),
(2,11),
(2,12)


--Como fazer as listas de chamadas, com RA e nome por disciplina?
SELECT dc.Nome, al.Nome, al.RA
FROM Aluno al, Aluno_Disciplina ad, Disciplina dc
WHERE al.RA = ad.AlunoRA
	AND ad.DisciplinaCodigo = dc.Codigo
ORDER BY dc.Nome ASC

--Fazer uma pesquisa que liste o nome das disciplinas e o nome dos professores que ministram
SELECT dc.Nome, pf.Nome
FROM Disciplina dc, Professor pf, Disciplina_Professor dp
WHERE dp.DisciplinaCodigo = dc.Codigo
	AND pf.Registro = dp.ProfessorRegistro

--Fazer uma pesquisa que, dado o nome de uma disciplina, retorne o nome do curso
SELECT dc.Nome, cs.Nome
FROM Disciplina dc, curso cs, Curso_Disciplina cd
WHERE cd.CursoCodigo = cs.Codigo
	AND cd.DisciplinaCodigo = dc.Codigo

--Fazer uma pesquisa que, dado o nome de uma disciplina, retorne sua área
SELECT dc.Nome, cs.Area
FROM Disciplina dc, Curso cs, Curso_Disciplina cd
WHERE dc.Codigo = cd.DisciplinaCodigo
	AND cs.Codigo = cd.CursoCodigo

--Fazer uma pesquisa que, dado o nome de uma disciplina, retorne o titulo do professor que ministra
SELECT dc.Nome, tf.Titulo
FROM Disciplina dc, Disciplina_Professor dp, Professor pf, Titulacao tf
WHERE dc.Codigo = dp.DisciplinaCodigo
	AND pf.Registro = dp.ProfessorRegistro
	AND pf.tit = tf.Codigo

--Fazer uma pesquisa que retorne o nome da disciplina e quantos alunos estão matriculados em cada uma delas
SELECT dc.Nome, COUNT(ad.DisciplinaCodigo) AS qtdAlunos
FROM Disciplina dc, Aluno_Disciplina ad
WHERE dc.Codigo = ad.DisciplinaCodigo
GROUP BY dc.Nome

--Fazer uma pesquisa que, dado o nome de uma disciplina, retorne o nome do professor.
--So deve retornar de disciplinas que tenham, no minimo, 5 alunos matriculados
SELECT dc.Nome, pf.Nome
FROM Disciplina dc INNER JOIN Disciplina_Professor dp
ON dp.DisciplinaCodigo = dc.Codigo
INNER JOIN Professor pf
ON dp.ProfessorRegistro = pf.Registro
INNER JOIN Aluno_Disciplina ad
ON ad.DisciplinaCodigo = dc.Codigo
GROUP BY dc.Nome, pf.Nome
HAVING COUNT(ad.DisciplinaCodigo) >= 5

--Fazer uma pesquisa que retorne o nome do curso e a quantidade de professores cadastrados
--que ministram aula nele. A coluna deve se chamar quantidade
SELECT cs.Nome, COUNT(DISTINCT(dp.ProfessorRegistro)) AS Quantidade
FROM Curso cs INNER JOIN Curso_Disciplina cd
ON cd.CursoCodigo = cs.Codigo
INNER JOIN Disciplina_Professor dp
ON dp.DisciplinaCodigo = cd.DisciplinaCodigo
INNER JOIN Professor pf
ON pf.Registro = dp.ProfessorRegistro
GROUP BY cs.Nome
