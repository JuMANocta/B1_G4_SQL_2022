DROP DATABASE IF EXISTS sql_sh;

CREATE DATABASE sql_sh;

USE sql_sh;

CREATE TABLE IF NOT EXISTS client (
    identifiant INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    prenom VARCHAR(25) NOT NULL,
    nom VARCHAR(25) NOT NULL,
    ville VARCHAR(25) NOT NULL
);

INSERT INTO client (prenom, nom, ville) 
VALUES 
('Pierre', 'Dupont', 'Paris'),
('Sabrina', 'Durand', 'Nantes'),
('Julien', 'Martin', 'Lyon'),
('David', 'Bernard', 'Marseille'),
('Marie', 'Leroy', 'Grenoble');

SELECT ville FROM client;

SELECT nom, prenom FROM client;

-- Mode Terminal
mysql -u root
-- je suis dans mysql
SHOW DATABASES;
-- +--------------------+
-- | Database           |
-- +--------------------+
-- | sql_sh             |
-- +--------------------+
USE sql_sh;
-- je suis dans la base sql_sh
SHOW TABLES;
-- +------------------+
-- | Tables_in_sql_sh |
-- +------------------+
-- | client           |
-- +------------------+
DESCRIBE client;
-- vison de la structure de la table
+-------------+-------------+------+-----+---------+----------------+
| Field       | Type        | Null | Key | Default | Extra          |
+-------------+-------------+------+-----+---------+----------------+
| identifiant | int         | NO   | PRI | NULL    | auto_increment |
| prenom      | varchar(25) | NO   |     | NULL    |                |
| nom         | varchar(25) | NO   |     | NULL    |                |
| ville       | varchar(25) | NO   |     | NULL    |                |
+-------------+-------------+------+-----+---------+----------------+
SELECT * FROM client;
-- +-------------+---------+---------+-----------+
-- | identifiant | prenom  | nom     | ville     |
-- +-------------+---------+---------+-----------+
-- |           1 | Pierre  | Dupont  | Paris     |
-- |           2 | Sabrina | Durand  | Nantes    |
-- |           3 | Julien  | Martin  | Lyon      |
-- |           4 | David   | Bernard | Marseille |
-- |           5 | Marie   | Leroy   | Grenoble  |
-- +-------------+---------+---------+-----------+
SELECT ville FROM client;
-- +-----------+
-- | ville     |
-- +-----------+
-- | Paris     |
-- | Nantes    |
-- | Lyon      |
-- | Marseille |
-- | Grenoble  |
-- +-----------+
INSERT INTO client (prenom, nom, ville)
VALUES
('Julien', 'Dupont', 'Paris'),
('Paul', 'Durand', 'Nantes'),
('Mac??o', 'Martin', 'Lyon'),
('Maxime', 'Bernard', 'Marseille'),
('Tom', 'Leroy', 'Grenoble');

SELECT ville FROM client;-- 10 lignes
SELECT DISTINCT ville FROM client;-- 5 lignes
SELECT ville FROM client GROUP BY ville;-- 5 lignes
-- afficher les nom et prenom des personnes qui habitent ?? Paris
SELECT nom, prenom FROM client WHERE ville = 'Paris';

-- afficher les nom et prenom des personnes qui habitent ?? Paris ou ?? Lyon
SELECT nom, prenom FROM client WHERE ville = 'Paris' OR ville = 'Lyon';
-- afficher le nom et prenom des personnes dont le nom fini par 'd'
SELECT nom, prenom FROM client WHERE nom LIKE '%d';
-- afficher toutes les personnes qui habitent ?? Paris ou ?? Lyon ou grenoble
SELECT nom, prenom FROM client WHERE ville IN ('Paris', 'Lyon', 'Grenoble');
-- afficher toutes les personnes comprisent en tre l'id 1 et 3
SELECT nom, prenom FROM client WHERE identifiant BETWEEN 1 AND 3;

-- ajouter une colonne age dans la table client
ALTER TABLE client ADD age INT;
DROP TABLE IF EXISTS client;
CREATE TABLE client (
    identifiant INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    prenom VARCHAR(25) NOT NULL,
    nom VARCHAR(25) NOT NULL,
    ville VARCHAR(25) NOT NULL,
    age INT NOT NULL
);
INSERT INTO client (prenom, nom, ville, age) 
VALUES 
('Pierre', 'Dupont', 'Paris', 25),
('Sabrina', 'Durand', 'Nantes', 30),
('Julien', 'Martin', 'Lyon', 35),
('David', 'Bernard', 'Marseille', 40),
('Marie', 'Leroy', 'Grenoble', 45),
('Julien', 'Dupont', 'Paris', 50),
('Paul', 'Durand', 'Nantes', 55),
('Mac??o', 'Martin', 'Lyon', 60),
('Maxime', 'Bernard', 'Marseille', 65),
('Tom', 'Leroy', 'Grenoble', 70);
-- afficher l'age moyen des personnes (avg)
SELECT AVG(age) AS 'Age moyen' FROM client;
-- afficher l'age maximum des personnes (max)
SELECT MAX(age) AS 'Age maximum' FROM client;
-- afficher l'age minimum des personnes (min)
SELECT MIN(age) AS 'Age minimum' FROM client;
-- afficher le nombre de personne (count)
SELECT COUNT(*) AS 'Nombre de personne' FROM client;
-- afficher le nombre de personnes par ville (count)
SELECT ville, COUNT(*) AS 'Nombre de personne' FROM client GROUP BY ville;
-- afficher le nombre de personnes par ville et par age (count)
SELECT ville, age, COUNT(*) AS 'Nombre de personne' FROM client GROUP BY ville, age;
-- afficher le nombre de personnes par ville et par age (count) et trier par ville et age
SELECT ville, age, COUNT(*) AS 'Nombre de personne' FROM client GROUP BY ville, age ORDER BY ville, age;
-- afficher le nombre de personne par ville et par age (count) et trier par ville et age et afficher uniquement les personnes qui ont plus de 50 ans
SELECT ville, age, COUNT(*) AS 'Nombre de personne' FROM client WHERE age > 50 GROUP BY ville, age ORDER BY ville, age;

DROP TABLE IF EXISTS personne;
CREATE TABLE IF NOT EXISTS personne (
    id_personne INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    nom VARCHAR(25) NOT NULL,
    prenom VARCHAR(25) NOT NULL,
    age INT NOT NULL
);
INSERT INTO personne (nom, prenom, age)
VALUES
('Dupont', 'Jean', 55),
('DUCHEMIN', 'Rob', 48),
('DUPUIS', 'Nadia', 36),
('ROVIER', 'Monique', 63),
('DUPUIS', 'Olivier', 33),
('ROLLAND', 'G??rard', 64),
('ROLIN', 'Claire', 42),
('MARTINEAU', 'Jean', 57),
('MARTINET', 'Bob', 45);

SELECT nom, COUNT(*) AS 'Double' FROM personne GROUP BY nom;

SELECT nom, prenom, age,
CASE
    WHEN age < 18 THEN 'Mineur'
    WHEN age >= 18 AND age < 60 THEN 'Majeur'
    WHEN age >= 60 THEN 'Senior'
END AS 'Cat??gorie'
FROM personne
ORDER BY nom, prenom;

SELECT NOW() 'date & heure', DATE(NOW()) 'date', TIME(NOW()) 'heure';

SELECT DATEDIFF(NOW(), '2022-01-01') 'Nombre de jours depuis le 1er janvier 2019';

-- Sous Requ??tes SQL
SELECT AVG(age) AS 'Age moyen' FROM personne;

SELECT nom, prenom FROM personne WHERE age > (SELECT AVG(age) FROM personne);
SELECT nom, prenom FROM personne JOIN langue ON personne.id_personne = langue.id_personne WHERE langue.nom = 'Fran??ais';
SELECT COUNT(*) FROM langue GROUP BY libele TOP 1;

SELECT nom, prenom 
FROM personne
JOIN langue ON personne.id_langue = langue.id
WHERE libelle = (
    SELECT libelle
    FROM personne
    JOIN langue ON personne.id_langue = langue.id
    GROUP BY libelle
    ORDER BY COUNT(*) DESC
    LIMIT 1
);
--La clause FROM d??finit les tables sur lesquelles la requ??te va agir, tandis que la clause JOIN permet de lier les tables personne et langue en utilisant l'identifiant de langue dans la table personne (id_langue) et l'identifiant de langue dans la table langue (id).

-- La clause WHERE utilise une sous-requ??te pour d??terminer la langue la plus parl??e. La sous-requ??te utilise la clause GROUP BY pour regrouper les lignes de la table langue par libell?? de langue, et la fonction COUNT pour compter le nombre de lignes dans chaque groupe.

--La clause ORDER BY permet de trier les r??sultats par ordre d??croissant de nombre de lignes, et la clause LIMIT 1 permet de ne retenir que la premi??re ligne (c'est-??-dire la langue la plus parl??e).

--La clause SELECT indique les colonnes que vous souhaitez obtenir dans les r??sultats de la requ??te. Dans ce cas, nous s??lectionnons le nom et le pr??nom de la personne (nom et prenom).

SELECT *
FROM personne
WHERE EXISTS (SELECT *
            FROM personne
            WHERE age >= 62);

-- La clause FROM d??finit la table sur laquelle la requ??te va agir. La clause WHERE utilise la fonction EXISTS pour v??rifier si il existe au moins une ligne dans la sous-requ??te qui satisfait la condition age >= 62. Si c'est le cas, la requ??te retourne toutes les lignes de la table personne.

-- La clause SELECT indique les colonnes que vous souhaitez obtenir dans les r??sultats de la requ??te. Dans ce cas, nous utilisons l'op??rateur * pour s??lectionner toutes les colonnes de la table personne.

SELECT nom, prenom
FROM personne AS p1
WHERE EXISTS (SELECT 1
            FROM personne AS p2
            WHERE p2.nom = p1.nom AND p2.prenom <> p1.prenom)

-- La clause FROM d??finit la table sur laquelle la requ??te va agir. La clause WHERE utilise la fonction EXISTS et une sous-requ??te corr??l??e pour v??rifier si il existe au moins une ligne dans la sous-requ??te qui a le m??me nom que la ligne courante de la requ??te principale (c'est-??-dire celles qui satisfont la condition p2.nom = p.nom) et un pr??nom diff??rent (c'est-??-dire celles qui satisfont la condition p2.prenom <> p.prenom).

DROP PROCEDURE IF EXISTS creation_personne;
DELIMITER //
CREATE PROCEDURE creation_personne()
BEGIN
    INSERT INTO personne (nom, prenom, age)
    VALUES
    ('MARTIN', 'Jeanine', 64);
END //
DELIMITER ;

-- La commande CREATE PROCEDURE permet de cr??er une proc??dure stock??e en sp??cifiant son nom (creation_personne) et les param??tres qu'elle accepte (ici, aucun). Le corps de la proc??dure est d??fini entre les d??clarations BEGIN et END.

-- Vous pouvez ensuite ajouter les instructions SQL que vous souhaitez ex??cuter dans le corps de la proc??dure. Dans cet exemple, nous ajoutons une instruction INSERT INTO pour ins??rer une nouvelle ligne dans la table personne.

-- Pour lancer la proc??dure, vous devez utiliser la commande CALL suivi du nom de la proc??dure.
CALL creation_personne();

DROP PROCEDURE IF EXISTS creation_personne;
DELIMITER //
CREATE PROCEDURE creation_personne(
    IN nom VARCHAR(50),
    IN prenom VARCHAR(50),
    IN age INT)
BEGIN
    INSERT INTO personne (nom, prenom, age)
    VALUES
    (nom, prenom, age);
END //
DELIMITER ;

CALL creation_personne('DUPONT', 'Jean', 45);

-- La commande CREATE PROCEDURE permet de cr??er une proc??dure stock??e en sp??cifiant son nom (creation_personne) et les param??tres qu'elle accepte (ici, nom, prenom et age). Le corps de la proc??dure est d??fini entre les d??clarations BEGIN et END.

-- Vous pouvez ensuite ajouter les instructions SQL que vous souhaitez ex??cuter dans le corps de la proc??dure. Dans cet exemple, nous ajoutons une instruction INSERT INTO pour ins??rer une nouvelle ligne dans la table personne.

-- Pour lancer la proc??dure, vous devez utiliser la commande CALL suivi du nom de la proc??dure et des valeurs des param??tres.

CREATE FUNCTION fonction_cube(valeur_entree INT)
RETURNS BIGINT RETURN valeur_entree * valeur_entree * valeur_entree;

-- La commande CREATE FUNCTION permet de cr??er une fonction en sp??cifiant son nom (fonction_cube) et les param??tres qu'elle accepte (ici, valeur_entree). Le corps de la fonction est d??fini entre les d??clarations BEGIN et END.

-- Pour lancer la fonction, vous devez utiliser la commande SELECT suivi du nom de la fonction et des valeurs des param??tres.
SELECT fonction_cube(3);

