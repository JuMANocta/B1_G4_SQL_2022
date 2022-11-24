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