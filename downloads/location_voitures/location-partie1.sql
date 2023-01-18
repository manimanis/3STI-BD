-- Supprimer la base de données si elle existe déjà
DROP DATABASE IF EXISTS location_voitures;

-- Afficher la liste des bases de données disponibles
SHOW DATABASES;;

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
INSERT INTO locations (matricule, vehicule, prix_unit, client, tel, date_location, date_retour, jours, prix_a_payer)
VALUES ('205TU6551', 'Seat IBIZA', 60.0, 'Mahmoud', '56504673', '2022-01-03', '2022-01-05', 2, 120.0);
INSERT INTO locations (matricule, vehicule, prix_unit, client, tel, date_location, date_retour, jours, prix_a_payer)
VALUES ('200TU4906', 'Clio 4', 60.0, 'Monia', '48880781', '2022-01-05', '2022-01-14', 9, 540.0);
INSERT INTO locations (matricule, vehicule, prix_unit, client, tel, date_location, date_retour, jours, prix_a_payer)
VALUES ('207TU4480', 'Suzuki Swift-BVA', 80.0, 'Meriem', '31827055', '2022-01-05', '2022-01-07', 2, 160.0);
INSERT INTO locations (matricule, vehicule, prix_unit, client, tel, date_location, date_retour, jours, prix_a_payer)
VALUES ('204TU9333', 'Seat IBIZA', 60.0, 'Mohammed', '56542559', '2022-01-21', '2022-01-30', 9, 540.0);
INSERT INTO locations (matricule, vehicule, prix_unit, client, tel, date_location, date_retour, jours, prix_a_payer)
VALUES ('205TU6551', 'Seat IBIZA', 60.0, 'Mouna', '36774811', '2022-01-25', '2022-02-04', 10, 600.0);
INSERT INTO locations (matricule, vehicule, prix_unit, client, tel, date_location, date_retour, jours, prix_a_payer)
VALUES ('205TU9334', 'Clio 5', 70.0, 'Meriem', '31827055', '2022-01-27', '2022-02-01', 2, 120.0);
INSERT INTO locations (matricule, vehicule, prix_unit, client, tel, date_location, date_retour, jours, prix_a_payer)
VALUES ('204TU9333', 'Seat IBIZA', 60.0, 'Mariem', '59380983', '2022-01-30', '2022-02-01', 2, 120.0);
INSERT INTO locations (matricule, vehicule, prix_unit, client, tel, date_location, date_retour, jours, prix_a_payer)
VALUES ('207TU4480', 'Suzuki Swift-BVA', 80.0, 'Mohamed', '25848116', '2022-02-04', '2022-02-05', 1, 80.0);
INSERT INTO locations (matricule, vehicule, prix_unit, client, tel, date_location, date_retour, jours, prix_a_payer)
VALUES ('207TU8780', 'Clio 5', 70.0, 'Mouhamed', '97793055', '2022-02-26', '2022-02-27', 1, 70.0);