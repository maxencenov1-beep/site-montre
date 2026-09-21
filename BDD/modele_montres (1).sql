-- =========================================================
-- Modèle relationnel : Catalogue de présentation de montres
-- À importer dans phpMyAdmin (onglet "Importer")
-- =========================================================

CREATE DATABASE IF NOT EXISTS catalogue_montres
  CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE catalogue_montres;

-- ---------------------------------------------------------
-- Table : marques
-- ---------------------------------------------------------
CREATE TABLE marques (
    id_marque      INT AUTO_INCREMENT PRIMARY KEY,
    nom            VARCHAR(100) NOT NULL,
    pays_origine   VARCHAR(100),
    annee_creation YEAR
) ENGINE=InnoDB;

-- ---------------------------------------------------------
-- Table : categories
-- ---------------------------------------------------------
CREATE TABLE categories (
    id_categorie   INT AUTO_INCREMENT PRIMARY KEY,
    nom            VARCHAR(50) NOT NULL   -- ex: Sport, Luxe, Casual, Plongée
) ENGINE=InnoDB;

-- ---------------------------------------------------------
-- Table : mouvements
-- ---------------------------------------------------------
CREATE TABLE mouvements (
    id_mouvement   INT AUTO_INCREMENT PRIMARY KEY,
    type           VARCHAR(50) NOT NULL   -- ex: Quartz, Automatique, Mécanique
) ENGINE=InnoDB;

-- ---------------------------------------------------------
-- Table : montres
-- ---------------------------------------------------------
CREATE TABLE montres (
    id_montre         INT AUTO_INCREMENT PRIMARY KEY,
    reference          VARCHAR(50) UNIQUE NOT NULL,
    nom                VARCHAR(150) NOT NULL,
    id_marque          INT NOT NULL,
    id_categorie       INT,
    id_mouvement       INT,
    prix               DECIMAL(10,2),
    description        TEXT,
    matiere_boitier    VARCHAR(100),
    matiere_bracelet   VARCHAR(100),
    couleur_cadran     VARCHAR(50),
    diametre_mm        DECIMAL(5,2),
    etancheite_m       INT,
    image_url          VARCHAR(255),
    date_ajout         DATE DEFAULT (CURRENT_DATE),
    FOREIGN KEY (id_marque) REFERENCES marques(id_marque)
        ON DELETE CASCADE,
    FOREIGN KEY (id_categorie) REFERENCES categories(id_categorie)
        ON DELETE SET NULL,
    FOREIGN KEY (id_mouvement) REFERENCES mouvements(id_mouvement)
        ON DELETE SET NULL
) ENGINE=InnoDB;

-- =========================================================
-- Données d'exemple (facultatif)
-- =========================================================
INSERT INTO marques (nom, pays_origine, annee_creation) VALUES
('Rolex', 'Suisse', 1905),
('Seiko', 'Japon', 1881),
('Omega', 'Suisse', 1848);

INSERT INTO categories (nom) VALUES
('Luxe'), ('Sport'), ('Plongée'), ('Casual');

INSERT INTO mouvements (type) VALUES
('Quartz'), ('Automatique'), ('Mécanique');

INSERT INTO montres
(reference, nom, id_marque, id_categorie, id_mouvement, prix, description, matiere_boitier, matiere_bracelet, couleur_cadran, diametre_mm, etancheite_m)
VALUES
('RLX-001', 'Submariner Date', 1, 3, 2, 9500.00, 'Montre de plongée iconique.', 'Acier inoxydable', 'Acier', 'Noir', 41.00, 300),
('SKO-002', 'Prospex Diver', 2, 3, 2, 350.00, 'Montre de plongée abordable et robuste.', 'Acier', 'Silicone', 'Bleu', 42.50, 200),
('OMG-003', 'Speedmaster Professional', 3, 1, 3, 6200.00, 'Chronographe légendaire.', 'Acier', 'Cuir', 'Noir', 42.00, 50);
