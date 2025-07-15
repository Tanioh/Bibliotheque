-- Admin
INSERT INTO Admin (nom_utilisateur, mot_de_passe) VALUES ('admin1', '1');
INSERT INTO Admin (nom_utilisateur, mot_de_passe) VALUES ('admin2', '2');

-- Profil
INSERT INTO Profil (nom_profil, quota_max_pret, quota_max_reservation) VALUES ('Etudiant', 3, 2);
INSERT INTO Profil (nom_profil, quota_max_pret, quota_max_reservation) VALUES ('Professeur', 5, 3);
INSERT INTO Profil (nom_profil, quota_max_pret, quota_max_reservation) VALUES ('Anonyme', 0, 0);

-- Adherent
INSERT INTO Adherent (nom, prenom, age, numero, email, id_profil) VALUES ('Jean', 'Paul', 22, '0321000001', 'jean.paul@mail.com', 1);
INSERT INTO Adherent (nom, prenom, age, numero, email, id_profil) VALUES ('Marie', 'Claire', 28, '0321000002', 'marie.claire@mail.com', 2);
INSERT INTO Adherent (nom, prenom, age, numero, email, id_profil) VALUES ('Tom', 'Alex', 30, '0321000003', 'tom.alex@mail.com', 1);

-- Jour_Ferie
INSERT INTO Jour_Ferie (date_ferie, description) VALUES ('2025-01-01', 'Nouvel An');
INSERT INTO Jour_Ferie (date_ferie, description) VALUES ('2025-03-29', 'Insurrection');
INSERT INTO Jour_Ferie (date_ferie, description) VALUES ('2025-05-01', 'Travail');

-- Statut
INSERT INTO Statut (libelle) VALUES ('en_cours');
INSERT INTO Statut (libelle) VALUES ('termine');
INSERT INTO Statut (libelle) VALUES ('annule');

-- Livre
INSERT INTO Livre (titre, genre, auteur, annee, age_minimum) VALUES ('Le Petit Prince', 'Conte', 'Antoine de Saint-Exupery', 1943, 7);
INSERT INTO Livre (titre, genre, auteur, annee, age_minimum) VALUES ('1984', 'Dystopie', 'George Orwell', 1949, 16);
INSERT INTO Livre (titre, genre, auteur, annee, age_minimum) VALUES ('L Etranger', 'Roman', 'Albert Camus', 1942, 16);
INSERT INTO Livre (titre, genre, auteur, annee, age_minimum) VALUES ('Harry Potter a l ecole des sorciers', 'Fantasy', 'J K Rowling', 1997, 10);
INSERT INTO Livre (titre, genre, auteur, annee, age_minimum) VALUES ('Les Miserables', 'Roman', 'Victor Hugo', 1862, 14);
INSERT INTO Livre (titre, genre, auteur, annee, age_minimum) VALUES ('Le Seigneur des Anneaux', 'Fantasy', 'J R R Tolkien', 1954, 14);
INSERT INTO Livre (titre, genre, auteur, annee, age_minimum) VALUES ('Le Comte de Monte-Cristo', 'Roman', 'Alexandre Dumas', 1844, 14);
INSERT INTO Livre (titre, genre, auteur, annee, age_minimum) VALUES ('Da Vinci Code', 'Thriller', 'Dan Brown', 2003, 16);
INSERT INTO Livre (titre, genre, auteur, annee, age_minimum) VALUES ('Le Parfum', 'Roman', 'Patrick Suskind', 1985, 16);
INSERT INTO Livre (titre, genre, auteur, annee, age_minimum) VALUES ('Orgueil et Prejuges', 'Roman', 'Jane Austen', 1813, 14);

-- Exemplaire (disponibilite correcte)
INSERT INTO Exemplaire (id_livre, etat, disponible) VALUES (1, 'neuf', FALSE); -- pret 1
INSERT INTO Exemplaire (id_livre, etat, disponible) VALUES (2, 'neuf', FALSE); -- pret 2
INSERT INTO Exemplaire (id_livre, etat, disponible) VALUES (3, 'neuf', FALSE); -- pret 3
INSERT INTO Exemplaire (id_livre, etat, disponible) VALUES (4, 'bon', TRUE);
INSERT INTO Exemplaire (id_livre, etat, disponible) VALUES (5, 'bon', TRUE);
INSERT INTO Exemplaire (id_livre, etat, disponible) VALUES (6, 'neuf', TRUE);
INSERT INTO Exemplaire (id_livre, etat, disponible) VALUES (7, 'neuf', TRUE);
INSERT INTO Exemplaire (id_livre, etat, disponible) VALUES (8, 'bon', TRUE);
INSERT INTO Exemplaire (id_livre, etat, disponible) VALUES (9, 'neuf', TRUE);
INSERT INTO Exemplaire (id_livre, etat, disponible) VALUES (10, 'bon', TRUE);

-- Emplacement
INSERT INTO Emplacement (type_emplacement) VALUES ('Sur place');
INSERT INTO Emplacement (type_emplacement) VALUES ('A emporter');

-- Pret
INSERT INTO Pret (id_adherent, id_exemplaire, date_pret, date_retour_prevue, id_emplacement, id_statut) VALUES (1, 1, '2025-07-01', '2025-07-10', 1, 1);
INSERT INTO Pret (id_adherent, id_exemplaire, date_pret, date_retour_prevue, id_emplacement, id_statut) VALUES (2, 2, '2025-07-02', '2025-07-11', 2, 1);
INSERT INTO Pret (id_adherent, id_exemplaire, date_pret, date_retour_prevue, id_emplacement, id_statut) VALUES (3, 3, '2025-07-03', '2025-07-12', 1, 1);

-- Prolongement
INSERT INTO Prolongement (id_pret, date_prolongement, nouvelle_date_retour, id_statut) VALUES (1, '2025-07-09', '2025-07-20', 1);

-- Reservation
INSERT INTO Reservation (id_adherent, id_exemplaire, date_reservation, id_statut) VALUES (1, 4, '2025-07-01', 1);
INSERT INTO Reservation (id_adherent, id_exemplaire, date_reservation, id_statut) VALUES (2, 5, '2025-07-02', 1);

-- Penalite
INSERT INTO Penalite (id_adherent, raison, date_penalite, date_fin, levee) VALUES (3, 'Retard de retour', '2025-07-15', '2025-07-25', FALSE);

-- Abonnement
INSERT INTO Abonnement (id_adherent, type_abonnement, date_debut, date_fin, prix, statut, auto_renouvellement) VALUES (1, 'Mensuel', '2025-01-01', '2025-12-31', 25.00, 'actif', TRUE);
INSERT INTO Abonnement (id_adherent, type_abonnement, date_debut, date_fin, prix, statut, auto_renouvellement) VALUES (2, 'Annuel', '2025-01-01', '2025-12-31', 200.00, 'actif', FALSE);
INSERT INTO Abonnement (id_adherent, type_abonnement, date_debut, date_fin, prix, statut, auto_renouvellement) VALUES (3, 'Mensuel', '2024-12-01', '2024-12-31', 25.00, 'expire', FALSE);
