# Script de déploiement avec Pull Requests pour le projet Bibliothèque
# Ce script simule un développement étape par étape avec des commits et branches séparées

Write-Host "=== Déploiement du projet Bibliothèque avec Pull Requests ==="

# Configuration Git
git config user.name "Tanioh"
git config user.email "tanioh@example.com"

# Initialisation du repository si nécessaire
if (!(Test-Path ".git")) {
    git init
    Write-Host "Repository Git initialisé"
}

# Ajout du remote origin
try {
    git remote add origin https://github.com/Tanioh/Bibliotheque.git
} catch {
    Write-Host "Remote origin déjà configuré"
}

# Création du commit initial sur main
Write-Host "\n=== Création du commit initial ==="
git add .
git commit -m "Initial commit: Projet Bibliothèque complet"
git branch -M main

# PR 1: Configuration initiale du projet
Write-Host "\n=== PR 1: Configuration initiale du projet ==="
git checkout -b feature/initial-setup
git reset --soft HEAD~1
git reset HEAD .
git add pom.xml
git add .gitignore
git add .mvn/
git add mvnw*
git add src/main/java/com/example/biblio/BiblioApplication.java
git add src/main/java/com/example/biblio/ServletInitializer.java
git add src/main/resources/application.properties
git commit -m "feat: Configuration initiale du projet Spring Boot

- Configuration Maven avec Spring Boot 3.3.3
- Support JSP et JSTL
- Configuration base de données MySQL
- Structure de projet Spring Boot standard"
git checkout main
git merge feature/initial-setup --no-ff -m "Merge pull request #1: Configuration initiale du projet"

# PR 2: Modèle de données (Entités)
Write-Host "\n=== PR 2: Modèle de données ==="
git checkout -b feature/data-model
git add src/main/java/com/example/biblio/model/entity/
git add src/main/java/com/example/biblio/entity/
git commit -m "feat: Implémentation du modèle de données

- Entité Livre avec attributs titre, auteur, genre, année
- Entité Adherent avec gestion des profils
- Entité Admin pour l'administration
- Entités Pret, Reservation, Exemplaire
- Relations JPA entre les entités
- Support des emplacements et statuts"
git checkout main
git merge feature/data-model --no-ff -m "Merge pull request #2: Modèle de données"

# PR 3: Couche Repository
Write-Host "\n=== PR 3: Couche Repository ==="
git checkout -b feature/repositories
git add src/main/java/com/example/biblio/repository/
git commit -m "feat: Implémentation de la couche Repository

- Repository pour toutes les entités principales
- Extension de JpaRepository pour les opérations CRUD
- Méthodes de recherche personnalisées
- Support des requêtes complexes"
git checkout main
git merge feature/repositories --no-ff -m "Merge pull request #3: Couche Repository"

# PR 4: DTOs et Services
Write-Host "\n=== PR 4: DTOs et Services ==="
git checkout -b feature/services-dto
git add src/main/java/com/example/biblio/model/dto/
git add src/main/java/com/example/biblio/dto/
git add src/main/java/com/example/biblio/service/
git commit -m "feat: Implémentation des Services et DTOs

- DTOs pour toutes les entités principales
- Services métier pour Adherent, Livre, Pret
- Logique de gestion des réservations
- Services de prolongement et abonnement
- Couche d'abstraction entre contrôleurs et repositories"
git checkout main
git merge feature/services-dto --no-ff -m "Merge pull request #4: Services et DTOs"

# PR 5: Contrôleurs Web
Write-Host "\n=== PR 5: Contrôleurs Web ==="
git checkout -b feature/web-controllers
git add src/main/java/com/example/biblio/controller/
git commit -m "feat: Implémentation des contrôleurs Web

- Contrôleurs pour la gestion des adhérents
- Contrôleurs pour la gestion des livres
- Système d'authentification (Admin/Adherent)
- Gestion des prêts et réservations
- Contrôleurs API REST
- Interface d'administration"
git checkout main
git merge feature/web-controllers --no-ff -m "Merge pull request #5: Contrôleurs Web"

# PR 6: Vues JSP et ressources
Write-Host "\n=== PR 6: Interface utilisateur ==="
git checkout -b feature/frontend
git add src/main/resources/templates/
git add src/main/resources/static/
git commit -m "feat: Implémentation de l'interface utilisateur

- Pages JSP pour la gestion des adhérents
- Formulaires de création et modification
- Listes et détails des entités
- Interface responsive
- Ressources statiques (CSS, JS)"
git checkout main
git merge feature/frontend --no-ff -m "Merge pull request #6: Interface utilisateur"

# PR 7: Scripts de base de données
Write-Host "\n=== PR 7: Scripts de base de données ==="
git checkout -b feature/database-scripts
git add src/main/resources/script.sql
git add src/main/resources/donne.sql
git add reset_database.sql
git add fix_adherent_profils.sql
git commit -m "feat: Scripts de base de données

- Script de création des tables
- Données de test et d'initialisation
- Scripts de maintenance et réparation
- Procédures de reset de la base"
git checkout main
git merge feature/database-scripts --no-ff -m "Merge pull request #7: Scripts de base de données"

# PR 8: Documentation et configuration finale
Write-Host "\n=== PR 8: Documentation et finalisation ==="
git checkout -b feature/documentation
git add README_RESET_DATABASE.md
git add GUIDE_RESOLUTION_QUOTA.md
git add -f HELP.md
git add "[Help"
git add aleas3.txt
git add -f .vscode/
git commit -m "docs: Documentation et configuration finale

- Guide de résolution des problèmes
- Documentation de reset de base de données
- Configuration VS Code
- Fichiers d'aide et de support
- Notes de développement"
git checkout main
git merge feature/documentation --no-ff -m "Merge pull request #8: Documentation et finalisation"

# Push vers GitHub
Write-Host "\n=== Push vers GitHub ==="
git push -u origin main

# Push de toutes les branches
$branches = @(
    "feature/initial-setup",
    "feature/data-model", 
    "feature/repositories",
    "feature/services-dto",
    "feature/web-controllers",
    "feature/frontend",
    "feature/database-scripts",
    "feature/documentation"
)

foreach ($branch in $branches) {
    git push origin $branch
}

Write-Host "\n=== Déploiement terminé ==="
Write-Host "Le projet a été déployé avec 8 pull requests simulées:"
Write-Host "1. Configuration initiale du projet"
Write-Host "2. Modèle de données (Entités)"
Write-Host "3. Couche Repository"
Write-Host "4. DTOs et Services"
Write-Host "5. Contrôleurs Web"
Write-Host "6. Interface utilisateur"
Write-Host "7. Scripts de base de données"
Write-Host "8. Documentation et finalisation"
Write-Host "\nRepository: https://github.com/Tanioh/Bibliotheque"