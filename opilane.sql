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
