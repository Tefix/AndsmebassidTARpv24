create database auto
use auto
create table Auto (
	Mark VARCHAR(50),
	RegNR VARCHAR(50),
	Aasta VARCHAR(50),
	RegPiirk INT
);
insert into Auto (Mark, RegNR, Aasta, RegPiirk) values ('Pontiac', '63114a', 1991, 2);
insert into Auto (Mark, RegNR, Aasta, RegPiirk) values ('Mazda', 'f43f39', 1999, 1);
insert into Auto (Mark, RegNR, Aasta, RegPiirk) values ('GMC', '75d760', 2011, 2);
insert into Auto (Mark, RegNR, Aasta, RegPiirk) values ('Nissan', '605aff', 2004, 1);
insert into Auto (Mark, RegNR, Aasta, RegPiirk) values ('Ford', '86b6b7', 2006, 1);
insert into Auto (Mark, RegNR, Aasta, RegPiirk) values ('Mitsubishi', '51fb4a', 1986, 2);
insert into Auto (Mark, RegNR, Aasta, RegPiirk) values ('Maserati', '3e59f3', 2007, 2);
insert into Auto (Mark, RegNR, Aasta, RegPiirk) values ('Dodge', '9eb2ca', 2009, 2);
insert into Auto (Mark, RegNR, Aasta, RegPiirk) values ('GMC', '76ff36', 1993, 2);
insert into Auto (Mark, RegNR, Aasta, RegPiirk) values ('Ford', '0b91e8', 1966, 2);
insert into Auto (Mark, RegNR, Aasta, RegPiirk) values ('Land Rover', '6c4365', 1995, 2);
insert into Auto (Mark, RegNR, Aasta, RegPiirk) values ('Toyota', '7753a9', 2012, 2);
insert into Auto (Mark, RegNR, Aasta, RegPiirk) values ('Lexus', '9d5cba', 2005, 2);
insert into Auto (Mark, RegNR, Aasta, RegPiirk) values ('Mazda', '875fcc', 2010, 1);
insert into Auto (Mark, RegNR, Aasta, RegPiirk) values ('BMW', 'fa2782', 2011, 2);
insert into Auto (Mark, RegNR, Aasta, RegPiirk) values ('Buick', '0bb39e', 1986, 1);
insert into Auto (Mark, RegNR, Aasta, RegPiirk) values ('Chevrolet', 'bdda18', 1972, 2);
insert into Auto (Mark, RegNR, Aasta, RegPiirk) values ('Chevrolet', '71be06', 2007, 2);
insert into Auto (Mark, RegNR, Aasta, RegPiirk) values ('Dodge', '268a2a', 1994, 1);
insert into Auto (Mark, RegNR, Aasta, RegPiirk) values ('Ford', 'fad58e', 1992, 2);

insert into Auto (Mark, RegNR, Aasta, RegPiirk) values ('Audi','123 ABC',2000,1);
insert into Auto (Mark, RegNR, Aasta, RegPiirk) values ('Ford','777 AAA',1988,2);
insert into Auto (Mark, RegNR, Aasta, RegPiirk) values ('Ford','FIN 772',2002,1);
insert into Auto (Mark, RegNR, Aasta, RegPiirk) values ('Nissan','111 CCC',2006,1);
insert into Auto (Mark, RegNR, Aasta, RegPiirk) values ('Toyota','128 HGF',2003,1);
insert into Auto (Mark, RegNR, Aasta, RegPiirk) values ('VAZ','544 CCH',1960,2);
--1
select Mark, RegNR, Aasta
from auto 
order by Aasta desc
--2
select distinct Mark
from auto

--3
select Aasta,Mark, RegNr 
from auto
where Aasta<1993
--4
select RegNr,Aasta
from Auto
where Aasta<1993 
order by Regnr desc;
--5
select min(aasta) as 'kõige varasem väljalaskeaasta'
from auto
--6
select RegNR from auto
update auto set RegNR='333 KKK' where RegNr='FIN 772'
--7
select * from auto
delete from auto 
where RegNR ='111 CCC'
--8

insert into Auto (Mark, RegNR, Aasta, RegPiirk) values ('Nissan','555 NNN',2007,2);

--SELECT 
SELECT Mark 
from aUTO
where Mark like 'A%'
--
SELECT Mark, Aasta
from auto
where Aasta>1990 and Aasta<2015  and Mark like'%A%'
--
select max(aasta) as 'kõige suurem väljalaskeaasta'
from auto
