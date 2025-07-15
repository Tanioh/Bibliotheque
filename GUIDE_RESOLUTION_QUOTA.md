# Guide de Résolution - Erreur de Quota de Prêt

## Problème Identifié
L'erreur "Vous avez atteint le nombre de quota max" se produit quand un adhérent a le profil **'Anonyme'** qui a un quota de 0 prêt.

## Cause du Problème
Dans le système, il existe 3 profils :
- **Etudiant** : 3 prêts maximum
- **Professeur** : 5 prêts maximum  
- **Anonyme** : 0 prêt maximum (ne devrait pas être assigné aux adhérents normaux)

## Solutions

### Solution 1 : Modifier le Profil de l'Adhérent (Recommandée)
1. Aller sur `http://localhost:8081/adherents`
2. Cliquer sur l'adhérent concerné pour voir ses détails
3. Cliquer sur "✏️ Modifier les informations"
4. Changer le profil de "Anonyme" vers "Etudiant" ou "Professeur"
5. Sauvegarder

### Solution 2 : Correction en Base de Données
Exécuter le script SQL fourni (`fix_adherent_profils.sql`) :
```sql
UPDATE Adherent 
SET id_profil = (SELECT id_profil FROM Profil WHERE nom_profil = 'Etudiant')
WHERE id_profil = (SELECT id_profil FROM Profil WHERE nom_profil = 'Anonyme');
```

## Prévention
Le formulaire de création d'adhérent a été modifié pour :
- Exclure le profil "Anonyme" des options disponibles
- Afficher le quota maximum pour chaque profil

## Vérification
Après correction, le message d'erreur sera plus explicite et indiquera :
- Le profil actuel de l'adhérent
- Le quota autorisé
- Le nombre de prêts en cours

## Messages d'Erreur Améliorés
- **Quota 0** : "Cet adhérent a le profil 'Anonyme' qui ne permet aucun prêt. Veuillez modifier son profil."
- **Quota atteint** : "Quota de prêts atteint pour cet adhérent (3/3 - Profil: Etudiant)."