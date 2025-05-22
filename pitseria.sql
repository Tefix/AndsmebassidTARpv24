create database pitseria
use pitseria

CREATE TABLE kliendid (
    kliendi_ID int  NOT NULL,
    nimi varchar(30)  NOT NULL,
    telefon varchar(30)  NOT NULL,
    CONSTRAINT kliendid_pk PRIMARY KEY  (kliendi_ID)
);

-- Table: kohaletoimetamine
CREATE TABLE kohaletoimetamine (
    kohaletoimetamine_ID int  NOT NULL,
    aadress varchar(35)  NOT NULL,
    kohaletoimetamise_tyyp varchar(20)  NOT NULL,
    tootajad_tootaja_ID int  NOT NULL,
    kliendid_kliendi_ID int  NOT NULL,
    CONSTRAINT kohaletoimetamine_pk PRIMARY KEY  (kohaletoimetamine_ID)
);

-- Table: makse
CREATE TABLE makse (
    makse_ID int  NOT NULL,
    nakseviis varchar(30)  NOT NULL,
    makse_aeg int  NOT NULL,
    summa varchar(10)  NOT NULL,
    tellimused_tellimus_ID int  NOT NULL,
    CONSTRAINT makse_pk PRIMARY KEY  (makse_ID)
);

-- Table: pizzamenu
CREATE TABLE pizzamenu (
    pizzaID int  NOT NULL,
    nimi varchar(30)  NOT NULL,
    hind varchar(10)  NOT NULL,
    CONSTRAINT pizzamenu_pk PRIMARY KEY  (pizzaID)
);

-- Table: tellimused
CREATE TABLE tellimused (
    tellimus_ID int  NOT NULL,
    tellimus_aeg datetime  NOT NULL,
    CONSTRAINT tellimused_pk PRIMARY KEY  (tellimus_ID)
);
ALTER TABLE kohaletoimetamine
ADD CONSTRAINT fk_kohaletoimetamine_tellimused
FOREIGN KEY (tellimus_ID)
REFERENCES tellimused (tellimus_ID);

-- Table: tellimusse_rida
CREATE TABLE tellimusse_rida (
    tellimuserida_ID int  NOT NULL,
    kogus int  NOT NULL,
    pizzamenu_pizzaID int  NOT NULL,
    tellimused_tellimus_ID int  NOT NULL,
    CONSTRAINT tellimusse_rida_pk PRIMARY KEY  (tellimuserida_ID)
);

-- Table: tootajad
CREATE TABLE tootajad (
    tootaja_ID int  NOT NULL,
    tootajanimi varchar(30)  NOT NULL,
    roll varchar(30)  NOT NULL,
    CONSTRAINT tootajad_pk PRIMARY KEY  (tootaja_ID)
);

-- foreign keys
-- Reference: kohaletoimetamine_kliendid (table: kohaletoimetamine)
ALTER TABLE kohaletoimetamine ADD CONSTRAINT kohaletoimetamine_kliendid
    FOREIGN KEY (kliendid_kliendi_ID)
    REFERENCES kliendid (kliendi_ID);

-- Reference: kohaletoimetamine_tootajad (table: kohaletoimetamine)
ALTER TABLE kohaletoimetamine ADD CONSTRAINT kohaletoimetamine_tootajad
    FOREIGN KEY (tootajad_tootaja_ID)
    REFERENCES tootajad (tootaja_ID);



-- Reference: makse_tellimused (table: makse)
ALTER TABLE makse ADD CONSTRAINT makse_tellimused
    FOREIGN KEY (tellimused_tellimus_ID)
    REFERENCES tellimused (tellimus_ID);

-- Reference: tellimusse_rida_pizzamenu (table: tellimusse_rida)
ALTER TABLE tellimusse_rida ADD CONSTRAINT tellimusse_rida_pizzamenu
    FOREIGN KEY (pizzamenu_pizzaID)
    REFERENCES pizzamenu (pizzaID);

-- Reference: tellimusse_rida_tellimused (table: tellimusse_rida)
ALTER TABLE tellimusse_rida ADD CONSTRAINT tellimusse_rida_tellimused
    FOREIGN KEY (tellimused_tellimus_ID)
    REFERENCES tellimused (tellimus_ID);

-- End of file.


-- Insert data into kliendid (customers)
INSERT INTO kliendid (kliendi_ID, nimi, telefon) VALUES
(1, 'John Doe', '555-1234'),
(2, 'Jane Smith', '555-5678'),
(3, 'Alice Johnson', '555-8765'),
(4, 'Bob Brown', '555-4321');

-- Insert data into tootajad (employees)
INSERT INTO tootajad (tootaja_ID, tootajanimi, roll) VALUES
(1, 'Emily White', 'Waiter'),
(2, 'Jack Green', 'Cook'),
(3, 'Lucy Blue', 'Delivery Driver');

-- Insert data into pizzamenu (pizza menu)
INSERT INTO pizzamenu (pizzaID, nimi, hind) VALUES
(1, 'Margarita', '8.99'),
(2, 'Pepperoni', '9.99'),
(3, 'Vegetarian', '9.49'),
(4, 'Hawaiian', '9.79');

-- Insert data into tellimused (orders)
INSERT INTO tellimused (tellimus_ID, tellimus_aeg) VALUES
(1, '2025-05-22 12:00:00'),
(2, '2025-05-22 12:30:00'),
(3, '2025-05-22 13:00:00');

-- Insert data into tellimusse_rida (order rows)
INSERT INTO tellimusse_rida (tellimuserida_ID, kogus, pizzamenu_pizzaID, tellimused_tellimus_ID) VALUES
(1, 2, 1, 1),  -- 2 Margarita pizzas for order 1
(2, 1, 2, 1),  -- 1 Pepperoni pizza for order 1
(3, 3, 3, 2),  -- 3 Vegetarian pizzas for order 2
(4, 2, 4, 3);  -- 2 Hawaiian pizzas for order 3

-- Insert data into makse (payment)
INSERT INTO makse (makse_ID, nakseviis, makse_aeg, summa, tellimused_tellimus_ID) VALUES
(1, 'Credit Card', 20250522120000, '27.97', 1),
(2, 'Cash', 20250522123000, '28.47', 2),
(3, 'Credit Card', 20250522130000, '19.58', 3);

-- Insert data into kohaletoimetamine (delivery)
INSERT INTO kohaletoimetamine (kohaletoimetamine_ID, aadress, kohaletoimetamise_tyyp, tootajad_tootaja_ID, kliendid_kliendi_ID) VALUES
(1, '123 Elm St', 'Delivery', 3, 1),
(2, '456 Oak St', 'Pickup', 1, 2),
(3, '789 Pine St', 'Delivery', 3, 3);

CREATE VIEW tellimuste_vaade AS
SELECT 
    k.nimi AS klient,
    t.tellimus_aeg,
    p.nimi AS pizza,
    tr.kogus
FROM tellimused t
INNER JOIN tellimusse_rida tr ON t.tellimus_ID = tr.tellimused_tellimus_ID
INNER JOIN pizzamenu p ON p.pizzaID = tr.pizzamenu_pizzaID
INNER JOIN kohaletoimetamine kh ON kh.tellimus_ID = t.tellimus_ID
INNER JOIN kliendid k ON k.kliendi_ID = kh.kliendid_kliendi_ID;

CREATE VIEW makse_vaade AS
SELECT m.makse_ID, m.nakseviis, m.summa, k.nimi AS klient
FROM makse m
INNER JOIN tellimused t ON m.tellimused_tellimus_ID = t.tellimus_ID
INNER JOIN kohaletoimetamine kh ON kh.tellimus_ID = t.tellimus_ID
INNER JOIN kliendid k ON k.kliendi_ID = kh.kliendid_kliendi_ID;
SELECT * FROM makse_vaade
ORDER BY makse_ID;

CREATE VIEW kohaletoimetamise_vaade AS
SELECT 
    kh.kohaletoimetamise_tyyp, 
    kh.aadress, 
    t.tootajanimi AS tootaja, 
    k.nimi AS klient
FROM kohaletoimetamine kh
INNER JOIN tootajad t ON kh.tootajad_tootaja_ID = t.tootaja_ID
INNER JOIN kliendid k ON kh.kliendid_kliendi_ID = k.kliendi_ID;

SELECT * FROM kohaletoimetamise_vaade
ORDER BY kohaletoimetamise_tyyp;

SELECT t.tellimus_ID, k.kliendi_ID, k.nimi, kh.tellimus_ID AS kh_tellimus_ID
FROM tellimused t
LEFT JOIN kohaletoimetamine kh ON t.tellimus_ID = kh.tellimus_ID
LEFT JOIN kliendid k ON kh.kliendid_kliendi_ID = k.kliendi_ID;


SELECT * FROM tellimused; 
SELECT * FROM tellimusse_rida;
SELECT * FROM pizzamenu;
SELECT * FROM kohaletoimetamine;
SELECT * FROM kliendid;
SELECT * FROM makse;
SELECT * FROM tootajad;


CREATE PROCEDURE lisa_klient (
    @p_kliendi_ID INT,
    @p_nimi VARCHAR(30),
    @p_telefon VARCHAR(30)
)
AS
BEGIN
    INSERT INTO kliendid (kliendi_ID, nimi, telefon)
    VALUES (@p_kliendi_ID, @p_nimi, @p_telefon);
END;
EXEC lisa_klient @p_kliendi_ID = 5, @p_nimi = 'Mati', @p_telefon = '555-8888';
