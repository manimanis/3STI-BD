DROP DATABASE location_vehicules;

-- Création de la base de données
CREATE DATABASE location_vehicules;

-- Utiliser la base de données locatiion_vehicules
USE location_vehicules;

-- Création de la table vehicules
CREATE TABLE vehicules (
    matricule VARCHAR(10) PRIMARY KEY NOT NULL,
    vehicule VARCHAR(32) NOT NULL,
    prix_unit DOUBLE NOT NULL DEFAULT 0,
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

INSERT INTO locations (matricule, cin, date_location, date_retour, montant_location)
VALUES ('203TU4480', '03972583', '2022-01-02', '2022-01-03', 80),
    ('206TU5473', '04202363', '2022-01-02', '2022-01-03', 80),
    ('203TU8041', '04202363', '2022-01-05', '2022-01-06', 60),
    ('203TU8041', '03972583', '2022-01-06', '2022-01-09', 180),
    ('205TU6551', '04202363', '2022-01-07', '2022-01-08', 60),
    ('206TU9804', '04202363', '2022-01-08', '2022-01-26', 1080),
    ('207TU4480', '04202363', '2022-01-10', '2022-01-12', 160),
    ('200TU4906', '03972583', '2022-01-13', '2022-01-14', 60),
    ('204TU9333', '03972583', '2022-01-15', '2022-01-16', 60),
    ('207TU4480', '04202363', '2022-01-18', '2022-01-19', 80),
    ('206TU5473', '04202363', '2022-01-21', '2022-01-22', 80),
    ('207TU4480', '04202363', '2022-01-24', '2022-01-25', 80),
    ('205TU9334', '04202363', '2022-01-28', '2022-02-03', 420),
    ('204TU9333', '03972583', '2022-01-28', '2022-02-01', 240);
