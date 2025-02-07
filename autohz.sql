create database autod

create table autod(
autodId int primary key identity(1,1),
AutoMark varchar(25) UNIQUE,
AuroNumber varchar(6),
autohind int);

select * from autod


create procedure AutoAuto
@avtomark varchar(25),
@avtonumber varchar(25),
@avtohind int

as
begin
insert into autod(AutoMark,AuroNumber,autohind)
values(@avtomark,@avtonumber,@avtohind);
select * from autod
end;
drop procedure AutoAuto
-----Lisada autosid ja hindu,
exec AutoAuto @avtomark= 'citroen', @avtonumber= '564KIE', @avtohind= 483120


--- otsing numbrimärgi järgi

create procedure find
@number Char(1)
as
begin
select * from autod
where autodId like @number + '%';
end;

exec find 1;


create procedure deleteauto
@delete int
as
begin
delete from autod where autodId=@delete;
select * from autod;
end;

exec deleteauto 4
