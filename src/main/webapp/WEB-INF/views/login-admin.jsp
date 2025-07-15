<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Connexion Administrateur - Bibliothèque</title>
    <link rel="stylesheet" href="/static/css/style.css">
</head>
<body>
    <div class="login-container">
        <div class="login-card fade-in">
            <h1 class="login-title">🔐 Connexion Administrateur</h1>
            <p class="subtitle mb-3">Accès réservé aux administrateurs</p>
            
            <c:if test="${not empty error}">
                <div class="alert alert-error mb-3">
                    ${error}
                </div>
            </c:if>
            
            <form method="post" action="/login-admin">
                <div class="form-group">
                    <label class="form-label">Nom d'utilisateur :</label>
                    <input type="text" name="nom_utilisateur" class="form-input" required placeholder="Nom d'utilisateur">
                </div>
                
                <div class="form-group">
                    <label class="form-label">Mot de passe :</label>
                    <input type="password" name="mot_de_passe" class="form-input" required placeholder="Mot de passe">
                </div>
                
                <div class="form-group">
                    <button type="submit" class="btn btn-danger" style="width: 100%;">Se connecter</button>
                </div>
            </form>
            
            <div class="text-center mt-3">
                <a href="/" class="btn btn-secondary">← Retour à l'accueil</a>
            </div>
        </div>
    </div>
</body>
</html>
