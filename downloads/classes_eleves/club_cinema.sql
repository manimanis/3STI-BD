-- Question 1 --
CREATE DATABASE club_cinema;
USE club_cinema;

-- Question 2 --
CREATE TABLE Film (
    NumFilm INT NOT NULL PRIMARY KEY,
    TitreFilm VARCHAR(64) NOT NULL,
    Genre VARCHAR(32)
);

CREATE TABLE Cinema (
    NumCin INT NOT NULL PRIMARY KEY,
    NomCin VARCHAR(64) NOT NULL,
    AdresseCin VARCHAR(128) NOT NULL
);

CREATE TABLE Projection (
    NumFilm INT NOT NULL,
    NumCin INT NOT NULL,
    `Date` DATE NOT NULL DEFAULT NOW(),
    Heure TIME NOT NULL DEFAULT NOW(),
    PRIMARY KEY (NumFilm, NumCin, `Date`, Heure),
    CONSTRAINT fk_Projection_1 FOREIGN KEY (NumFilm)
        REFERENCES Film (NumFilm)
        ON UPDATE CASCADE
        ON DELETE CASCADE,
    CONSTRAINT fk_Projection_2 FOREIGN KEY (NumCin)
        REFERENCES Cinema (NumCin)
        ON UPDATE CASCADE
        ON DELETE CASCADE
);

-- Question 3 --
INSERT INTO Cinema (NumCin, NomCin, AdresseCin)
VALUES (50, 'Le Parnasse', 'Av. Habib Bourguiba'),
    (51, 'Cinévog', '10 Rue Saïd Abou Baker');
INSERT INTO Film (NumFilm, TitreFilm, Genre)
VALUES (1, 'Summer Holiday', 'Comédie'),
    (2, 'Matrix', 'Science-fiction'),
    (3, 'The Kid', 'Comédie');

-- Question 4 --

-- (a) -- 
-- Projection du même film dans le même cinéma deux fois par jour.
INSERT INTO Projection (NumFilm, NumCin, `Date`, Heure)
VALUES (1, 50, '2022-01-15', '10:00'),
    (1, 50, '2022-01-15', '15:00');

-- (b) --
DELETE FROM Projection WHERE NumFilm = 1 AND NumCin = 50 AND `Date` = '2022-01-15';

-- (c) -- 
-- pas encore étudiée

-- (d) --
INSERT INTO Projection (NumFilm, NumCin, `Date`, Heure)
VALUES (1, 50, '2022-01-15', '10:00'),
    (2, 50, '2022-01-15', '15:00'),
    (3, 50, '2022-01-15', '19:00'),
    (1, 50, '2022-01-16', '10:00'),
    (2, 50, '2022-01-16', '15:00'),
    (3, 50, '2022-01-16', '19:00'),
    (1, 51, '2022-01-15', '14:00'),
    (2, 51, '2022-01-15', '20:00'),
    (1, 51, '2022-01-16', '14:00'),
    (3, 51, '2022-01-16', '20:00');

-- Question 5 --
-- (a) --
SELECT NomCin From Cinema;
-- (b) --
SELECT NomCin, AdresseCin FROM Cinema WHERE NumCin = 51;
-- (c) --
-- pas encore étudiée
SELECT COUNT(NumCin) FROM Cinema;
-- (d) --
SELECT TitreFilm, Genre FROM Film WHERE Genre = 'Comédie';
-- (e) --
SELECT TitreFilm, Genre FROM Film WHERE Genre = 'Comédie' ORDER BY TitreFilm;
-- (f) --
SELECT TitreFilm, Genre FROM Film WHERE Genre = 'Comédie' ORDER BY TitreFilm DESC;
