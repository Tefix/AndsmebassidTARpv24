insert into  loom(loom, vanus, zookoht)
values ('koerr', 15, 111)
select * from loom





Create database ZooDB
use ZooDB

create table loom(
id int primary key identity(1,1), 
loom varchar (10),
vanus int,
zookoht int)

create table logi(
    id INT IDENTITY(1,1) PRIMARY KEY,
    kasutaja VARCHAR(100),
    tegevus VARCHAR(50),
    loom VARCHAR(10),
 )
 drop table logi

INSERT INTO loom (loom, vanus, zookoht) VALUES
('Kass', 3, 101),
('Koer', 5, 102),
('Lind', 2, 103);

CREATE TRIGGER loomLisamine
ON loom
FOR INSERT
AS
INSERT INTO logi (kasutaja, tegevus, loom)
SELECT
    SYSTEM_USER,
    'loom on lisatud',
    CONCAT('Loom: ', inserted.loom, ', vanus: ', inserted.vanus, ', zookoht: ', inserted.zookoht)
FROM inserted;

insert into loom(loom, vanus, zookoht) VALUES
('Kala', 8, 110)

CREATE TRIGGER loomKustutamine
ON loom
FOR DELETE
AS
INSERT INTO logi (kasutaja, tegevus, loom)
SELECT
    SYSTEM_USER,
    'loom on kustutatud',
    CONCAT('Loom: ', deleted.loom, ', vanus: ', deleted.vanus, ', zookoht: ', deleted.zookoht)
FROM deleted;

select * from loom
delete loom where ID=1

grant delete, update, select, insert on loom to klienditenidaja

insert into  loom(loom, vanus, zookoht)
values ('koerr', 15, 111)
select * from loom
select * from logi
