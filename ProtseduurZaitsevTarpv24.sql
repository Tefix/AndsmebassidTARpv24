create database ProtseduurZaitsevTarpv24
create table linn(
linnId int primary key identity (1,1),
linnNimi varchar(30),
rahvaArv int);

select * from linn;
insert into linn(linnNimi, rahvaArv)
values ('Tallinn', 400000)

create procedure lisalinn
@lnimi varchar(30),
@rArv int
as
begin

insert into linn(linnNimi, rahvaArv)
values (@lnimi,@rArv);
select * from linn;

end;

exec lisalinn @lnimi='Tartu1', @rArv=12562

alter table linn add test int; 

create procedure veerulisakustuta 
@valik varchar (20), 
@veerunimi varchar(20),
@typp varchar(20) =null

as
begin
Declare @sqltegvus as varchar(max)
set @sqltegvus=case
when @valik='add' then concat('alter table linn add ', @veerunimi, ' ',  @typp)
when @valik='drop' then concat('alter table linn drop column ', @veerunimi)
end;
print @sqltegvus;
begin
exec (@sqltegvus);
end
end;

exec veerulisakustuta @valik= 'add', @veerunimi='test3', @typp='int';
select * from linn;
exec veerulisakustuta @valik= 'drop', @veerunimi='test';

create procedure veerulisakustutTabelis 
@valik varchar (20),
@tabelinimi varchar(20),
@veerunimi varchar(20),
@typp varchar(20) =null

as
begin
Declare @sqltegvus as varchar(max)
set @sqltegvus=case
when @valik='add' then concat('alter table ', @tabelinimi, ' add  ', @veerunimi, ' ',  @typp)
when @valik='drop' then concat('alter table ', @tabelinimi, 'drop column ', @veerunimi)
end;
print @sqltegvus;
begin
exec (@sqltegvus);
end
end;
drop procedure veerulisakustutTabelis 

exec veerulisakustutTabelis @valik= 'add', @tabelinimi= 'linn', @veerunimi='test3', @typp='int';
select * from linn;
exec veerulisakustutTabelis @valik= 'drop', @veerunimi='test';


create procedure rahvaHinnang
@piir int


as
begin 
select linnNimi, rahvaArv, IIF(rahvaArv<@piir, 'vaike linn', 'suur linn') as Hinnang
from linn;

end;
drop procedure rahvaHinnang
exec rahvaHinnang 2000

create procedure kokkuRahvaarv

as 
begin
select sum(rahvaArv) as 'kokku rahvaArv', avg(rahvaArv) as 'keskmine rahvaArv', min(rahvaArv) as 'min rahvaArv', max(rahvaArv) as 'max rahvaArv'
end;



