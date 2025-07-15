# Script pour créer automatiquement les Pull Requests avec GitHub CLI
# Ce script crée 8 pull requests organisées étape par étape

Write-Host "=== Création automatique des Pull Requests avec GitHub CLI ===" -ForegroundColor Green

# Vérifier si GitHub CLI est installé
$ghPath = "C:\Program Files\GitHub CLI\gh.exe"
if (Test-Path $ghPath) {
    Write-Host "GitHub CLI trouvé à l'emplacement standard" -ForegroundColor Green
} elseif (Get-Command gh -ErrorAction SilentlyContinue) {
    $ghPath = "gh"
    Write-Host "GitHub CLI trouvé dans le PATH" -ForegroundColor Green
} else {
    Write-Host "GitHub CLI n'est pas installé." -ForegroundColor Red
    Write-Host "Installez GitHub CLI ou utilisez le fichier LISTE_PULL_REQUESTS.md" -ForegroundColor Yellow
    exit 1
}

try {
    $ghVersion = & $ghPath --version
    Write-Host "GitHub CLI détecté: $($ghVersion[0])" -ForegroundColor Green
} catch {
    Write-Host "Erreur lors de l'exécution de GitHub CLI" -ForegroundColor Red
    exit 1
}

# Vérifier l'authentification
try {
    $authStatus = & $ghPath auth status 2>&1
    if ($authStatus -match "Logged in") {
        Write-Host "Authentifié sur GitHub" -ForegroundColor Green
    } else {
        Write-Host "Non authentifié. Exécutez: gh auth login" -ForegroundColor Red
        exit 1
    }
} catch {
    Write-Host "Erreur d'authentification. Exécutez: gh auth login" -ForegroundColor Red
    exit 1
}

Write-Host "Création des Pull Requests..." -ForegroundColor Cyan

# Fonction pour créer une pull request
function Create-PullRequest {
    param(
        [string]$branch,
        [string]$title,
        [string]$body
    )
    
    try {
        # Créer un fichier temporaire pour le body
        $tempFile = [System.IO.Path]::GetTempFileName()
        $body | Out-File -FilePath $tempFile -Encoding UTF8
        
        # Créer la PR avec GitHub CLI
        $result = & $ghPath pr create --head $branch --base main --title $title --body-file $tempFile 2>&1
        
        # Nettoyer le fichier temporaire
        Remove-Item $tempFile -Force
        
        if ($result -match "https://github.com") {
            Write-Host "PR créée: $title" -ForegroundColor Green
            Write-Host "Lien: $result" -ForegroundColor Blue
            return $true
        } else {
            Write-Host "Erreur lors de la création de la PR pour $branch" -ForegroundColor Red
            Write-Host "Détails: $result" -ForegroundColor Yellow
            return $false
        }
    } catch {
        Write-Host "Erreur lors de la création de la PR pour $branch : $($_.Exception.Message)" -ForegroundColor Red
        return $false
    }
}

$successCount = 0

# PR 1: Configuration initiale
$body1 = @"
Description: Configuration initiale du projet Bibliothèque avec Spring Boot.

Changements apportés:
- Configuration Maven avec Spring Boot 3.3.3
- Support JSP et JSTL pour les vues
- Configuration base de données MySQL
- Structure de projet Spring Boot standard
- Scripts Maven wrapper pour le build

Tests:
- Compilation du projet
- Configuration des dépendances
- Structure des packages

Notes: Première étape du développement - mise en place de l'architecture de base.
"@

if (Create-PullRequest -branch "feature/initial-setup" -title "feat: Configuration initiale du projet Spring Boot" -body $body1) { $successCount++ }

# PR 2: Modèle de données
$body2 = @"
Description: Implémentation complète du modèle de données avec les entités JPA.

Changements apportés:
- Entité Livre (titre, auteur, genre, année, âge minimum)
- Entité Adherent avec gestion des profils
- Entité Admin pour l'administration
- Entité Pret pour la gestion des emprunts
- Entité Reservation pour les réservations
- Entité Exemplaire pour les copies physiques
- Entités Emplacement et Statut
- Relations JPA entre toutes les entités

Tests:
- Validation des annotations JPA
- Relations entre entités
- Contraintes de base de données

Notes: Modèle de données complet pour un système de bibliothèque moderne.
"@

if (Create-PullRequest -branch "feature/data-model" -title "feat: Implémentation du modèle de données" -body $body2) { $successCount++ }

# PR 3: Couche Repository
$body3 = @"
Description: Implémentation de la couche d'accès aux données avec Spring Data JPA.

Changements apportés:
- Repository pour toutes les entités principales
- Extension de JpaRepository pour les opérations CRUD
- Méthodes de recherche personnalisées
- Support des requêtes complexes
- Optimisation des performances avec les requêtes

Tests:
- Opérations CRUD de base
- Requêtes personnalisées
- Performance des requêtes

Notes: Couche d'accès aux données robuste et performante.
"@

if (Create-PullRequest -branch "feature/repositories" -title "feat: Implémentation de la couche Repository" -body $body3) { $successCount++ }

# PR 4: Services et DTOs
$body4 = @"
Description: Implémentation de la logique métier et des objets de transfert de données.

Changements apportés:
- DTOs pour toutes les entités principales
- Services métier pour Adherent, Livre, Pret
- Logique de gestion des réservations
- Services de prolongement et abonnement
- Couche d'abstraction entre contrôleurs et repositories
- Validation des données métier

Tests:
- Logique métier des services
- Validation des DTOs
- Gestion des exceptions

Notes: Couche métier complète avec toute la logique de gestion de bibliothèque.
"@

if (Create-PullRequest -branch "feature/services-dto" -title "feat: Implémentation des Services et DTOs" -body $body4) { $successCount++ }

# PR 5: Contrôleurs Web
$body5 = @"
Description: Implémentation des contrôleurs Web pour l'interface utilisateur et l'API.

Changements apportés:
- Contrôleurs pour la gestion des adhérents
- Contrôleurs pour la gestion des livres
- Système d'authentification (Admin/Adherent)
- Gestion des prêts et réservations
- Contrôleurs API REST
- Interface d'administration
- Contrôleur Home pour la navigation

Tests:
- Endpoints Web
- API REST
- Authentification
- Gestion des sessions

Notes: Interface Web complète avec API REST pour toutes les fonctionnalités.
"@

if (Create-PullRequest -branch "feature/web-controllers" -title "feat: Implémentation des contrôleurs Web" -body $body5) { $successCount++ }

# PR 6: Interface utilisateur
$body6 = @"
Description: Implémentation de l'interface utilisateur avec JSP et Bootstrap.

Changements apportés:
- Pages JSP pour toutes les fonctionnalités
- Interface responsive avec Bootstrap
- Formulaires de gestion des livres et adhérents
- Pages d'authentification
- Interface d'administration
- Navigation intuitive
- Design moderne et accessible

Tests:
- Affichage des pages
- Formulaires interactifs
- Responsive design
- Navigation

Notes: Interface utilisateur complète et moderne pour le système de bibliothèque.
"@

if (Create-PullRequest -branch "feature/frontend" -title "feat: Implémentation de l'interface utilisateur" -body $body6) { $successCount++ }

# PR 7: Scripts de base de données
$body7 = @"
Description: Scripts SQL pour l'initialisation et la gestion de la base de données.

Changements apportés:
- Script de création des tables
- Données de test et d'exemple
- Scripts de migration
- Procédures stockées pour les opérations complexes
- Index pour l'optimisation des performances
- Scripts de sauvegarde et restauration

Tests:
- Création de la base de données
- Insertion des données de test
- Performance des requêtes
- Intégrité des données

Notes: Scripts complets pour la gestion de la base de données MySQL.
"@

if (Create-PullRequest -branch "feature/database-scripts" -title "feat: Scripts de base de données" -body $body7) { $successCount++ }

# PR 8: Documentation
$body8 = @"
Description: Documentation complète du projet et guide d'utilisation.

Changements apportés:
- README détaillé avec instructions d'installation
- Documentation de l'API REST
- Guide d'utilisation pour les utilisateurs
- Documentation technique pour les développeurs
- Diagrammes de l'architecture
- Guide de déploiement
- FAQ et résolution de problèmes

Tests:
- Validation de la documentation
- Tests des instructions d'installation
- Vérification des exemples de code

Notes: Documentation complète pour faciliter l'utilisation et la maintenance du projet.
"@

if (Create-PullRequest -branch "feature/documentation" -title "docs: Documentation complète du projet" -body $body8) { $successCount++ }

# Résumé
Write-Host "\n=== Résumé de la création des Pull Requests ===" -ForegroundColor Green
Write-Host "Pull Requests créées avec succès: $successCount/8" -ForegroundColor Cyan

if ($successCount -eq 8) {
    Write-Host "Toutes les Pull Requests ont été créées avec succès!" -ForegroundColor Green
    Write-Host "Visitez votre repository GitHub pour les voir." -ForegroundColor Blue
} else {
    Write-Host "Certaines Pull Requests n'ont pas pu être créées." -ForegroundColor Yellow
    Write-Host "Vérifiez que toutes les branches existent sur GitHub." -ForegroundColor Yellow
}

Write-Host "\nScript terminé." -ForegroundColor Green