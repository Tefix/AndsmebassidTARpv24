create database kordamine
use kordamine

create table toodekategooria(
toodekategooriaId int not null primary key identity (1,1),
toodekategooria varchar(100) unique,
kirjeldus text);
 
create table toode(
toodeId int not null primary key identity (1,1),
toodenimetus varchar(100) unique,
hind decimal(5,2),
toodekategooriaId int,
foreign key (toodekategooriaId) references toodekategooria(toodekategooriaId)
);

--2 ülesanne. 1. harjutus Vaated (VIEW)
--Loo vaade, mis kuvab ainult toodete nime ja hinna.

select * from toode 
select * from toodekategooria

insert into toode(toodenimetus,hind,toodekategooriaId)
values ('sibul',2,1);



insert into toodekategooria(toodekategooria,kirjeldus)
values ('joogid','-');


select toodenimetus,hind from toode
--Loo vaade, mis kuvab ainult toodete nime ja hinna.
create view toode_nimijahind as 
 select toodenimetus,hind from toode
 --kuuvame vaade
select * from toode_nimijahind

--2. Loo vaade, mis näitab kõiki tooteid koos kategooria nimega.

create view tooded_kategooria
as 
select t.toodenimetus, t.hind, tk.toodekategooria from toode t 
inner join toodekategooria tk on tk.toodekategooriaId = t.toodekategooriaId

select * from tooded_kategooria;

--3.Loo vaade, mis kuvab ainult aktiivseid (nt saadaval olevaid) tooteid.

Alter table toode 
add aktiivne bit
update toode set aktiivne = 1
select * from toode 
update toode set aktiivne = 0
where toodeId = 2

Create view saadav_toode
as 
select * from toode
where aktiivne = 1

select * from saadav_toode;

--4.Loo vaade, mis koondab info: kategooria nimi, toodete arv, minimaalne ja maksimaalne hind.
create view KatefooriaInfo as
	select toodekategooria,
			COUNT(*) as 'toodete arv',
			cast(min(t.hind) as decimal (5,1)) as 'min hind',
			cast (max(t.hind) as decimal (5,1)) as 'max hind'
			from toodekategooria tk
			inner join toode t on t.toodekategooriaId= tk.toodekategooriaId group by tk.toodekategooria;

select * from KatefooriaInfo
--5. Loo vaade, mis arvutab toode käibemaksu (24%) ja iga toode hind käibemaksuga5
Create view toode_kaibemaksuga as
	select toodenimetus, hind,
	CAST ((hind * 0.24) as decimal (5,2)) as 'Käibemaks',
	CAST ((hind * 1.24) as decimal (5,2)) as 'Hind_käibemaksuga'
from toode

--Uuendamine 
update toode set aktiive = 0
where toode.toodekategooriaId=3

--3 ülesanne procedurid
--1.Loo protseduur, mis lisab uue toote (sisendparameetrid: tootenimi, hind, kategooriaID).

create procedure toodesse_panna
@toodeNimetus varchar(200),
@hind int,
@toodeKategooriaID int
as
begin
insert into toode (toodenimetus,hind, toodekategooriaId)
values(@toodeNimetus,@hind,@toodeKategooriaID);
select * from toode
end

exec toodesse_panna 'popsi', 1, 2;

--2 Loo protseduur, mis uuendab toote hinda vastavalt tooteID-le.

create procedure update_hind
@toodeId int,
@hind decimal(5,2)
as
begin
select * from toode;
update toode set hind=@hind
where toodeId=@toodeId;
select * from toode;
end
exec update_hind @hind=3.5,@toodeId=4

--3 Loo protseduur, mis kustutab toote ID järgi.

create procedure KustutaToode 
@toodeID int
as
begin
delete from toode
where toodeID = @toodeID;
select * from toode 
end;

exec KustutaToode @toodeID = 2

--4 Loo protseduur, mis tagastab kõik tooted valitud kategooriaID järgi.
create procedure LeiaToodeKategooriaJargi
@kategooria varchar(30)
as
begin
select toodekategooria, toodeNimetus, hind
from toodekategooria tk
inner join toode t  on t.toodekategooriaId=tk.toodekategooriaId
where tk.toodekategooria = @kategooria
end;

exec LeiaToodeKategooriaJargi @kategooria = 2;

--5 Loo protseduur, mis tõstab kõigi toodete hindu kindlas kategoorias kindla protsendi võrra.

create procedure Protsenti
	@kategooriaId int
as
begin
	update toode 
	set hind = hind * (1+ 15/ 100)
	where toodekategooriaId = @kategooriaId
	select * from toode;
end;

--6 Loo protseduur, mis kuvab kõige kallima toote kogu andmebaasis.


create procedure KallimHind
as 
begin
	select top 1 *
	from toode 
	order by hind desc
end

exec KallimHind

GRANT SELECT, INSERT, UPDATE, DELETE ON dbo.toode TO tootehaldur;

GRANT SELECT, INSERT, UPDATE ON dbo.toodekategooria TO kataloogihaldur;

GRANT SELECT ON dbo.toode TO vaataja;
GRANT SELECT ON dbo.toodekategooria TO vaataja;

SELECT 
    CONCAT(table_schema, '.', table_name) AS scope,
    grantee,
    privilege_type
FROM information_schema.table_privileges
WHERE grantee IN ('tootehaldur', 'kataloogihaldur', 'vaataja');
