# Guide d'utilisation du script de réinitialisation de la base de données

## Description
Le script `reset_database.sql` permet de réinitialiser complètement la base de données en supprimant toutes les données de toutes les tables.

⚠️ **ATTENTION : Cette opération est IRRÉVERSIBLE !**

## Prérequis
- Accès à MySQL/MariaDB
- Droits d'administration sur la base de données
- Sauvegarde de la base de données (recommandé)

## Méthodes d'exécution

### Méthode 1 : Via ligne de commande MySQL
```bash
# Se connecter à MySQL
mysql -u root -p

# Sélectionner la base de données
USE biblio;

# Exécuter le script
source reset_database.sql;
```

### Méthode 2 : Via fichier en une commande
```bash
mysql -u root -p biblio < reset_database.sql
```

### Méthode 3 : Via phpMyAdmin ou autre interface graphique
1. Ouvrir phpMyAdmin
2. Sélectionner la base de données `biblio`
3. Aller dans l'onglet "SQL"
4. Copier-coller le contenu du fichier `reset_database.sql`
5. Cliquer sur "Exécuter"

### Méthode 4 : Via MySQL Workbench
1. Ouvrir MySQL Workbench
2. Se connecter à la base de données
3. Ouvrir le fichier `reset_database.sql`
4. Exécuter le script (Ctrl+Shift+Enter)

## Ce que fait le script

1. **Désactive les contraintes de clés étrangères** temporairement
2. **Supprime toutes les données** des tables dans l'ordre suivant :
   - `prolongement` (dépend des prêts)
   - `pret` (dépend des adhérents et livres)
   - `penalite` (dépend des adhérents)
   - `adherent` (dépend des profils)
   - `livre` (dépend des catégories)
   - `profil` (table indépendante)
   - `categorie` (table indépendante)
3. **Remet à zéro les compteurs AUTO_INCREMENT** de chaque table
4. **Réactive les contraintes de clés étrangères**
5. **Affiche un rapport** du nombre de lignes dans chaque table (devrait être 0)

## Après la réinitialisation

Après avoir exécuté ce script, vous pouvez :

1. **Insérer de nouvelles données** via :
   - Le script `donne.sql` (données d'exemple)
   - L'interface web de l'application
   - Des scripts SQL personnalisés

2. **Vérifier que la réinitialisation a fonctionné** :
   ```sql
   SELECT COUNT(*) FROM adherent;   -- Devrait retourner 0
   SELECT COUNT(*) FROM livre;      -- Devrait retourner 0
   SELECT COUNT(*) FROM pret;       -- Devrait retourner 0
   -- etc.
   ```

## Recommandations de sécurité

1. **Toujours faire une sauvegarde** avant d'exécuter le script :
   ```bash
   mysqldump -u root -p biblio > backup_biblio_$(date +%Y%m%d_%H%M%S).sql
   ```

2. **Tester d'abord sur un environnement de développement**

3. **Arrêter l'application** avant d'exécuter le script pour éviter les conflits

4. **Vérifier les résultats** après exécution

## Dépannage

### Erreur de contraintes de clés étrangères
Si vous obtenez des erreurs de contraintes, vérifiez que :
- Le script est exécuté dans son intégralité
- Les contraintes sont bien désactivées au début

### Erreur de permissions
```sql
-- Vérifier les permissions
SHOW GRANTS FOR CURRENT_USER();
```

### Tables non trouvées
Vérifiez que vous êtes connecté à la bonne base de données :
```sql
SELECT DATABASE();
```

## Contact
En cas de problème, contactez l'administrateur de la base de données.