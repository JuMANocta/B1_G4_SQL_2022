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
('Macéo', 'Martin', 'Lyon'),
('Maxime', 'Bernard', 'Marseille'),
('Tom', 'Leroy', 'Grenoble');

SELECT ville FROM client;-- 10 lignes
SELECT DISTINCT ville FROM client;-- 5 lignes
SELECT ville FROM client GROUP BY ville;-- 5 lignes
-- afficher les nom et prenom des personnes qui habitent à Paris
SELECT nom, prenom FROM client WHERE ville = 'Paris';

-- afficher les nom et prenom des personnes qui habitent à Paris ou à Lyon
SELECT nom, prenom FROM client WHERE ville = 'Paris' OR ville = 'Lyon';
-- afficher le nom et prenom des personnes dont le nom fini par 'd'
SELECT nom, prenom FROM client WHERE nom LIKE '%d';
-- afficher toutes les personnes qui habitent à Paris ou à Lyon ou grenoble
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
('Macéo', 'Martin', 'Lyon', 60),
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
('ROLLAND', 'Gérard', 64),
('ROLIN', 'Claire', 42),
('MARTINEAU', 'Jean', 57),
('MARTINET', 'Bob', 45);

SELECT nom, COUNT(*) AS 'Double' FROM personne GROUP BY nom;

SELECT nom, prenom, age,
CASE
    WHEN age < 18 THEN 'Mineur'
    WHEN age >= 18 AND age < 60 THEN 'Majeur'
    WHEN age >= 60 THEN 'Senior'
END AS 'Catégorie'
FROM personne
ORDER BY nom, prenom;

SELECT NOW() 'date & heure', DATE(NOW()) 'date', TIME(NOW()) 'heure';

SELECT DATEDIFF(NOW(), '2022-01-01') 'Nombre de jours depuis le 1er janvier 2019';

-- Sous Requêtes SQL
SELECT AVG(age) AS 'Age moyen' FROM personne;

SELECT nom, prenom FROM personne WHERE age > (SELECT AVG(age) FROM personne);
SELECT nom, prenom FROM personne JOIN langue ON personne.id_personne = langue.id_personne WHERE langue.nom = 'Français';
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
--La clause FROM définit les tables sur lesquelles la requête va agir, tandis que la clause JOIN permet de lier les tables personne et langue en utilisant l'identifiant de langue dans la table personne (id_langue) et l'identifiant de langue dans la table langue (id).

-- La clause WHERE utilise une sous-requête pour déterminer la langue la plus parlée. La sous-requête utilise la clause GROUP BY pour regrouper les lignes de la table langue par libellé de langue, et la fonction COUNT pour compter le nombre de lignes dans chaque groupe.

--La clause ORDER BY permet de trier les résultats par ordre décroissant de nombre de lignes, et la clause LIMIT 1 permet de ne retenir que la première ligne (c'est-à-dire la langue la plus parlée).

--La clause SELECT indique les colonnes que vous souhaitez obtenir dans les résultats de la requête. Dans ce cas, nous sélectionnons le nom et le prénom de la personne (nom et prenom).

SELECT *
FROM personne
WHERE EXISTS (SELECT *
            FROM personne
            WHERE age >= 62);

-- La clause FROM définit la table sur laquelle la requête va agir. La clause WHERE utilise la fonction EXISTS pour vérifier si il existe au moins une ligne dans la sous-requête qui satisfait la condition age >= 62. Si c'est le cas, la requête retourne toutes les lignes de la table personne.

-- La clause SELECT indique les colonnes que vous souhaitez obtenir dans les résultats de la requête. Dans ce cas, nous utilisons l'opérateur * pour sélectionner toutes les colonnes de la table personne.

SELECT nom, prenom
FROM personne AS p1
WHERE EXISTS (SELECT 1
            FROM personne AS p2
            WHERE p2.nom = p1.nom AND p2.prenom <> p1.prenom)

-- La clause FROM définit la table sur laquelle la requête va agir. La clause WHERE utilise la fonction EXISTS et une sous-requête corrélée pour vérifier si il existe au moins une ligne dans la sous-requête qui a le même nom que la ligne courante de la requête principale (c'est-à-dire celles qui satisfont la condition p2.nom = p.nom) et un prénom différent (c'est-à-dire celles qui satisfont la condition p2.prenom <> p.prenom).

DROP PROCEDURE IF EXISTS creation_personne;
DELIMITER //
CREATE PROCEDURE creation_personne()
BEGIN
    INSERT INTO personne (nom, prenom, age)
    VALUES
    ('MARTIN', 'Jeanine', 64);
END //
DELIMITER ;

-- La commande CREATE PROCEDURE permet de créer une procédure stockée en spécifiant son nom (creation_personne) et les paramètres qu'elle accepte (ici, aucun). Le corps de la procédure est défini entre les déclarations BEGIN et END.

-- Vous pouvez ensuite ajouter les instructions SQL que vous souhaitez exécuter dans le corps de la procédure. Dans cet exemple, nous ajoutons une instruction INSERT INTO pour insérer une nouvelle ligne dans la table personne.

-- Pour lancer la procédure, vous devez utiliser la commande CALL suivi du nom de la procédure.
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