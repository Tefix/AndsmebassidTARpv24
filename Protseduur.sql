-- sql salvestatud protseduur - ?
--SQL salvestatud protseduur on SQL-käskude kogum, mis salvestatakse andmebaasi ja täidetakse päringu järgi
create database protseduurZaitsev;
use protseduurZaitsev;
create table linn(
linnId int primary key identity (1,1),
linnNimi varchar(30),
rahvaArv int);

select * from linn;
insert into linn(linnNimi, rahvaArv)
values ('Tallinn', 400000),('Parnu',30000),('Tartu', 250000)
--Protseduuri loomine
--protseduur, mis lisab uus linn ja kohe naitab tabelis

create procedure lisalinn
@lnimi varchar(30),
@rArv int
as
begin

insert into linn(linnNimi, rahvaArv)
values (@lnimi,@rArv);
select * from linn;

end;

--protseuuri kutse
exec lisalinn @lnimi='Tartu', @rArv=1256
--lihtsam
exec lisalinn 'Tartu265685', 1233454
--kirje kustutamine
delete from linn where linnId=3;

--protseduur, mis kustuab linn id järgi
create procedure kustutaLinn
@deleteId int
as
begin
delete from linn where linnId=@deleteId;
select * from linn;
end;

--kutse
exec kustutaLinn 5

--
Create procedure linnaOtsing

@taht Char(1)
as
begin
select * from linn 
where linnNimi like @taht + '%';
-- % = kõik teised tähed
end;
--kutse
exec linnaOtsing T;

------------------------------------------------------------------
kasutame xampp / localhost 
