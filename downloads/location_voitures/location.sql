-- Afficher la liste des bases de données disponibles
SHOW DATABASES;

-- Création d'une nouvelle base de données
CREATE DATABASE location_voitures;

-- Utiliser la base de données créée
USE location_voitures;

-- Créer la table location
CREATE TABLE locations (
    matricule VARCHAR(10),
    vehicule VARCHAR(32),
    prix_unit DOUBLE CHECK(prix_unit >= 0),
    client VARCHAR(32),
    tel VARCHAR(16),
    date_location DATE,
    date_retour DATE,
    jours INT CHECK(jours > 0),
    prix_a_payer DOUBLE CHECK(prix_a_payer >= 0)
);

-- Afficher la listes des tables
SHOW TABLES;

-- Insérer des données dans la table locations
INSERT INTO locations (matricule, vehicule, prix_unit, client, 
    tel, date_location, date_retour, jours, prix_a_payer)
VALUES ('205TU6551', 'Seat IBIZA', 60.0, 'Mahmoud', 
    '56504673', '2022-01-03', '2022-01-05', 2, 120.0);
INSERT INTO locations (matricule, vehicule, prix_unit, client, tel, 
    date_location, date_retour, jours, prix_a_payer)
VALUES ('200TU4906', 'Clio 4', 60.0, 'Monia', '48880781', 
    '2022-01-05', '2022-01-14', 9, 540.0);
INSERT INTO locations (matricule, vehicule, prix_unit, client, tel, 
    date_location, date_retour, jours, prix_a_payer)
VALUES ('207TU4480', 'Suzuki Swift-BVA', 80.0, 'Meriem', '31827055', 
    '2022-01-05', '2022-01-07', 2, 160.0);
INSERT INTO locations (matricule, vehicule, prix_unit, client, tel, 
    date_location, date_retour, jours, prix_a_payer)
VALUES ('204TU9333', 'Seat IBIZA', 60.0, 'Mohammed', '56542559', 
    '2022-01-21', '2022-01-30', 9, 540.0);
INSERT INTO locations (matricule, vehicule, prix_unit, client, tel, 
    date_location, date_retour, jours, prix_a_payer)
VALUES ('205TU6551', 'Seat IBIZA', 60.0, 'Mouna', '36774811', 
    '2022-01-25', '2022-02-04', 10, 600.0);
INSERT INTO locations (matricule, vehicule, prix_unit, client, tel, 
    date_location, date_retour, jours, prix_a_payer)
VALUES ('205TU9334', 'Clio 5', 70.0, 'Meriem', '31827055', 
    '2022-01-27', '2022-02-01', 2, 120.0);
INSERT INTO locations (matricule, vehicule, prix_unit, client, tel, 
    date_location, date_retour, jours, prix_a_payer)
VALUES ('204TU9333', 'Seat IBIZA', 60.0, 'Mariem', '59380983', 
    '2022-01-30', '2022-02-01', 2, 120.0);
INSERT INTO locations (matricule, vehicule, prix_unit, client, tel, 
    date_location, date_retour, jours, prix_a_payer)
VALUES ('207TU4480', 'Suzuki Swift-BVA', 80.0, 'Mohamed', '25848116', 
    '2022-02-04', '2022-02-05', 1, 80.0);
INSERT INTO locations (matricule, vehicule, prix_unit, client, tel, 
    date_location, date_retour, jours, prix_a_payer)
VALUES ('207TU8780', 'Clio 5', 70.0, 'Mouhamed', '97793055', 
    '2022-02-26', '2022-02-27', 1, 70.0);

-- Afficher tous les enregistrements de la table locations
SELECT * FROM locations;

-- Afficher les locations par ordre décroissant du nombre de jours de location.
SELECT * FROM locations ORDER BY jours DESC;

-- Afficher la liste des véhicules ainsi que leurs prix ordonnée par matricule.
SELECT matricule, vehicule, prix_unit FROM locations ORDER BY matricule;

-- Afficher la liste des véhicules sans duplications.
SELECT DISTINCT matricule, vehicule, prix_unit FROM locations ORDER BY matricule;

-- Afficher la liste des noms des clients ainsi que leurs numéro de téléphone sans duplications et ordonnées par ordre alphabétique du nom.
SELECT DISTINCT client, tel FROM locations ORDER BY client;

-- Afficher les matricules, les dates de location ainsi que le nombre de jours de location des véhicules Clio 5.
SELECT matricule, vehicule, date_location, jours 
FROM locations
WHERE vehicule = 'Clio 5';

-- Afficher la liste des locations effectuée en mois de Février 2022.
SELECT * FROM locations WHERE MONTH(date_location) = 2;

-- Mettre à jour la location effectuée le 2022-02-26 pour le véhicule 207TU8780
-- La date de location est réellement le 20/02/2022 et la date de retour le 25/02/2022
-- La location est réalisée pour 5 jours.
UPDATE locations
SET
    date_location = '2022-02-20',
    date_retour = '2022-02-25',
    jours = DATEDIFF(date_retour, date_location),
    prix_a_payer = prix_unit * jours
WHERE matricule = '207TU8780' AND
    date_location = '2022-02-26';
-- Vérifier que la mise à jour est effectuée
SELECT * FROM locations 
WHERE matricule = '207TU8780' AND
    date_location = '2022-02-20';

-- Supprimer la location effectuée par Monia le 05/01/2022 pour le véhicule "Clio 4"
DELETE FROM locations
WHERE client = 'Monia' AND
    date_location = '2022-01-05' AND
    vehicule = 'Clio 4';
-- Vérifier que la location a été supprimée
SELECT * FROM locations
WHERE client = 'Monia' AND
    date_location = '2022-01-05' AND
    vehicule = 'Clio 4';
