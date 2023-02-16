DROP DATABASE cinema;

CREATE DATABASE IF NOT EXISTS cinema;
USE cinema;

CREATE TABLE films (
    numfilm INT NOT NULL PRIMARY KEY,
    titre VARCHAR(128) NOT NULL,
    genre VARCHAR(32) NOT NULL
);

CREATE TABLE cinemas (
    numcin INT NOT NULL PRIMARY KEY,
    nom VARCHAR(64) NOT NULL,
    adresse VARCHAR(128) NOT NULL
);

CREATE TABLE projections (
    numfilm INT NOT NULL,
    numcin INT NOT NULL,
    jour DATE DEFAULT NOW(),
    heure TIME DEFAULT NOW(),
    PRIMARY KEY(numfilm, numcin, jour, heure),
    CONSTRAINT fk_projection1 FOREIGN KEY (numfilm)
        REFERENCES films (numfilm)
        ON UPDATE CASCADE ON DELETE CASCADE,
    CONSTRAINT fk_projection2 FOREIGN KEY (numcin)
        REFERENCES cinemas (numcin)
        ON UPDATE CASCADE ON DELETE CASCADE
);

INSERT INTO cinemas (numcin, nom, adresse)
VALUES (10, 'CINEMADART', 'Rue Hbib Bourguiba'),
    (20, 'Ciné Jamil', 'El Menzah 6'),
    (30, 'Cinéma l''empire', 'Hammam-Lif'),
    (40, 'Rex', 'La Goulette');

INSERT INTO films (numfilm, titre, genre)
VALUES (300, 'Les Schtroumpfs', 'BD'),
    (400, 'Matrix Reloaded', 'Science fiction'),
    (500, 'Bienvenue à Marly-Gomont', 'Comédie'),
    (600, 'Mr. Wolff', 'Action'),
    (700, 'Tempête de boulettes géantes', 'BD'),
    (800, 'Les Croods 2: une nouvelle ère', 'BD');

INSERT INTO projections (numfilm, numcin, jour, heure)
VALUES (300, 10, '2023-02-16', '14:00'),
    (300, 10, '2023-02-16', '17:00'),
    (300, 10, '2023-02-16', '20:00'),
    (400, 10, '2023-02-16', '14:00'),
    (400, 10, '2023-02-16', '17:00'),
    (400, 10, '2023-02-16', '20:00'),
    (500, 20, '2023-02-16', '15:00'),
    (500, 20, '2023-02-16', '18:00'),
    (500, 20, '2023-02-16', '21:00'),
    (600, 20, '2023-02-16', '15:00'),
    (600, 20, '2023-02-16', '18:00'),
    (600, 20, '2023-02-16', '21:00'),
    (700, 30, '2023-02-16', '15:00'),
    (700, 30, '2023-02-16', '18:00'),
    (700, 30, '2023-02-16', '21:00'),
    (800, 30, '2023-02-16', '15:00'),
    (800, 30, '2023-02-16', '18:00'),
    (800, 30, '2023-02-16', '21:00'),
    (800, 10, '2023-02-17', '14:00'),
    (800, 10, '2023-02-17', '17:00'),
    (800, 10, '2023-02-17', '20:00'),
    (300, 10, '2023-02-17', '14:00'),
    (300, 10, '2023-02-17', '17:00'),
    (300, 10, '2023-02-17', '20:00'),
    (400, 20, '2023-02-17', '15:00'),
    (400, 20, '2023-02-17', '18:00'),
    (400, 20, '2023-02-17', '21:00'),
    (500, 20, '2023-02-17', '15:00'),
    (500, 20, '2023-02-17', '18:00'),
    (500, 20, '2023-02-17', '21:00'),
    (600, 30, '2023-02-17', '15:00'),
    (600, 30, '2023-02-17', '18:00'),
    (600, 30, '2023-02-17', '21:00'),
    (700, 30, '2023-02-17', '15:00'),
    (700, 30, '2023-02-17', '18:00'),
    (700, 30, '2023-02-17', '21:00');