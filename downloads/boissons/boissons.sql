DROP DATABASE IF EXISTS boissons;
CREATE DATABASE boissons;
USE boissons;
CREATE TABLE ingredients (
    num_ing INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    lib_ing VARCHAR(64) NOT NULL
);
CREATE TABLE boissons (
    num_b INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    lib_boi VARCHAR(64) NOT NULL
);
CREATE TABLE ing_boissons (
    num_b INT NOT NULL,
    num_ing INT NOT NULL,
    qte DOUBLE NOT NULL CHECK(qte > 0.0 AND qte <= 1.0),
    PRIMARY KEY(num_b, num_ing),
    FOREIGN KEY (num_b) REFERENCES boissons(num_b)
        ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (num_ing) REFERENCES ingredients(num_ing)
        ON DELETE CASCADE ON UPDATE CASCADE
);
INSERT INTO ingredients (num_ing, lib_ing)
VALUES (1, 'Eau'),
    (2, 'Café Moulu'),
    (3, 'Lait'),
    (4, 'Chocolat'),
    (5, 'Sucre'),
    (6, 'Thé'),
    (7, 'Amandes'),
    (8, 'Sel');
INSERT INTO boissons (num_b, lib_boi)
VALUES (1, 'Café Turc'),
    (2, 'Thé aux amandes'),
    (3, 'Chocolat chaud'),
    (4, 'Lait au chocolat');
INSERT INTO ing_boissons (num_b, num_ing, qte)
VALUES (1, 1, 0.8),
    (1, 2, 0.1),
    (1, 5, 0.1),
    (2, 1, 0.7),
    (2, 6, 0.1),
    (2, 5, 0.1),
    (2, 7, 0.1),
    (3, 3, 0.3),
    (3, 4, 0.5),
    (3, 5, 0.2),
    (4, 3, 0.8),
    (4, 4, 0.1),
    (4, 5, 0.1);
-- 1 : Affiche les ingrédients du "Café Turc".
SELECT lib_ing, qte
FROM ingredients AS i, boissons AS b, ing_boissons AS ib
WHERE i.num_ing = ib.num_ing AND b.num_b = ib.num_b AND
    lib_boi = 'Café Turc';
/*
+-------------+-----+
| lib_ing     | qte |
+-------------+-----+
| Eau         | 0.8 |
| Café Moulu  | 0.1 |
| Sucre       | 0.1 |
+-------------+-----+
*/
-- 2 : Affiche les boissons basée sur l’Eau comme ingrédient.
SELECT lib_boi
FROM ingredients AS i, boissons AS b, ing_boissons AS ib
WHERE i.num_ing = ib.num_ing AND b.num_b = ib.num_b AND
    lib_ing = 'Eau';
/*
+------------------+
| lib_boi          |
+------------------+
| Café Turc        |
| Thé aux amandes  |
+------------------+
*/
-- 3 : Affiche les noms des boissons qui nécessitent 80% de Lait.
SELECT lib_boi
FROM ingredients AS i, boissons AS b, ing_boissons AS ib
WHERE i.num_ing = ib.num_ing AND b.num_b = ib.num_b AND
    lib_ing = 'Lait' AND qte = 0.8;
/*
+------------------+
| lib_boi          |
+------------------+
| Lait au chocolat |
+------------------+
*/
-- 4 : Affiche les noms des boissons les plus sucrées.
SELECT lib_boi, qte
FROM ingredients AS i, boissons AS b, ing_boissons AS ib
WHERE i.num_ing = ib.num_ing AND b.num_b = ib.num_b AND
    lib_ing = 'Sucre' AND qte = (
        SELECT MAX(qte)
        FROM ingredients AS i1, ing_boissons AS ib1
        WHERE i1.num_ing = ib1.num_ing AND
            lib_ing = 'Sucre'
    );
/*
+----------------+-----+
| lib_boi        | qte |
+----------------+-----+
| Chocolat chaud | 0.2 |
+----------------+-----+
*/
-- 5 : Affiche les noms des boissons qui contiennent le minimum du Lait.
SELECT lib_boi, qte
FROM ingredients AS i, boissons AS b, ing_boissons AS ib
WHERE i.num_ing = ib.num_ing AND b.num_b = ib.num_b AND
    lib_ing = 'Lait' AND qte = (
        SELECT MIN(qte)
        FROM ingredients AS i1, ing_boissons AS ib1
        WHERE i1.num_ing = ib1.num_ing AND
            lib_ing = 'Lait'
    );
/*
+----------------+-----+
| lib_boi        | qte |
+----------------+-----+
| Chocolat chaud | 0.3 |
+----------------+-----+
*/
-- 6 : Affiche les noms des boissons qui ne contiennent pas du lait.
SELECT lib_boi
FROM boissons
WHERE num_b NOT IN (
    SELECT num_b
    FROM ingredients AS i1, ing_boissons AS ib1
    WHERE i1.num_ing = ib1.num_ing AND
        lib_ing = 'Lait'
);
/*
+------------------+
| lib_boi          |
+------------------+
| Café Turc        |
| Thé aux amandes  |
+-----------------
*/
-- 7 : Affiche les ingrédients qui ne font partie d’aucune boisson.
SELECT lib_ing
FROM ingredients
WHERE num_ing NOT IN (
    SELECT num_ing
    FROM ing_boissons
);
/*
+---------+
| lib_ing |
+---------+
| Sel     |
+---------+
*/