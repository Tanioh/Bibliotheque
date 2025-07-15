# 📥 Installation de GitHub CLI

## 🎯 Pourquoi installer GitHub CLI ?
GitHub CLI vous permettra d'exécuter automatiquement le script `create_prs_github_cli.ps1` pour créer les 8 pull requests en une seule commande !

## 💻 Méthodes d'installation

### Méthode 1 : Winget (Recommandée)
```powershell
winget install --id GitHub.cli
```

### Méthode 2 : Chocolatey
```powershell
# Installer Chocolatey d'abord si pas déjà fait
Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))

# Puis installer GitHub CLI
choco install gh
```

### Méthode 3 : Téléchargement direct
1. Allez sur : https://github.com/cli/cli/releases/latest
2. Téléchargez le fichier `.msi` pour Windows
3. Exécutez l'installateur

## 🔐 Configuration après installation

### 1. Vérifier l'installation
```powershell
gh --version
```

### 2. Se connecter à GitHub
```powershell
gh auth login
```
- Choisissez "GitHub.com"
- Choisissez "HTTPS"
- Authentifiez-vous avec votre navigateur

### 3. Vérifier l'authentification
```powershell
gh auth status
```

## 🚀 Utilisation du script automatique

Une fois GitHub CLI installé et configuré :

```powershell
# Naviguez dans le dossier du projet
cd c:\Users\tanio\Desktop\BIBLIO_rang4\biblio

# Exécutez le script automatique
powershell -ExecutionPolicy Bypass -File create_prs_github_cli.ps1
```

## ⚡ Commandes rapides

### Installation rapide (une ligne)
```powershell
winget install --id GitHub.cli; gh auth login
```

### Vérification complète
```powershell
gh --version; gh auth status; gh repo view
```

## 🔧 Dépannage

### Si winget n'est pas reconnu :
- Mettez à jour Windows
- Ou utilisez la méthode Chocolatey

### Si gh n'est pas reconnu après installation :
- Redémarrez PowerShell
- Ou redémarrez votre ordinateur

### Si l'authentification échoue :
```powershell
gh auth logout
gh auth login
```

## 📋 Avantages de GitHub CLI

✅ **Création automatique** des 8 PRs en une commande  
✅ **Descriptions détaillées** générées automatiquement  
✅ **Liens entre branches** configurés correctement  
✅ **Gain de temps** considérable  
✅ **Moins d'erreurs** qu'en manuel  

---

💡 **Astuce** : Une fois installé, vous pourrez utiliser `gh` pour toutes vos interactions GitHub en ligne de commande !