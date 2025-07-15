<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${adherent.idAdherent == null ? 'Ajouter' : 'Modifier'} un adhérent - Bibliothèque</title>
    <link rel="stylesheet" href="/static/css/style.css">
</head>
<body>
    <div class="container">
        <div class="header fade-in">
            <h1>📚 Système de Gestion de Bibliothèque</h1>
            <p class="subtitle">${adherent.idAdherent == null ? 'Ajouter un nouvel adhérent' : 'Modifier un adhérent'}</p>
        </div>
        
        <div class="card fade-in">
            <div class="card-header">
                <h2 class="card-title">
                    ${adherent.idAdherent == null ? '➕ Ajouter un adhérent' : '✏️ Modifier un adhérent'}
                </h2>
            </div>
            
            <c:if test="${not empty error}">
                <div class="alert alert-error">
                    <strong>❌ Erreur :</strong> ${error}
                </div>
            </c:if>
            
            <form method="post" action="${adherent.idAdherent == null ? '/adherents' : '/adherents/update/' += adherent.idAdherent}">
                <div class="grid grid-2">
                    <div class="form-group">
                        <label class="form-label">Nom :</label>
                        <input type="text" name="nom" value="${adherent.nom}" class="form-input" required placeholder="Nom de famille">
                    </div>
                    
                    <div class="form-group">
                        <label class="form-label">Prénom :</label>
                        <input type="text" name="prenom" value="${adherent.prenom}" class="form-input" required placeholder="Prénom">
                    </div>
                </div>
                
                <div class="grid grid-2">
                    <div class="form-group">
                        <label class="form-label">Âge :</label>
                        <input type="number" name="age" value="${adherent.age}" class="form-input" required min="1" max="120" placeholder="Âge">
                    </div>
                    
                    <div class="form-group">
                        <label class="form-label">Numéro de téléphone :</label>
                        <input type="text" name="numero" value="${adherent.numero}" class="form-input" placeholder="Numéro de téléphone (optionnel)">
                    </div>
                </div>
                
                <div class="form-group">
                    <label class="form-label">Email :</label>
                    <input type="email" name="email" value="${adherent.email}" class="form-input" required placeholder="adresse@email.com">
                </div>
                
                <div class="grid grid-2">
                    <div class="form-group">
                        <label class="form-label">Statut :</label>
                        <select name="statut" class="form-select" required>
                            <option value="actif" ${adherent.statut == 'actif' ? 'selected' : ''}>✅ Actif</option>
                            <option value="inactif" ${adherent.statut == 'inactif' ? 'selected' : ''}>❌ Inactif</option>
                        </select>
                    </div>
                    
                    <div class="form-group">
                        <label class="form-label">Profil :</label>
                        <select name="profilId" class="form-select" required>
                            <c:forEach var="profil" items="${profils}">
                                <c:if test="${profil.nomProfil != 'Anonyme'}">
                                    <option value="${profil.idProfil}" <c:if test="${adherent.profil != null && adherent.profil.idProfil == profil.idProfil}">selected</c:if>>
                                        ${profil.nomProfil} (${profil.quotaMaxPret} prêts max)
                                    </option>
                                </c:if>
                            </c:forEach>
                        </select>
                    </div>
                </div>
                
                <div class="form-group text-center mt-4">
                    <button type="submit" class="btn btn-success">
                        ${adherent.idAdherent == null ? '➕ Ajouter l\'adhérent' : '💾 Enregistrer les modifications'}
                    </button>
                    <a href="/adherents" class="btn btn-secondary">❌ Annuler</a>
                </div>
            </form>
        </div>
        
        <div class="footer">
            <p>&copy; 2024 Système de Gestion de Bibliothèque. Tous droits réservés.</p>
        </div>
    </div>
</body>
</html>