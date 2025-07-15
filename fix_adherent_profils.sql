-- Script pour corriger les adhérents avec le profil 'Anonyme'
-- Ce script met à jour tous les adhérents ayant le profil 'Anonyme' (quota 0) vers le profil 'Etudiant' (quota 3)

UPDATE Adherent 
SET id_profil = (SELECT id_profil FROM Profil WHERE nom_profil = 'Etudiant')
WHERE id_profil = (SELECT id_profil FROM Profil WHERE nom_profil = 'Anonyme');

-- Vérification : afficher tous les adhérents avec leurs profils
SELECT 
    a.id_adherent,
    a.nom,
    a.prenom,
    a.email,
    p.nom_profil,
    p.quota_max_pret
FROM Adherent a
LEFT JOIN Profil p ON a.id_profil = p.id_profil
ORDER BY a.id_adherent;