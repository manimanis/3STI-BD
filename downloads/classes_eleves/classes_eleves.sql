CREATE DATABASE IF NOT EXISTS classes;

USE classes;

-- Question 1
CREATE TABLE eleves (
    ideleve INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    nom VARCHAR(32) NOT NULL,
    prenom VARCHAR(32) NOT NULL
);

CREATE TABLE classes (
    idclasse INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    libelle VARCHAR(16) NOT NULL,
    annee INT NOT NULL DEFAULT 2023 CHECK(annee >= 2020)
);

CREATE TABLE eleves_classes (
    idclasse INT NOT NULL,
    ideleve INT NOT NULL,
    PRIMARY KEY (idclasse, ideleve),
    CONSTRAINT fk_eleves_classes1 FOREIGN KEY (idclasse)
        REFERENCES classes (idclasse)
        ON UPDATE CASCADE ON DELETE CASCADE,
    CONSTRAINT fk_eleves_classes2 FOREIGN KEY (ideleve)
        REFERENCES eleves (ideleve)
        ON UPDATE CASCADE ON DELETE CASCADE
);

-- Question 2 (devoir 1)
INSERT INTO eleves (ideleve, nom, prenom)
VALUES (4206, 'GAALOUL', 'Abrar'),
    (325, 'Mougou', 'Adem');
INSERT INTO classes (idclasse, libelle, annee)
VALUES (86, '2TI', 2021),
    (76, '3STI', 2022);
INSERT INTO eleves_classes (idclasse, ideleve)
VALUES (86, 4206),
    (76, 4206),
    (86, 325),
    (76, 325);

-- Question 3 (devoir 1)
-- a
SELECT * FROM eleves;
-- b
SELECT * FROM eleves ORDER BY nom, prenom;
-- c
SELECT nom, prenom FROM eleves WHERE ideleve IN (1717, 6726, 9444);
-- d
SELECT * FROM classes ORDER BY annee DESC, libelle;
-- e
SELECT * FROM classes WHERE libelle LIKE '2%' AND annee = 2022;
-- f
SELECT * FROM eleves_classes WHERE idclasse = 86 ORDER BY ideleve;

-- Question 2 (devoir 2)
INSERT INTO eleves (ideleve, nom, prenom)
VALUES (74206, 'DAHMANE', 'Yassine'),
    (6325, 'DAHMANE', 'Yassine');
-- INSERT INTO classes (idclasse, libelle, annee)
-- VALUES (86, '2TI', 2021),
--    (76, '3STI', 2022);
INSERT INTO eleves_classes (idclasse, ideleve)
VALUES (86, 74206),
    (76, 74206),
    (86, 6325),
    (76, 6325);

-- Question 3 (devoir 2)
-- a
SELECT * FROM classes;
-- b
SELECT * FROM classes ORDER BY annee, libelle;
-- c 
SELECT * FROM classes WHERE idclasse IN (81, 72, 44);
-- d
SELECT * FROM eleves WHERE nom LIKE 'B%';
-- e
SELECT * FROM classes WHERE libelle LIKE '4%' AND annee = 2021;
-- f
SELECT * FROM eleves_classes WHERE ideleve = 74206 ORDER BY idclasse;