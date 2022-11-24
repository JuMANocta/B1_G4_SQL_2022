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