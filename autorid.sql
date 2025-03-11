create database Autorid
use Autorid;

create table Autoridd(
Autori_Id  int primary key identity (1,1),
Eesnimi varchar(20),
Perekonnanimi varchar(20),
Sünniaasta date,
Sünnikoht Varchar(20),
Rahvus varchar(20),
Elukoht varchar(20),
CV int,
portree varchar(20),
kodelehelülg varchar(200))

insert into Autoridd (Eesnimi, Perekonnanimi, Sünniaasta, Sünnikoht, Rahvus, Elukoht, CV, portree, kodelehelülg)
values
('Jaan', 'Tamm', '1985-03-10', 'Tallinn', 'Eesti', 'Tallinn', 1, 'jaantamm.jpg', 'www.jaantamm.ee'),
('Mari', 'Kask', '1992-06-15', 'Tartu', 'Eesti', 'Tartu', 0, 'marikask.jpg', 'www.marikask.ee'),
('Tiit', 'Saar', '1980-11-20', 'Narva', 'Eesti', 'Tallinn', 1, 'tiitsaar.jpg', 'www.tiitsaar.ee'),
('Kati', 'Oja', '1995-02-28', 'Pärnu', 'Eesti', 'Pärnu', 0, 'katioja.jpg', 'www.katioja.ee');

select * from Autoridd

create table Teose_liik(
Liigi_id int primary key identity(1,1),
Selgitav_text varchar(20))

insert into Teose_liik (Selgitav_text)
values
('Raamat'),
('Artikkel'),
('Essee'),
('Pilt'),
('Video');

create table teosed(
Teose_ID int primary key identity(1,1),
Pealkiri varchar(20),
Ilmumiskoht varchar(20),
Ilmumisaasta date,
LK int,
Liigi_Id int foreign key references Teose_liik(Liigi_id),
kirjustus varchar(20))

insert into teosed (Pealkiri, Ilmumiskoht, Ilmumisaasta, LK, Liigi_Id, kirjustus)
values
('Eesti ajalugu', 'Tallinn', '2020-05-15', 1, 1, 'Jaan Tamm'),
('Tehnoloogia tulevik', 'Tartu', '2021-03-22', 2, 2, 'Mari Kask'),
('Mõtisklused', 'Narva', '2019-11-10', 3, 3, 'Tiit Saar'),
('Kunst ja ühiskond', 'Pärnu', '2022-07-18', 4, 4, 'Kati Oja');

create table Autorlus(
Teose_id int foreign key references teosed (Teose_id),
Autori_id int foreign key references autoridd (autori_id))

create table kasitamine(
Siisekande_nr int primary key identity(1,1),
Teose_id int foreign key references teosed (Teose_id),
kasutusviisi_kirjeldus varchar(150))

insert into kasitamine (Teose_id, kasutusviisi_kirjeldus)
values
(1, 'Kasutatakse õpikuna koolides'),
(2, 'Kasutatakse teadusartiklite koostamiseks'),
(3, 'Kasutatakse kunstinäitusel eksponaadina'),
(4, 'Kasutatakse videokunstina galerii näitusel');



create procedure auto_autorid
    @Eesnimi varchar(20),
    @Perekonnanimi varchar(20),
    @Sünniaasta date,
    @Sünnikoht varchar(20),
    @Rahvus varchar(20),
    @Elukoht varchar(20),
    @CV int,
    @portree varchar(20),
    @kodelehelülg varchar(200)
as
begin
    insert into Autoridd (Eesnimi, Perekonnanimi, Sünniaasta, Sünnikoht, Rahvus, Elukoht, CV, portree, kodelehelülg)
    values (@Eesnimi, @Perekonnanimi, @Sünniaasta, @Sünnikoht, @Rahvus, @Elukoht, @CV, @portree, @kodelehelülg);
end;

exec auto_autorid @Eesnimi='Jaan', @Perekonnanimi='Tamm', @Sünniaasta='1985-03-10', @Sünnikoht='Tallinn', @Rahvus='Eesti', @Elukoht='Tallinn', @CV=1, @portree='jaantamm.jpg', @kodelehelülg='www.jaantamm.ee'

create procedure add_teos
    @Pealkiri varchar(20),
    @Ilmumiskoht varchar(20),
    @Ilmumisaasta date,
    @LK int,
    @Liigi_Id int,
    @kirjustus varchar(20)
as
begin
    insert into teosed (Pealkiri, Ilmumiskoht, Ilmumisaasta, LK, Liigi_Id, kirjustus)
    values (@Pealkiri, @Ilmumiskoht, @Ilmumisaasta, @LK, @Liigi_Id, @kirjustus);
end;


exec add_teos 
    @Pealkiri = 'Eesti ajalugu', 
    @Ilmumiskoht = 'Tallinn', 
    @Ilmumisaasta = '2020-05-15', 
    @LK = 1, 
    @Liigi_Id = 1, 
    @kirjustus = 'Jaan Tamm';


	create procedure add_kasitamine
    @Teose_id int,
    @kasutusviisi_kirjeldus varchar(150)
as
begin
    insert into kasitamine (Teose_id, kasutusviisi_kirjeldus)
    values (@Teose_id, @kasutusviisi_kirjeldus);
end;

exec add_kasitamine 
    @Teose_id = 1, 
    @kasutusviisi_kirjeldus = 'Kasutatakse õpikuna koolides';

	SELECT *
FROM Autoridd
WHERE Sünnikoht='Tallinn'

SELECT Teosed.Pealkiri
FROM Teosed, Autorid, Autorlus
WHERE Teosed.Teose_ID)=[Autorlus].[Teose_ID]) AND ((Autorid.Autori_ID)=[Autorlus].[Autori_ID]) AND ((Autorid.Eesnimi)="Kari") AND ((Autorid.Perekonnanimi)="Tamm"));

SELECT * FROM Autoridd WHERE Autori_Id = 1;
