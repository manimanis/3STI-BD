DROP DATABASE location_vehicules;

-- Création de la base de données
CREATE DATABASE location_vehicules;

-- Utiliser la base de données locatiion_vehicules
USE location_vehicules;

-- Création de la table vehicules
CREATE TABLE vehicules (
    matricule VARCHAR(10) PRIMARY KEY NOT NULL,
    vehicule VARCHAR(32) NOT NULL,
    prix_unit DOUBLE NOT NULL DEFAULT 0.0,
    libre CHAR(1) DEFAULT 'O' 
                  CHECK (libre = 'O' OR libre = 'N')
);

-- Créer la table clients
CREATE TABLE clients (
    cin VARCHAR(10) PRIMARY KEY,
    client VARCHAR(32) NOT NULL,
    genre CHAR(1) NOT NULL DEFAULT 'M' CHECK(genre IN ('M', 'F')),
    tel VARCHAR(16) NOT NULL
);

-- Créer la table locations
CREATE TABLE locations (
    num_location INT PRIMARY KEY AUTO_INCREMENT,
    matricule VARCHAR(10) NOT NULL,
    cin VARCHAR(10) NOT NULL,
    date_location DATE NOT NULL DEFAULT NOW(),
    date_retour DATE NOT NULL CHECK(date_retour > date_location),
    montant_location DOUBLE NOT NULL CHECK(montant_location >= 0.0),
    CONSTRAINT fk_location_1 FOREIGN KEY (matricule)
        REFERENCES vehicules (matricule)
        ON UPDATE CASCADE
        ON DELETE CASCADE,
    CONSTRAINT fk_location_2 FOREIGN KEY (cin)
        REFERENCES clients (cin)
        ON UPDATE CASCADE
        ON DELETE CASCADE
);

-- Remplir la table vehicules
INSERT INTO vehicules (matricule, vehicule, prix_unit, libre)
VALUES ('200TU4906', 'Clio 4', 60, 'O'),
    ('203TU4480', 'Suzuki Swift-BVA', 80, 'O'),
    ('203TU8041', 'Clio 4', 60, 'O'),
    ('204TU9333', 'Seat IBIZA', 60, 'N'),
    ('205TU6551', 'Seat IBIZA', 60, 'O'),
    ('205TU9334', 'Clio 5', 70, 'N'),
    ('206TU5473', 'Suzuki Swift-BVA', 80, 'O'),
    ('206TU9804', 'Clio 4', 60, 'O'),
    ('207TU4480', 'Suzuki Swift-BVA', 80, 'O'),
    ('207TU8780', 'Clio 5', 70, 'O');

-- Remplir la table clients
INSERT INTO clients (cin, client, genre, tel)
VALUES ('03972583', 'Amir', 'M', '36704253'),
    ('04202363', 'Aziz', 'M', '70116709'),
    ('02500463', 'Hajer', 'F', '36079515');

-- Remplir la table locations
INSERT INTO locations (num_location, matricule, cin, date_location, date_retour, montant_location)
VALUES (1, '203TU4480', '03972583', '2022-01-02', '2022-01-03', 80),
    (2, '206TU5473', '04202363', '2022-01-02', '2022-01-03', 80),
    (3, '203TU8041', '04202363', '2022-01-05', '2022-01-06', 60),
    (4, '203TU8041', '03972583', '2022-01-06', '2022-01-09', 180),
    (5, '205TU6551', '04202363', '2022-01-07', '2022-01-08', 60),
    (6, '206TU9804', '04202363', '2022-01-08', '2022-01-26', 1080),
    (7, '207TU4480', '04202363', '2022-01-10', '2022-01-12', 160),
    (8, '200TU4906', '03972583', '2022-01-13', '2022-01-14', 60),
    (9, '204TU9333', '03972583', '2022-01-15', '2022-01-16', 60),
    (10, '207TU4480', '04202363', '2022-01-18', '2022-01-19', 80),
    (11, '206TU5473', '04202363', '2022-01-21', '2022-01-22', 80),
    (12, '207TU4480', '04202363', '2022-01-24', '2022-01-25', 80),
    (13, '205TU9334', '04202363', '2022-01-28', '2022-02-03', 420),
    (14,'204TU9333', '03972583', '2022-01-28', '2022-02-01', 240);

-- Ajouter le nouoveau client Youssef, son cin est 12569800 et son téléphone est 52349157
INSERT INTO clients (cin, client, genre, tel)
VALUES ('12569800', 'Youssef', 'M', 52349157);

-- Insertion de Assia
INSERT INTO clients (client, cin, tel)
VALUES ('Assia', '12650890', '52349157');

-- Vérifier que Assia a été insérée
SELECT * FROM clients WHERE cin = '12650890';

-- Mettre à jour le genre de Assia
UPDATE clients
SET genre = 'F'
WHERE cin = '12650890';

-- Afficher la liste des clientes par ordre croissant de leurs noms
SELECT * FROM clients WHERE genre = 'F' ORDER BY client;

-- Afficher la liste des clients qui disposent d'un numéro de téléphone Orange (commençant par 5) ou Tunisie Telecom (commençant par 7 ou 9).
SELECT * FROM clients WHERE LEFT(tel, 1) IN ('5', '7', '9');

-- Mettre à jour le numéro de téléphone de Aziz
UPDATE clients SET tel = '25025637' WHERE cin = '04202363';

-- Afficher la liste des véhicules 'Clio 5' libres
SELECT * FROM vehicules WHERE vehicule = 'Clio 5' AND libre = 'O';

-- Ce véhicule a été loué à « Youssef » pendant 5 jours du 01/02/2022 au 06/02/2022.
-- Insérer cette location, 
INSERT INTO locations (matricule, cin, date_location, date_retour, montant_location)
VALUES ('207TU8780', '12569800', '2022-02-01', '2022-02-06', 5 * 70.0);
-- et mettre à jour la liste des véhicules.
UPDATE vehicules SET libre = 'N' WHERE matricule = '207TU8780';
-- Vérifier le bon déroulement de l'opération
SELECT * FROM vehicules WHERE matricule = '207TU8780';
SELECT * FROM locations WHERE matricule = '207TU8780';

-- Louer un véhicule non libre à Assia
INSERT INTO locations (matricule, cin, date_location, date_retour, montant_location)
VALUES ('204TU9333', '12650890', '2022-02-01', '2022-02-03', 2 * 60.0);

-- Dernier num_location
SELECT MAX(num_location) FROM locations;

-- Supprimer l'enregistrement incorrect
DELETE FROM locations WHERE num_location = 16;