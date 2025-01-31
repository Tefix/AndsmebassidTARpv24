--AB loomine 
Create database ZaitsevBaas;

use ZaitsevBaas;
CREATE TABLE opilane(
opilaneId int primary key identity (1,1),
eesnimi varchar(25) not null,
perenimi varchar(25) not null,
synniaeg date, 
stip bit,
aadress text,
keskmin_hinne decimal(2,1),
)
select * from opilane;
--andmete lisamine tabelisse
INSERT INTO opilane(eesnimi, perenimi, synniaeg, stip, keskmin_hinne)
VALUES(
'Roman',
'Zaitsev',
'2007-03-17',
1,
4.5),
(
'Roma1',
'Zaitsev',
'2007-03-17',
1,
4.5),
(
'Rom2',
'Zaitsev',
'2007-03-17',
1,
4.5),
(
'Rom3',
'Zaitsev',
'2007-03-17',
1,
4.5)

delete from opilane where opilaneId=2;
select * from opilane;

UPDATE opilane SET aadress=´Tallinn´
WHERE opilaneId= 3;

CREATE TABLE language
(
ID int not null primary key,
Code char(3) NOT NULL,
Language varchar(50) NOT NULL,
IsOfficial bit,
Percentage smallint
);
select * from Language

INSERT INTO Language(ID, code, Language)
VALUES (2, 'rus', 'vene'), (3, 'eng','inglise'),(4, 'DE', 'saksa')
Create table keeleValik
(
keelevalikId int primary key identity (1,1),
valikuNimetus varchar(10) not null,
opilaneId int, 
Foreign key (opilaneId) references opilane(opilaneId),
Language int,
Foreign key (language) references Language(ID)
)
select * from keelevalik;
select * from Language;
select * from opilane;

Insert into keeleValik(valikuNimetus,opilaneId, Language)
Values ('valik d', 5, 2)

delete from keeleValik where keeleValikI=6;

select opilane.eesnimi, Language.Language
from opilane, language, keelevalik
where opilane.opilaneId=keelevalik.opilaneID
and Language.ID=keelevalik.Language

select * 
from opilane, language, keelevalik
where opilane.opilaneId=keelevalik.opilaneID
and Language.ID=keelevalik.Language

create table oppimine1
(
oppimineId int primary key identity(1,1),
aine varchar(10),
aasta date,
opetaja varchar(20),
opilaneId int,
Foreign key (oppimineId) references opilane(opilaneId),
hinne int)

INSERT INTO oppimine (aine, aasta, opetaja, opilaneId, hinne)
VALUES ('eesti', '2025-01-01', 'Oleinik',1, 4);

select * from keelevalik;
select * from Language;
select * from opilane;
select * from oppimine1


---------------------------------------
vigane kood
