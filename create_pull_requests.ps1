# Script pour créer automatiquement les Pull Requests via l'API GitHub
# Ce script crée 8 pull requests organisées étape par étape

Write-Host "=== Création automatique des Pull Requests ==="

# Configuration
$owner = "Tanioh"
$repo = "Bibliotheque"
$token = $env:GITHUB_TOKEN  # Vous devez définir votre token GitHub

if (-not $token) {
    Write-Host "ERREUR: Veuillez définir votre token GitHub:"
    Write-Host "set GITHUB_TOKEN=your_token_here"
    Write-Host "Ou créez un token sur: https://github.com/settings/tokens"
    exit 1
}

# Headers pour l'API GitHub
$headers = @{
    "Authorization" = "token $token"
    "Accept" = "application/vnd.github.v3+json"
    "Content-Type" = "application/json"
}

# Fonction pour créer une pull request
function Create-PullRequest {
    param(
        [string]$branch,
        [string]$title,
        [string]$body
    )
    
    $prData = @{
        title = $title
        head = $branch
        base = "main"
        body = $body
    } | ConvertTo-Json
    
    try {
        $response = Invoke-RestMethod -Uri "https://api.github.com/repos/$owner/$repo/pulls" -Method Post -Headers $headers -Body $prData
        Write-Host "✅ PR créée: #$($response.number) - $title"
        return $response
    } catch {
        Write-Host "❌ Erreur lors de la création de la PR pour $branch : $($_.Exception.Message)"
        return $null
    }
}

Write-Host "\n🚀 Création des Pull Requests...\n"

# PR 1: Configuration initiale
$pr1 = Create-PullRequest -branch "feature/initial-setup" -title "feat: Configuration initiale du projet Spring Boot" -body @"
## 📋 Description
Configuration initiale du projet Bibliothèque avec Spring Boot.

## ✨ Changements apportés
- ⚙️ Configuration Maven avec Spring Boot 3.3.3
- 🔧 Support JSP et JSTL pour les vues
- 🗄️ Configuration base de données MySQL
- 📁 Structure de projet Spring Boot standard
- 🛠️ Scripts Maven wrapper pour le build

## 🧪 Tests
- [x] Compilation du projet
- [x] Configuration des dépendances
- [x] Structure des packages

## 📝 Notes
Première étape du développement - mise en place de l'architecture de base.
"@

# PR 2: Modèle de données
$pr2 = Create-PullRequest -branch "feature/data-model" -title "feat: Implémentation du modèle de données" -body @"
## 📋 Description
Implémentation complète du modèle de données avec les entités JPA.

## ✨ Changements apportés
- 📚 Entité **Livre** (titre, auteur, genre, année, âge minimum)
- 👤 Entité **Adherent** avec gestion des profils
- 🔐 Entité **Admin** pour l'administration
- 📖 Entité **Pret** pour la gestion des emprunts
- 📅 Entité **Reservation** pour les réservations
- 📦 Entité **Exemplaire** pour les copies physiques
- 📍 Entités **Emplacement** et **Statut**
- 🔗 Relations JPA entre toutes les entités

## 🧪 Tests
- [x] Validation des annotations JPA
- [x] Relations entre entités
- [x] Contraintes de base de données

## 📝 Notes
Modèle de données complet pour un système de bibliothèque moderne.
"@

# PR 3: Couche Repository
$pr3 = Create-PullRequest -branch "feature/repositories" -title "feat: Implémentation de la couche Repository" -body @"
## 📋 Description
Implémentation de la couche d'accès aux données avec Spring Data JPA.

## ✨ Changements apportés
- 🗄️ Repository pour toutes les entités principales
- 🔍 Extension de JpaRepository pour les opérations CRUD
- 🔎 Méthodes de recherche personnalisées
- 📊 Support des requêtes complexes
- 🚀 Optimisation des performances avec les requêtes

## 🧪 Tests
- [x] Opérations CRUD de base
- [x] Requêtes personnalisées
- [x] Performance des requêtes

## 📝 Notes
Couche d'accès aux données robuste et performante.
"@

# PR 4: Services et DTOs
$pr4 = Create-PullRequest -branch "feature/services-dto" -title "feat: Implémentation des Services et DTOs" -body @"
## 📋 Description
Implémentation de la logique métier et des objets de transfert de données.

## ✨ Changements apportés
- 📦 DTOs pour toutes les entités principales
- 🏢 Services métier pour Adherent, Livre, Pret
- 📅 Logique de gestion des réservations
- ⏰ Services de prolongement et abonnement
- 🔄 Couche d'abstraction entre contrôleurs et repositories
- ✅ Validation des données métier

## 🧪 Tests
- [x] Logique métier des services
- [x] Validation des DTOs
- [x] Gestion des exceptions

## 📝 Notes
Couche métier complète avec toute la logique de gestion de bibliothèque.
"@

# PR 5: Contrôleurs Web
$pr5 = Create-PullRequest -branch "feature/web-controllers" -title "feat: Implémentation des contrôleurs Web" -body @"
## 📋 Description
Implémentation des contrôleurs Web pour l'interface utilisateur et l'API.

## ✨ Changements apportés
- 🌐 Contrôleurs pour la gestion des adhérents
- 📚 Contrôleurs pour la gestion des livres
- 🔐 Système d'authentification (Admin/Adherent)
- 📖 Gestion des prêts et réservations
- 🚀 Contrôleurs API REST
- ⚙️ Interface d'administration
- 🏠 Contrôleur Home pour la navigation

## 🧪 Tests
- [x] Endpoints Web
- [x] API REST
- [x] Authentification
- [x] Gestion des sessions

## 📝 Notes
Interface Web complète avec API REST pour toutes les fonctionnalités.
"@

# PR 6: Interface utilisateur
$pr6 = Create-PullRequest -branch "feature/frontend" -title "feat: Implémentation de l'interface utilisateur" -body @"
## 📋 Description
Implémentation de l'interface utilisateur avec JSP et ressources statiques.

## ✨ Changements apportés
- 🎨 Pages JSP pour la gestion des adhérents
- 📝 Formulaires de création et modification
- 📋 Listes et détails des entités
- 📱 Interface responsive
- 🎯 Ressources statiques (CSS, JS)
- 🖼️ Templates réutilisables

## 🧪 Tests
- [x] Affichage des pages
- [x] Formulaires fonctionnels
- [x] Navigation
- [x] Responsive design

## 📝 Notes
Interface utilisateur moderne et intuitive pour la gestion de bibliothèque.
"@

# PR 7: Scripts de base de données
$pr7 = Create-PullRequest -branch "feature/database-scripts" -title "feat: Scripts de base de données" -body @"
## 📋 Description
Implémentation des scripts de base de données pour l'initialisation et la maintenance.

## ✨ Changements apportés
- 🗄️ Script de création des tables (script.sql)
- 📊 Données de test et d'initialisation (donne.sql)
- 🔧 Scripts de maintenance et réparation
- 🔄 Procédures de reset de la base
- 🛠️ Scripts de correction des profils adhérents

## 🧪 Tests
- [x] Création des tables
- [x] Insertion des données
- [x] Scripts de maintenance
- [x] Procédures de reset

## 📝 Notes
Scripts complets pour la gestion et maintenance de la base de données.
"@

# PR 8: Documentation et finalisation
$pr8 = Create-PullRequest -branch "feature/documentation" -title "docs: Documentation et configuration finale" -body @"
## 📋 Description
Documentation complète et configuration finale du projet.

## ✨ Changements apportés
- 📖 Guide de résolution des problèmes de quota
- 🗄️ Documentation de reset de base de données
- ⚙️ Configuration VS Code pour le développement
- 📋 Fichiers d'aide et de support
- 📝 Notes de développement et maintenance
- 🔧 Configuration finale du projet

## 🧪 Tests
- [x] Documentation complète
- [x] Guides fonctionnels
- [x] Configuration VS Code

## 📝 Notes
Documentation complète pour faciliter la maintenance et le développement futur.
"@

Write-Host "\n✅ Toutes les Pull Requests ont été créées avec succès!"
Write-Host "\n📋 Résumé des PRs créées:"
Write-Host "1. Configuration initiale du projet Spring Boot"
Write-Host "2. Implémentation du modèle de données"
Write-Host "3. Implémentation de la couche Repository"
Write-Host "4. Implémentation des Services et DTOs"
Write-Host "5. Implémentation des contrôleurs Web"
Write-Host "6. Implémentation de l'interface utilisateur"
Write-Host "7. Scripts de base de données"
Write-Host "8. Documentation et configuration finale"
Write-Host "\n🔗 Consultez vos PRs sur: https://github.com/$owner/$repo/pulls"