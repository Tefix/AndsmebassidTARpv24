use RomanZaitsevKool

CREATE TABLE Isik (
    id INT PRIMARY KEY identity(1,1),
    eesnimi VARCHAR(50),
    perenimi VARCHAR(50),
	sugu char (1),
    synniaeg DATE, 
    address VARCHAR(100),
    email VARCHAR(50)
)

create table Õppeaine(
õppeaine_id int primary key identity(1,1),
nimi varchar(100),
vastutav_õpetaja int FOREIGN KEY REFERENCES Isik(id),
aine_kestus VARCHAR(50)
);

CREATE TABLE Oppimine (
    id INT IDENTITY(1,1) PRIMARY KEY,
    isiku_id INT,
    oppeaine_id INT,
    hinne INT,
    FOREIGN KEY (isiku_id) REFERENCES Isik(id),
    FOREIGN KEY (oppeaine_id) REFERENCES Õppeaine(õppeaine_id)
);

INSERT INTO Isik (eesnimi, perenimi, sugu, synniaeg, address, email)
VALUES 
('Mari', 'Tamm', 'N', '1985-03-12', 'Tallinn, Narva mnt 10', 'mari.tamm@example.com'),
('Jaan', 'Kask', 'M', '1979-11-05', 'Tartu, Riia 22', 'jaan.kask@example.com'),
('Liis', 'Pärn', 'N', '2002-06-25', 'Tallinn, Pärnu mnt 45', 'liis.parn@example.com'),
('Karl', 'Lepik', 'M', '2001-09-17', 'Viljandi, Lossi 3', 'karl.lepik@example.com');

INSERT INTO Õppeaine (nimi, vastutav_õpetaja, aine_kestus)
VALUES
('Matemaatika', 1, '1 semester'),
('Programmeerimine', 2, '1 semester'),
('Andmebaasid', 2, '2 kuud');

INSERT INTO Oppimine (isiku_id, oppeaine_id, hinne)
VALUES
(3, 3, 5),  -- Liis учится Математике
(3, 2, 4),  -- Liis учится Программированию
(4, 1, 3),  -- Karl учится Математике
(4, 3, 4);  -- Karl учится БазеДанных

CREATE TABLE logi (
    id INT IDENTITY(1,1) PRIMARY KEY,
    kasutaja VARCHAR(50),
    kuupaev DATETIME DEFAULT GETDATE(),
    sisestatudAndmed VARCHAR(500)
);

select * from Isik
select * from Õppeaine
select * from Oppimine

CREATE TRIGGER trg_Insert_Oppimine
ON Oppimine
AFTER INSERT
AS
BEGIN
    DECLARE @kasutaja NVARCHAR(50) = SUSER_NAME();
    DECLARE @kuupaev DATETIME = GETDATE();
    DECLARE @andmed NVARCHAR(500);

    SELECT @andmed = 
        'Lisatud kirje: ID=' + 
        CONVERT(NVARCHAR(10), i.id) + 
        ', isiku_id=' + CONVERT(NVARCHAR(10), i.isiku_id) +
        ', oppeaine_id=' + CONVERT(NVARCHAR(10), i.oppeaine_id) +
        ', hinne=' + CONVERT(NVARCHAR(10), i.hinne)
    FROM inserted i;

    INSERT INTO logi (kasutaja, kuupaev, sisestatudAndmed)
    VALUES (@kasutaja, @kuupaev, @andmed);
END;

CREATE TRIGGER trg_Update_Oppimine
ON Oppimine
AFTER UPDATE
AS
BEGIN
    DECLARE @kasutaja NVARCHAR(50) = SUSER_NAME();
    DECLARE @kuupaev DATETIME = GETDATE();
    DECLARE @andmed NVARCHAR(500);

    SELECT @andmed = 
        'Uuendatud kirje: ID=' + 
        CONVERT(NVARCHAR(10), i.id) + 
        ', uus hinne=' + CONVERT(NVARCHAR(10), i.hinne)
    FROM inserted i;

    INSERT INTO logi (kasutaja, kuupaev, sisestatudAndmed)
    VALUES (@kasutaja, @kuupaev, @andmed);
END;



INSERT INTO Oppimine (isiku_id, oppeaine_id, hinne)
VALUES (3, 2, 5);

UPDATE Oppimine SET hinne = 4 WHERE id = 1;

SELECT * FROM logi;


--10

BEGIN TRANSACTION;
INSERT INTO Oppimine (isiku_id, oppeaine_id, hinne)
VALUES (4, 3, 3);
SAVE TRANSACTION sisestatud;
UPDATE Oppimine SET hinne = 5 WHERE id = 2;
COMMIT TRANSACTION;

SELECT * FROM Oppimine;
SELECT * FROM logi;

ROLLBACK TRANSACTION InsertedData;

--12
CREATE PROCEDURE KeskmineHinne
AS
BEGIN
    SELECT 
        o.nimi AS Oppeaine,
        AVG(op.hinne) AS KeskmineHinne
    FROM Oppimine op
    JOIN Õppeaine o ON op.oppeaine_id = o.õppeaine_id
    GROUP BY o.nimi;
END;

EXEC KeskmineHinne;


delete from Oppimine where id= 10
