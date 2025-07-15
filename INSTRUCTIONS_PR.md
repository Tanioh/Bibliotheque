# 📋 Instructions pour créer les Pull Requests automatiquement

## 🔑 Étape 1: Créer un token GitHub

1. Allez sur GitHub: https://github.com/settings/tokens
2. Cliquez sur "Generate new token" → "Generate new token (classic)"
3. Donnez un nom au token: `Bibliotheque-PR-Creator`
4. Sélectionnez les permissions suivantes:
   - ✅ **repo** (accès complet aux repositories)
   - ✅ **workflow** (pour les actions GitHub)
5. Cliquez sur "Generate token"
6. **IMPORTANT**: Copiez le token immédiatement (vous ne pourrez plus le voir)

## ⚙️ Étape 2: Configurer le token

Ouvrez PowerShell et exécutez:
```powershell
# Remplacez YOUR_TOKEN_HERE par votre token GitHub
$env:GITHUB_TOKEN = "YOUR_TOKEN_HERE"
```

## 🚀 Étape 3: Exécuter le script

Dans le même PowerShell, naviguez vers le dossier du projet et exécutez:
```powershell
cd "C:\Users\tanio\Desktop\BIBLIO_rang4\biblio"
.\create_pull_requests.ps1
```

## 📋 Ce que le script va créer

Le script créera automatiquement **8 Pull Requests** organisées étape par étape:

### 1. 🔧 Configuration initiale
- **Branche**: `feature/initial-setup`
- **Titre**: "feat: Configuration initiale du projet Spring Boot"
- **Contenu**: Configuration Maven, Spring Boot, structure de base

### 2. 📊 Modèle de données
- **Branche**: `feature/data-model`
- **Titre**: "feat: Implémentation du modèle de données"
- **Contenu**: Entités JPA (Livre, Adherent, Pret, etc.)

### 3. 🗄️ Couche Repository
- **Branche**: `feature/repositories`
- **Titre**: "feat: Implémentation de la couche Repository"
- **Contenu**: Repositories Spring Data JPA

### 4. 🏢 Services et DTOs
- **Branche**: `feature/services-dto`
- **Titre**: "feat: Implémentation des Services et DTOs"
- **Contenu**: Logique métier et objets de transfert

### 5. 🌐 Contrôleurs Web
- **Branche**: `feature/web-controllers`
- **Titre**: "feat: Implémentation des contrôleurs Web"
- **Contenu**: Contrôleurs Web et API REST

### 6. 🎨 Interface utilisateur
- **Branche**: `feature/frontend`
- **Titre**: "feat: Implémentation de l'interface utilisateur"
- **Contenu**: Pages JSP et ressources statiques

### 7. 🗄️ Scripts de base de données
- **Branche**: `feature/database-scripts`
- **Titre**: "feat: Scripts de base de données"
- **Contenu**: Scripts SQL d'initialisation et maintenance

### 8. 📖 Documentation
- **Branche**: `feature/documentation`
- **Titre**: "docs: Documentation et configuration finale"
- **Contenu**: Documentation complète et guides

## ✅ Résultat attendu

Après l'exécution, vous aurez:
- ✅ 8 Pull Requests créées automatiquement
- ✅ Chaque PR avec une description détaillée
- ✅ Organisation logique du développement étape par étape
- ✅ Historique professionnel de développement

## 🔗 Vérification

Après l'exécution, consultez vos PRs sur:
https://github.com/Tanioh/Bibliotheque/pulls

## ❗ Dépannage

### Erreur de token
```
ERREUR: Veuillez définir votre token GitHub
```
**Solution**: Vérifiez que vous avez bien défini la variable d'environnement `GITHUB_TOKEN`

### Erreur d'API
```
Erreur lors de la création de la PR
```
**Solutions possibles**:
- Vérifiez que le token a les bonnes permissions
- Vérifiez que le repository existe
- Vérifiez que les branches existent sur GitHub

### Branches manquantes
Si certaines branches n'existent pas sur GitHub, poussez-les d'abord:
```powershell
git push origin --all
```