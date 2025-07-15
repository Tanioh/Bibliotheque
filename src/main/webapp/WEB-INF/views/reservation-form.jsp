<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Réserver un exemplaire - Bibliothèque</title>
    <link rel="stylesheet" href="/static/css/style.css">
</head>
<body>
    <div class="container">
        <header class="header">
            <h1 class="header-title">📖 Réservation d'exemplaire</h1>
            <nav class="nav">
                <a href="/liste-exemplaires" class="btn btn-secondary">← Retour à la liste</a>
                <a href="/" class="btn btn-outline">🏠 Accueil</a>
            </nav>
        </header>

        <main class="main-content">
            <div class="card">
                <div class="card-header">
                    <h2 class="card-title">Réserver : ${exemplaire.livre.titre}</h2>
                    <p class="text-muted">Auteur : ${exemplaire.livre.auteur} • Genre : ${exemplaire.livre.genre} • Année : ${exemplaire.livre.annee}</p>
                </div>
                
                <div class="card-content">
                    <form method="post" action="/reservation/${exemplaire.idExemplaire}" class="form">
                        <div class="form-group">
                            <label for="dateReservation" class="form-label">📅 Date de réservation</label>
                            <input type="date" 
                                   id="dateReservation" 
                                   name="dateReservation" 
                                   class="form-input" 
                                   required 
                                   min="${java.time.LocalDate.now()}" />
                            <small class="form-help">Sélectionnez la date à partir de laquelle vous souhaitez réserver ce livre</small>
                        </div>
                        
                        <div class="btn-group">
                            <button type="submit" class="btn btn-primary">✓ Confirmer la réservation</button>
                            <a href="/liste-exemplaires" class="btn btn-secondary">✕ Annuler</a>
                        </div>
                    </form>
                </div>
            </div>
        </main>
    </div>
</body>
</html>