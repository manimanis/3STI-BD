DROP DATABASE IF EXISTS myclasses;
CREATE DATABASE myclasses;
USE myclasses;

CREATE TABLE Eleves (
	numel CHAR(4) NOT NULL PRIMARY KEY CHECK(LEFT(numel,1)='E' AND (RIGHT(numel, 3)*1) BETWEEN 1 AND 999),
	nom VARCHAR(32) NOT NULL,
	prenom VARCHAR(32) NOT NULL,
	genre CHAR(1) DEFAULT 'M' CHECK(genre IN ('M','F')),
	datenaiss DATE NOT NULL
);

CREATE TABLE Classes (
    numcl CHAR(4) NOT NULL PRIMARY KEY CHECK(LEFT(numcl,1)='C' AND (RIGHT(numcl,3)*1) BETWEEN 1 AND 999),
    libelle VARCHAR(16) NOT NULL,
    niveau INT NOT NULL DEFAULT 1 CHECK(niveau BETWEEN 1 AND 4),
    section VARCHAR(16) NOT NULL,
    numord INT NOT NULL DEFAULT 1 CHECK(numord >= 1)
);

CREATE TABLE ClassesEleves (
	numel CHAR(4) NOT NULL REFERENCES Eleves (numel) ON UPDATE CASCADE ON DELETE CASCADE,
	numcl CHAR(4) NOT NULL REFERENCES Classes (numcl) ON UPDATE CASCADE ON DELETE CASCADE,
	annee INT NOT NULL,
	PRIMARY KEY (numel, numcl, annee)
);

INSERT INTO Eleves (numel, nom, prenom, genre, datenaiss)
VALUES ('E001','Mazzez','Adem','M','2007-04-27'),
	('E002','Lajmi','Eya','F','2006-12-18'),
	('E003','Ben Moussa','Ahmed','M','2006-08-20'),
	('E004','Lajmi','Isra','F','2004-11-29'),
	('E005','Kassouma','Mohamed Amine','M','2006-10-15'),
	('E006','Ben Hmida','Adem','M','2005-09-10'),
	('E007','Ben Massoud','Amal','F','2006-05-05'),
	('E008','Jedidi','Ayhem','M','2006-02-18'),
	('E009','Gaaloul','Abrar','F','2006-02-24'),
	('E010','Garzoul','Raslène','M','2006-03-10'),
    ('E011','Ben Saber','Sami','M','2004-11-29'),
    ('E012','Hassen','Maha','F','2004-11-29');

INSERT INTO Classes (numcl, libelle, niveau, section, numord)
VALUES ('C001','1S1','1','S','1'),
	('C002','1S2','1','S','2'),
	('C003','2INFO1','2','INFO','1'),
	('C004','2INFO2','2','INFO','2'),
	('C005','3INFO1','3','INFO','1'),
    ('C006','2ECO1','2','ECO','1'),
    ('C007','2ECO2','2','ECO','2');

INSERT INTO ClassesEleves (annee, numel, numcl)
VALUES ('2020','E005','C003'),
    ('2020','E010','C003'),
    ('2021','E001','C001'),
	('2021','E002','C002'),
	('2021','E003','C003'),
	('2021','E004','C002'),
	('2021','E005','C003'),
	('2021','E006','C003'),
	('2021','E007','C003'),
	('2021','E008','C003'),
	('2021','E009','C003'),
	('2021','E010','C003'),
	('2022','E001','C004'),
	('2022','E002','C004'),
	('2022','E003','C004'),
	('2022','E004','C004'),
	('2022','E005','C004'),
	('2022','E006','C005'),
	('2022','E007','C005'),
	('2022','E008','C005'),
	('2022','E009','C005'),
	('2022','E010','C005');

SELECT * FROM Eleves ORDER BY datenaiss, prenom, nom;

SELECT * FROM Classes ORDER BY niveau, section, numord;

SELECT * FROM ClassesEleves ORDER BY annee, numcl, numel;

-- 2.a
SELECT nom, prenom, libelle, annee
FROM Eleves AS e, Classes AS c, ClassesEleves AS ce
WHERE ce.numel = e.numel AND
	ce.numcl = c.numcl
ORDER BY annee DESC, libelle;

-- 2.b
SELECT nom, prenom, libelle, annee
FROM Eleves AS e, Classes AS c, ClassesEleves AS ce
WHERE ce.numel = e.numel AND
	ce.numcl = c.numcl AND 
    niveau = 2
ORDER BY annee, libelle;

-- 2.c
SELECT nom, prenom, libelle, annee
FROM Eleves AS e, Classes AS c, ClassesEleves AS ce
WHERE ce.numel = e.numel AND
	ce.numcl = c.numcl AND
    libelle = '2INFO2' AND
    annee = 2022;

-- 2.d
SELECT libelle, annee
FROM Eleves AS e, Classes AS c, ClassesEleves AS ce
WHERE ce.numel = e.numel AND
	ce.numcl = c.numcl AND 
	nom = 'Lajmi' AND
	prenom = 'Eya'
ORDER BY annee;

-- 2.e
SELECT nom, prenom, CONCAT((niveau+1), section) AS niveau23
FROM Eleves AS e, Classes AS c, ClassesEleves AS ce
WHERE ce.numel = e.numel AND
	ce.numcl = c.numcl AND
	annee = 2022;

-- 2.f
SELECT MIN(datenaiss) AS datenaiss
FROM Eleves;

SELECT nom, prenom 
FROM Eleves 
WHERE datenaiss IN (SELECT MIN(datenaiss) FROM Eleves);

-- 2.g
SELECT ce.numcl, libelle 
FROM Classes AS c, Eleves AS e, ClassesEleves AS ce 
WHERE ce.numcl = c.numcl AND 
    ce.numel = e.numel AND 
    nom = 'Mazzez' AND 
    prenom = 'Adem' AND 
    annee = 2022;

SELECT nom, prenom, genre
FROM Eleves AS e, ClassesEleves AS ce
WHERE ce.numel = e.numel AND
    ce.numcl = (
        SELECT ce.numcl
        FROM Classes AS c, Eleves AS e, ClassesEleves AS ce 
        WHERE ce.numcl = c.numcl AND 
            ce.numel = e.numel AND 
            nom = 'Mazzez' AND 
            prenom = 'Adem' AND 
            annee = 2022        
    ) AND
    annee = 2022;

-- 2.h 
SELECT *
FROM Eleves
WHERE numel NOT IN (
    SELECT DISTINCT numel FROM ClassesEleves
);

-- 2.i
SELECT *
FROM Classes
WHERE numcl NOT IN (
    SELECT DISTINCT numcl FROM ClassesEleves
);