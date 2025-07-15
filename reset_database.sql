-- Script de réinitialisation complète de la base de données
-- Ce script supprime toutes les données de toutes les tables
-- ATTENTION: Cette opération est irréversible!
-- Usage: USE votre_base_de_donnees; puis coller ce script

-- Désactiver les contraintes de clés étrangères temporairement
SET FOREIGN_KEY_CHECKS = 0;

-- Supprimer les données dans l'ordre inverse des dépendances
-- (les tables dépendantes en premier)

-- 1. Supprimer les prolongements (dépendent des prêts)
DELETE FROM prolongement;
ALTER TABLE prolongement AUTO_INCREMENT = 1;

-- 2. Supprimer les prêts (dépendent des adhérents et des livres)
DELETE FROM pret;
ALTER TABLE pret AUTO_INCREMENT = 1;

-- 3. Supprimer les abonnements (dépendent des adhérents)
DELETE FROM abonnement;
ALTER TABLE abonnement AUTO_INCREMENT = 1;

-- 4. Supprimer les pénalités (dépendent des adhérents)
DELETE FROM penalite;
ALTER TABLE penalite AUTO_INCREMENT = 1;

-- 5. Supprimer les adhérents (dépendent des profils)
DELETE FROM adherent;
ALTER TABLE adherent AUTO_INCREMENT = 1;

-- 6. Supprimer les livres (dépendent des catégories)
DELETE FROM livre;
ALTER TABLE livre AUTO_INCREMENT = 1;

-- 7. Supprimer les profils (table indépendante)
DELETE FROM profil;
ALTER TABLE profil AUTO_INCREMENT = 1;

-- 8. Supprimer les catégories (table indépendante)
DELETE FROM categorie;
ALTER TABLE categorie AUTO_INCREMENT = 1;

-- Réactiver les contraintes de clés étrangères
SET FOREIGN_KEY_CHECKS = 1;

-- Afficher un message de confirmation
SELECT 'Base de données réinitialisée avec succès!' AS message;

-- Vérifier que toutes les tables sont vides
SELECT 
    'adherent' AS table_name, COUNT(*) AS nombre_lignes FROM adherent
UNION ALL
SELECT 
    'livre' AS table_name, COUNT(*) AS nombre_lignes FROM livre
UNION ALL
SELECT 
    'pret' AS table_name, COUNT(*) AS nombre_lignes FROM pret
UNION ALL
SELECT 
    'prolongement' AS table_name, COUNT(*) AS nombre_lignes FROM prolongement
UNION ALL
SELECT 
    'abonnement' AS table_name, COUNT(*) AS nombre_lignes FROM abonnement
UNION ALL
SELECT 
    'penalite' AS table_name, COUNT(*) AS nombre_lignes FROM penalite
UNION ALL
SELECT 
    'profil' AS table_name, COUNT(*) AS nombre_lignes FROM profil
UNION ALL
SELECT 
    'categorie' AS table_name, COUNT(*) AS nombre_lignes FROM categorie;