DROP DATABASE IF EXISTS test;

CREATE DATABASE test;

USE test;

-- Créer la table eleves.
CREATE TABLE eleves (
    numeleve INT,
    nom VARCHAR(3),
    prenom INT,
    datenaiss DATETIME
);

-- Insérer l'élève suivante.
INSERT INTO eleves (numeleve, nom, prenom, datenaiss)
VALUES (1, 'BEN BCHIR', 'Bochra', '2030-06-01');
-- ERROR 1406 (22001): Data too long for column 'nom' at row 1
-- Raison : Le nom de l'élève contient plus de 3 caractères (taille maximale du champ nom).

-- Modifier la taille du champ nom et le rendre obligtaoire.
ALTER TABLE eleves
MODIFY nom VARCHAR(32) NOT NULL;

-- Vérifier que le champ a bien été modifié.
SHOW CREATE TABLE eleves;

-- Faire l'insertion une seconde fois.
INSERT INTO eleves (numeleve, nom, prenom, datenaiss)
VALUES (1, 'BEN BCHIR', 'Bochra', '2030-06-01');
-- ERROR 1366 (22007): Incorrect integer value: 'Bochra' for column `test`.`eleves`.`prenom` at row 1
-- Raison : Le champ prenom est défini de type INT.

-- Modifier le type du champ prenom et le rendre obligatoire.
ALTER TABLE eleves
MODIFY prenom VARCHAR(32) NOT NULL;

-- Faire l'insertion une seconde fois.
INSERT INTO eleves (numeleve, nom, prenom, datenaiss)
VALUES (1, 'BEN BCHIR', 'Bochra', '2030-06-01');

-- Visualiser le contenu de la table eleves.
SELECT * FROM eleves;
/*
+----------+-----------+--------+---------------------+
| numeleve | nom       | prenom | datenaiss           |
+----------+-----------+--------+---------------------+
|        1 | BEN BCHIR | Bochra | 2030-06-01 00:00:00 |
+----------+-----------+--------+---------------------+
*/

-- Changer le type de date de naissance, inutile d'enregistrer l'heure de naissance.
ALTER TABLE eleves
MODIFY datenaiss DATE NOT NULL;

-- Visualiser le contenu de la table eleves.
SELECT * FROM eleves;
/*
+----------+-----------+--------+------------+
| numeleve | nom       | prenom | datenaiss  |
+----------+-----------+--------+------------+
|        1 | BEN BCHIR | Bochra | 2030-06-01 |
+----------+-----------+--------+------------+
*/

-- La date de naissance de cet élèves est dans le futur. Ajouter une contrainte de domaine sur la date de naissance.
ALTER TABLE eleves
ADD CONSTRAINT chk_dn CHECK (datenaiss < '2023-01-01');
-- ERROR 4025 (23000): CONSTRAINT `chk_dn` failed for `test`.`eleves`
-- Raison : La date de naissance de l'élève Bochra ne respecte pas la contrainte de domaine.

-- L'élève est née en 2013. Corriger sa date de naissance.
UPDATE eleves SET datenaiss = '2013-06-01' WHERE numeleve = 1;

-- Ajouter la contrainte de domaine sur la date de naissance.
ALTER TABLE eleves
ADD CONSTRAINT chk_dn CHECK (datenaiss < '2023-01-01');

-- Insérer l'élève suivant.
INSERT INTO eleves (numeleve, nom, prenom, datenaiss)
VALUES (1, 'HECHMI', 'Bassem', '2003-06-01');

-- Afficher l'élèves ayant un numeleve égal à 1.
SELECT * FROM eleves WHERE numeleve = 1;
/*
+----------+-----------+--------+------------+
| numeleve | nom       | prenom | datenaiss  |
+----------+-----------+--------+------------+
|        1 | BEN BCHIR | Bochra | 2013-06-01 |
|        1 | HECHMI    | Bassem | 2003-06-01 |
+----------+-----------+--------+------------+
*/

-- Le champ numeleve est supposé être la clé primaire de la table élève.
-- Faire la correction nécessaire dans la table avant de définir ce champ comme clé primaire et le définir en mode AUTO_INCREMENT.
UPDATE eleves SET numeleve = 2 WHERE nom = 'HECHMI';

ALTER TABLE eleves
ADD CONSTRAINT pk_eleves PRIMARY KEY (numeleve);

ALTER TABLE eleves
MODIFY numeleve INT NOT NULL AUTO_INCREMENT;

-- Ajouter l'élève suivant. Puis trouver son numeleve;
INSERT INTO eleves (nom, prenom, datenaiss)
VALUES ('MASRI', 'Hend', '2010-05-07');

SELECT * FROM eleves WHERE nom = 'MASRI';
/*
+----------+-------+--------+------------+
| numeleve | nom   | prenom | datenaiss  |
+----------+-------+--------+------------+
|        3 | MASRI | Hend   | 2010-05-07 |
+----------+-------+--------+------------+
*/

-- Ajouter un champ genre à la table eleves.
ALTER TABLE eleves
ADD COLUMN genre CHAR(1) DEFAULT 'M' CHECK(genre IN ('M', 'F'));

-- Afficher la liste des élèves et corriger leurs genres.
SELECT * FROM eleves;
/*
+----------+-----------+--------+------------+-------+
| numeleve | nom       | prenom | datenaiss  | genre |
+----------+-----------+--------+------------+-------+
|        1 | BEN BCHIR | Bochra | 2013-06-01 | M     |
|        2 | HECHMI    | Bassem | 2003-06-01 | M     |
|        3 | MASRI     | Hend   | 2010-05-07 | M     |
+----------+-----------+--------+------------+-------+
*/

UPDATE eleves SET genre = 'F' WHERE numeleve IN (1, 3);

-- Créer la table billets_entrees
CREATE TABLE billets_entrees (
    numbillet INT,
    numeleve INT,
    datebillet DATETIME DEFAULT NOW(),
    motif VARCHAR(128)
);

-- Définir le champ numbillet comme clé primaire.
ALTER TABLE billets_entrees
ADD CONSTRAINT pk_billets_entrees PRIMARY KEY (numbillet);

-- Modifier le champ numbillet pour qu'il soit auto incrémenté.
ALTER TABLE billets_entrees
MODIFY numbillet INT NOT NULL AUTO_INCREMENT;

-- Définir le champ numeleve comme clé étrangère qui relie la table billets_entrees à la table eleves.
ALTER TABLE billets_entrees
ADD CONSTRAINT fk_numeleve FOREIGN KEY (numeleve) REFERENCES eleves (numeleve) 
    ON UPDATE CASCADE ON DELETE CASCADE;

-- Ajouter un billet d'entrée pour l'élève Bochra, le '2023-04-05 08:00'. Elle était malade.
INSERT INTO billets_entrees (numeleve, datebillet, motif)
VALUES (1, '2023-04-05 08:00', 'Maladie');

-- Ajouter un billet d'entrée pour l'élève Bassem sans mentionner de date. Le motif : Retard.
INSERT INTO billets_entrees (numeleve, motif)
VALUES (2, 'Retard');

SELECT * FROM billets_entrees;