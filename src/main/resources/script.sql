-- ========================================
-- SCRIPT DE CRÉATION DE LA BASE DE DONNÉES BIBLIOTHÈQUE
-- ========================================
-- Instructions pour exécuter dans MySQL :
-- 1. Ouvrir phpMyAdmin ou MySQL Workbench
-- 2. Se connecter à MySQL
-- 3. Copier-coller ce script complet
-- ========================================

-- Création de la base de données (si elle n'existe pas)
CREATE DATABASE IF NOT EXISTS bibliotheque;

-- Utiliser la base de données
USE bibliotheque;

-- Vérifier la connexion
SELECT DATABASE() as current_database;

-- ========================================
-- CRÉATION DES TABLES
-- ========================================

-- Table des administrateurs
CREATE TABLE IF NOT EXISTS Admin (
    id_admin INT AUTO_INCREMENT PRIMARY KEY,
    nom_utilisateur VARCHAR(100) UNIQUE NOT NULL,
    mot_de_passe VARCHAR(255) NOT NULL
);

-- Table des profils
CREATE TABLE IF NOT EXISTS Profil (
    id_profil INT AUTO_INCREMENT PRIMARY KEY,
    nom_profil VARCHAR(50) NOT NULL UNIQUE,
    quota_max_pret INT NOT NULL,
    quota_max_reservation INT NOT NULL
);

-- Table des adhérents
CREATE TABLE IF NOT EXISTS Adherent (
    id_adherent INT AUTO_INCREMENT PRIMARY KEY,
    nom VARCHAR(100) NOT NULL,
    prenom VARCHAR(100) NOT NULL,
    age INT NOT NULL,
    numero VARCHAR(20),
    email VARCHAR(100) UNIQUE NOT NULL,
    statut VARCHAR(20) DEFAULT 'actif',
    id_profil INT,
    FOREIGN KEY (id_profil) REFERENCES Profil(id_profil)
);

-- Table des jours fériés
CREATE TABLE IF NOT EXISTS Jour_Ferie (
    id_jour INT AUTO_INCREMENT PRIMARY KEY,
    date_ferie DATE UNIQUE NOT NULL,
    description VARCHAR(100)
);

-- Table des statuts
CREATE TABLE IF NOT EXISTS Statut (
    id_statut INT AUTO_INCREMENT PRIMARY KEY,
    libelle VARCHAR(20) NOT NULL UNIQUE
);

-- Table des livres
CREATE TABLE IF NOT EXISTS Livre (
    id_livre INT AUTO_INCREMENT PRIMARY KEY,
    titre VARCHAR(255) NOT NULL,
    genre VARCHAR(100),
    auteur VARCHAR(100),
    annee INT,
    age_minimum INT
);

-- Table des exemplaires physiques
CREATE TABLE IF NOT EXISTS Exemplaire (
    id_exemplaire INT AUTO_INCREMENT PRIMARY KEY,
    id_livre INT,
    etat VARCHAR(50),
    disponible BOOLEAN,
    FOREIGN KEY (id_livre) REFERENCES Livre(id_livre)
);

-- Table des emplacements de prêt
CREATE TABLE IF NOT EXISTS Emplacement (
    id_emplacement INT AUTO_INCREMENT PRIMARY KEY,
    type_emplacement VARCHAR(20) NOT NULL UNIQUE
);

-- Table des prêts
CREATE TABLE IF NOT EXISTS Pret (
    id_pret INT AUTO_INCREMENT PRIMARY KEY,
    id_adherent INT,
    id_exemplaire INT,
    date_pret DATE NOT NULL,
    date_retour_prevue DATE NOT NULL,
    id_emplacement INT,
    id_statut INT,
    FOREIGN KEY (id_adherent) REFERENCES Adherent(id_adherent),
    FOREIGN KEY (id_exemplaire) REFERENCES Exemplaire(id_exemplaire),
    FOREIGN KEY (id_emplacement) REFERENCES Emplacement(id_emplacement),
    FOREIGN KEY (id_statut) REFERENCES Statut(id_statut)
);

-- Table des prolongements de prêt
CREATE TABLE IF NOT EXISTS Prolongement (
    id_prolongement INT AUTO_INCREMENT PRIMARY KEY,
    id_pret INT,
    date_prolongement DATE NOT NULL,
    nouvelle_date_retour DATE NOT NULL,
    id_statut INT,
    FOREIGN KEY (id_pret) REFERENCES Pret(id_pret),
    FOREIGN KEY (id_statut) REFERENCES Statut(id_statut)
);

-- Table des réservations
CREATE TABLE IF NOT EXISTS Reservation (
    id_reservation INT AUTO_INCREMENT PRIMARY KEY,
    id_adherent INT,
    id_exemplaire INT,
    date_reservation DATE NOT NULL,
    id_statut INT,
    FOREIGN KEY (id_adherent) REFERENCES Adherent(id_adherent),
    FOREIGN KEY (id_exemplaire) REFERENCES Exemplaire(id_exemplaire),
    FOREIGN KEY (id_statut) REFERENCES Statut(id_statut)
);

-- Table des pénalités
CREATE TABLE IF NOT EXISTS Penalite (
    id_penalite INT AUTO_INCREMENT PRIMARY KEY,
    id_adherent INT,
    raison VARCHAR(255) NOT NULL,
    date_penalite DATE NOT NULL,
    date_fin DATE,
    levee BOOLEAN,
    FOREIGN KEY (id_adherent) REFERENCES Adherent(id_adherent)
);

-- Table des abonnements
CREATE TABLE IF NOT EXISTS Abonnement (
    id_abonnement INT AUTO_INCREMENT PRIMARY KEY,
    id_adherent INT NOT NULL,
    type_abonnement VARCHAR(50) NOT NULL,
    date_debut DATE NOT NULL,
    date_fin DATE NOT NULL,
    prix DECIMAL(10,2) NOT NULL,
    statut VARCHAR(20) DEFAULT 'actif',
    auto_renouvellement BOOLEAN DEFAULT FALSE,
    date_creation TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (id_adherent) REFERENCES Adherent(id_adherent),
    INDEX idx_adherent_statut (id_adherent, statut),
    INDEX idx_date_fin (date_fin)
);
