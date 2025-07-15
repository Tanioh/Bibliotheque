<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Bibliothèque - Connexion</title>
    <link rel="stylesheet" href="/static/css/style.css">
</head>
<body>
    <div class="login-container">
        <div class="login-card fade-in">
            <h1 class="login-title">📚 Bibliothèque</h1>
            <p class="subtitle">Système de gestion de bibliothèque</p>
            <p class="mb-3">Veuillez choisir votre type de connexion :</p>
            <div class="choice-buttons">
                <a href="/login-adherent" class="choice-btn adherent">👤 Connexion Adhérent</a>
                <a href="/login-admin" class="choice-btn admin">🔐 Connexion Administrateur</a>
            </div>
        </div>
    </div>
</body>
</html>
