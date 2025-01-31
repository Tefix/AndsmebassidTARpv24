create database epoodZaitsev;
use epoodZaitsev;

create table Category (
idCategory int primary key identity(1,1),
CategoryName varchar(25) UNIQUE 
)
select * from Category
insert into Category(CategoryName)
values('jook'),('sook'),('külm'),('soe');

--Tabeli strukruri muutmine--uue veergu lisamine

ALTER table Category add test int;

--Tabeli strukruri muutmine--veergu lisamine

ALTER table Category drop column test;

create table Product(
idProduct int primary key identity(1,1),
ProductName varchar(25),
idCategory int
foreign key (idCategory) references Category(idCategory),
Price int
)
select * from Product
select * from Category
insert into Product(ProductName, idCategory,Price)
values('pelmeni', 3, 2),('kurica', 3, 2), ('kartoshka', 4, 2),('haram', 4, 2);


create table Sale(
idSale int primary key identity (1,1),
idProduct int,
foreign key (idProduct) references Product(idProduct),
idCustomer int,
Count_ int,
DateOfSale date
);
insert into Sale(idProduct, idCustomer, Count_,DateOfSale)
values (1, 2, 744, '2007-03-17'),(1, 3, 174, '2007-03-17'),(1, 4, 174, '2007-03-17'),(1, 5, 74, '2007-03-17');



create table customer(
idCustomer int primary key identity (1,1),
Name varchar(25),
contact text)

alter table Sale add foreign key(idCustomer)
references Customer(idCustomer)

insert into customer(Name, contact)
values ('melon', '111234'),('marek', '12234'),('ilja', '12334');
select * from customer
select * from Product
select * from Category
select * from Sale




delete from Sale
