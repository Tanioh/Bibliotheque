<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Demander un prolongement - Bibliothèque</title>
    <link rel="stylesheet" href="/static/css/style.css">
</head>
<body>
    <div class="container">
        <header class="header">
            <h1 class="header-title">⏰ Demande de prolongement</h1>
            <nav class="nav">
                <a href="/liste-exemplaires" class="btn btn-secondary">← Retour</a>
            </nav>
        </header>

        <main class="main-content">
            <div class="card">
                <div class="card-header">
                    <h2 class="card-title">📚 ${pret.exemplaire.livre.titre}</h2>
                    <p class="text-muted">Prolonger la durée de votre emprunt</p>
                </div>
                
                <div class="card-content">
                    <div class="alert alert-info">
                        <strong>ℹ️ Information :</strong> Vous pouvez prolonger votre emprunt pour une durée supplémentaire.
                    </div>
                    
                    <div class="detail-grid">
                        <div class="detail-item">
                            <span class="detail-label">📖 Livre emprunté</span>
                            <span class="detail-value font-semibold">${pret.exemplaire.livre.titre}</span>
                        </div>
                        
                        <div class="detail-item">
                            <span class="detail-label">✍️ Auteur</span>
                            <span class="detail-value">${pret.exemplaire.livre.auteur}</span>
                        </div>
                        
                        <div class="detail-item">
                            <span class="detail-label">📅 Date de retour actuelle</span>
                            <span class="detail-value font-mono">${pret.dateRetourPrevue}</span>
                        </div>
                        
                        <div class="detail-item">
                            <span class="detail-label">🆔 Numéro de prêt</span>
                            <span class="detail-value font-mono">#${pret.idPret}</span>
                        </div>
                    </div>
                    
                    <form method="post" action="/prolongement/${pret.idPret}" class="form">
                        <div class="form-group">
                            <label for="nouvelleDateRetour" class="form-label">
                                📅 Nouvelle date de retour souhaitée
                            </label>
                            <input 
                                type="date" 
                                id="nouvelleDateRetour"
                                name="nouvelleDateRetour" 
                                class="form-input"
                                required 
                                min="${pret.dateRetourPrevue}"
                            />
                            <small class="form-help">Choisissez une date postérieure à la date de retour actuelle</small>
                        </div>
                        
                        <div class="btn-group">
                            <button type="submit" class="btn btn-primary">
                                ✅ Valider la prolongement
                            </button>
                            <a href="/liste-exemplaires" class="btn btn-secondary">
                                ❌ Annuler
                            </a>
                        </div>
                    </form>
                </div>
            </div>
        </main>
    </div>
</body>
</html>