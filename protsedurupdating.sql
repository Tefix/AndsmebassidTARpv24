Create database ZaitsevBaaas;

use ZaitsevBaaas;
CREATE TABLE opilane(
opilaneId int primary key identity (1,1),
eesnimi varchar(25),
perenimi varchar(25),
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

-- changing opilane data
create procedure pilane
@eesnimi varchar(25),
@perenimi varchar(25),
@synniaeg date,
@stip bit,
@keskmine_hind decimal(2,1)
as 
begin
insert into opilane(eesnimi,perenimi,synniaeg,stip,keskmin_hinne)
values(@eesnimi,@perenimi,@synniaeg,@stip,@keskmine_hind);
select * from opilane
end;

select * from opilane
exec pilane @eesnimi= 'Roman', @perenimi= 'Zaitsev', @synniaeg='2007-03-18', @stip=0, @keskmine_hind= 3.2
select * from opilane

drop procedure pilane
drop table opilane


--deleting opilane
create procedure deleteopilane
@delete int
as
begin
delete from opilane where opilaneId=@delete;
select * from opilane;
end;

exec deleteopilane 5

--Create procedure opilane finding
create procedure taht
@taht Char(1)
as
begin
select * from opilane
where perenimi like @taht + '%';
-- % = kõik teised tähed
end;
--kutse
exec taht Z;
