create database tf
use tf

CREATE TABLE Tellimus (			
    TellimuseID int  NOT NULL,			
    aadres_aadresID int  NOT NULL,			
    Tellimuse_kuupaev date  NOT NULL,			
    komm_kommId int  NOT NULL,			
    Kogus int  NOT NULL,			
    pakkija_PakkijaID int  NOT NULL,			
    CONSTRAINT Tellimus_pk PRIMARY KEY  (TellimuseID)			
);			
			
#NAME?			
CREATE TABLE aadres (			
    aadresID int  NOT NULL,			
    Kliendi_aadress varchar(50)  NOT NULL,			
    klient_KlientID int  NOT NULL,			
    CONSTRAINT aadres_pk PRIMARY KEY  (aadresID)			
);			
			
#NAME?			
CREATE TABLE klient (			
    KlientID int  NOT NULL,			
    Klient varchar(50)  NOT NULL,			
    CONSTRAINT klient_pk PRIMARY KEY  (KlientID)			
);			
			
#NAME?			
CREATE TABLE komm (			
    kommId int  NOT NULL,			
    Komminimetus varchar(50)  NOT NULL,			
    hind money  NOT NULL,			
    kommityyp_kommityypID int  NOT NULL,			
    Kehtivusaeg int  NOT NULL,			
    CONSTRAINT komm_pk PRIMARY KEY  (kommId)			
);			
			
#NAME?			
CREATE TABLE kommityyp (			
    kommityypID int  NOT NULL,			
    Kommityyp varchar(50)  NOT NULL,			
    CONSTRAINT kommityyp_pk PRIMARY KEY  (kommityypID)			
);			
			
#NAME?			
CREATE TABLE pakkija (			
    PakkijaID int  NOT NULL,			
    Pakkija int  NOT NULL,			
    CONSTRAINT pakkija_pk PRIMARY KEY  (PakkijaID)			
);			
			
#NAME?			
#NAME?			
ALTER TABLE Tellimus ADD CONSTRAINT Tellimus_aadres			
    FOREIGN KEY (aadres_aadresID)			
    REFERENCES aadres (aadresID);			
			
#NAME?			
ALTER TABLE Tellimus ADD CONSTRAINT Tellimus_komm			
    FOREIGN KEY (komm_kommId)			
    REFERENCES komm (kommId);			
			
#NAME?			
ALTER TABLE Tellimus ADD CONSTRAINT Tellimus_pakkija			
    FOREIGN KEY (pakkija_PakkijaID)			
    REFERENCES pakkija (PakkijaID);			
			
#NAME?			
ALTER TABLE aadres ADD CONSTRAINT aadres_klient			
    FOREIGN KEY (klient_KlientID)			
    REFERENCES klient (KlientID);			
			
#NAME?			
ALTER TABLE komm ADD CONSTRAINT komm_kommityyp			
    FOREIGN KEY (kommityyp_kommityypID)			
    REFERENCES kommityyp (kommityypID);			
			
#NAME?			
select * from Tellimus			
		
Select t.Tellimuse_kuupaev, t.Kogus, k.Komminimetus, a.Kliendi_aadress, p.pakkija 						
from Tellimus t						
inner join komm k on k.kommId=t.komm_kommId						
						
inner join aadres a on a.aadresID=t.aadres_aadresID						
inner join pakkija p on p.PakkijaID=t.pakkija_PakkijaID						

INSERT INTO klient (KlientID, Klient)						
VALUES						
    (1, 'Maxima'),						
    (2, 'Selver'),						
    (3, 'Rimi'),						
    (4, 'Prisma');						
						
insert into aadres(aadresID,Kliendi_aadress,klient_KlientID)						
VALUES (1, 'Mustakivi 1',1),						
(2, 'Kivimurru 32',2),						
(3, 'Toome 3',1), 						
(4, 'Prisli 45',4), 						
(5, 'Mustakivi 5',4), 						
(6, 'Mustamäe 16',3)						
						
insert into kommityyp(kommityypID,Kommityyp)						
values 						
(1, 'chocolate'),						
(2, 'Karamel'),						
(3, 'Zefir'),						
(4, 'Iris');						
						
INSERT INTO komm (kommId, Komminimetus, Hind, kommityyp_kommityypID, Kehtivusaeg)						
VALUES						
    (1, 'doroznik', 79.00, 1, 1),						
    (2, 'barbaris', 36.00, 2, 2),						
    (3, 'Kometa', 83.00, 1, 1),						
    (4, 'Vanilla', 40.00, 4, 5),						
    (5, 'kis-kis', 70.00, 3, 3),						
    (6, 'Classic', 72.00, 4, 5);						
						
insert into pakkija(PakkijaID,Pakkija)						
values(1,'Anna Sidorova'),						
(2,'Marina Ivanova'),						
(3, 'Daria Cvetkova');						
select * from komm						
						
						
INSERT INTO Tellimus 						
VALUES						
(1, 1, '2020-02-12', 1, 3, 1),						
(2, 2, '2020-02-13', 2, 13, 2),						
(3, 2, '2020-02-14', 3, 7, 3),						
(4, 1, '2020-02-15', 3, 10, 2),						
(5, 4, '2020-02-12', 2, 5, 3),						
(6, 4, '2020-02-13', 2, 3, 3),						
(7, 5, '2020-02-14', 1, 6, 1),						
(8, 5, '2020-02-15', 4, 4, 3),						
(9, 1, '2020-02-12', 6, 10, 2),						
(10, 3, '2020-02-13', 6, 15, 2);		

CREATE PROCEDURE LisaTellimus
    @TellimuseID INT,
    @aadres_aadresID INT,
    @Tellimuse_kuupaev DATE,
    @komm_kommId INT,
    @Kogus INT,
    @pakkija_PakkijaID INT
AS
BEGIN
    INSERT INTO Tellimus 
    VALUES (@TellimuseID, @aadres_aadresID, @Tellimuse_kuupaev, @komm_kommId, @Kogus, @pakkija_PakkijaID);
	select * from Tellimus
END;
drop procedure LisaTellimus
EXEC LisaTellimus 11, 2, '2020-02-16', 5, 8, 1;

CREATE PROCEDURE otsipoodtellimus
    @KlientNimi VARCHAR(50)
AS
BEGIN
    SELECT 
        t.TellimuseID,
        t.Tellimuse_kuupaev,
        k.Komminimetus,
        t.Kogus,
        a.Kliendi_aadress
    FROM Tellimus t
    JOIN aadres a ON t.aadres_aadresID = a.aadresID
    JOIN klient kl ON a.klient_KlientID = kl.KlientID
    JOIN komm k ON t.komm_kommId = k.kommId
    WHERE kl.Klient = @KlientNimi;
END;

EXEC otsipoodtellimus 'Maxima';


CREATE LOGIN tellimus_user WITH PASSWORD = 'StrongP@ssword123';
CREATE USER tellimus_user FOR LOGIN tellimus_user;

GRANT SELECT, INSERT ON Tellimus TO tellimus_user;
GRANT SELECT ON komm TO tellimus_user;

create table 
