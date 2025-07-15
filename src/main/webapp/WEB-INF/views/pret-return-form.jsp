<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Rendre un livre - Bibliothèque</title>
    <link rel="stylesheet" href="/static/css/style.css">
</head>
<body>
    <div class="container">
        <header class="header">
            <h1 class="header-title">📤 Retour de livre</h1>
            <nav class="nav">
                <a href="/adherents" class="btn btn-secondary">← Retour</a>
            </nav>
        </header>

        <main class="main-content">
            <div class="card">
                <div class="card-header">
                    <h2 class="card-title">Enregistrer un retour</h2>
                    <p class="text-muted">Sélectionnez le prêt à retourner et confirmez la date de rendu</p>
                </div>
                
                <div class="card-content">
                    <c:if test="${not empty message}">
                        <div class="alert alert-info">
                            <strong>ℹ️ Information :</strong> ${message}
                        </div>
                    </c:if>
                    
                    <c:choose>
                        <c:when test="${not empty prets}">
                            <form method="post" action="/prets/return" class="form">
                                <div class="form-group">
                                    <label for="pretId" class="form-label">
                                        📚 Prêt à rendre
                                    </label>
                                    <select id="pretId" name="pretId" class="form-select" required>
                                        <option value="">Sélectionnez un prêt à retourner</option>
                                        <c:forEach var="pret" items="${prets}">
                                            <option value="${pret.idPret}">
                                                📖 ${pret.exemplaire.livre.titre} - 
                                                👤 ${pret.adherent.nom} ${pret.adherent.prenom} - 
                                                📅 Retour prévu: ${pret.dateRetourPrevue}
                                            </option>
                                        </c:forEach>
                                    </select>
                                    <small class="form-help">Choisissez le livre à retourner dans la liste</small>
                                </div>
                                
                                <div class="form-group">
                                    <label for="dateRendu" class="form-label">
                                        📅 Date de rendu effective
                                    </label>
                                    <input 
                                        type="date" 
                                        id="dateRendu"
                                        name="dateRendu" 
                                        class="form-input"
                                        required 
                                        max="${java.time.LocalDate.now()}"
                                    />
                                    <small class="form-help">Date à laquelle le livre a été effectivement rendu</small>
                                </div>
                                
                                <div class="btn-group">
                                    <button type="submit" class="btn btn-primary">
                                        ✅ Valider le retour
                                    </button>
                                    <a href="/adherents" class="btn btn-secondary">
                                        ❌ Annuler
                                    </a>
                                </div>
                            </form>
                        </c:when>
                        <c:otherwise>
                            <div class="empty-state">
                                <div class="empty-icon">📚</div>
                                <h3>Aucun prêt en cours</h3>
                                <p class="text-muted">Il n'y a actuellement aucun livre emprunté à retourner.</p>
                                <a href="/prets/form" class="btn btn-primary">📖 Faire un nouveau prêt</a>
                            </div>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>
        </main>
    </div>
</body>
</html>