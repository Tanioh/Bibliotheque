<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Mes prêts - Bibliothèque</title>
    <link rel="stylesheet" href="/static/css/style.css">
</head>
<body>
    <div class="container">
        <header class="header">
            <h1 class="header-title">📚 Mes prêts en cours</h1>
            <nav class="nav">
                <a href="/mes-reservations" class="btn btn-outline">📋 Mes réservations</a>
                <a href="/exemplaires" class="btn btn-outline">📖 Catalogue</a>
                <a href="/" class="btn btn-secondary">🏠 Accueil</a>
            </nav>
        </header>

        <main class="main-content">
            <div class="card">
                <div class="card-header">
                    <h2 class="card-title">Bonjour ${adherent.prenom} ${adherent.nom}</h2>
                    <p class="text-muted">Voici la liste de vos prêts en cours</p>
                </div>
                
                <div class="card-content">
                    <c:choose>
                        <c:when test="${not empty prets}">
                            <div class="table-container">
                                <table class="table">
                                    <thead>
                                        <tr>
                                            <th>Livre</th>
                                            <th>Auteur</th>
                                            <th>Date d'emprunt</th>
                                            <th>Date de retour prévue</th>
                                            <th>Statut</th>
                                            <th>Actions</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:forEach var="pret" items="${prets}">
                                            <tr>
                                                <td class="font-semibold">${pret.exemplaire.livre.titre}</td>
                                                <td>${pret.exemplaire.livre.auteur}</td>
                                                <td>${pret.datePret}</td>
                                                <td class="${pret.dateRetourPrevue < now ? 'text-danger' : 'text-muted'}">
                                                    ${pret.dateRetourPrevue}
                                                </td>
                                                <td>
                                                    <c:choose>
                                                        <c:when test="${pret.statut.libelle == 'en_cours'}">
                                                            <span class="badge badge-primary">En cours</span>
                                                        </c:when>
                                                        <c:when test="${pret.statut.libelle == 'retourne'}">
                                                            <span class="badge badge-success">Retourné</span>
                                                        </c:when>
                                                        <c:when test="${pret.statut.libelle == 'en_retard'}">
                                                            <span class="badge badge-danger">En retard</span>
                                                        </c:when>
                                                        <c:otherwise>
                                                            <span class="badge badge-secondary">${pret.statut.libelle}</span>
                                                        </c:otherwise>
                                                    </c:choose>
                                                </td>
                                                <td>
                                                    <c:if test="${pret.statut.libelle == 'en_cours'}">
                                                        <a href="/prolongement/form/${pret.idPret}" class="btn btn-outline btn-sm">
                                                            ⏰ Prolonger
                                                        </a>
                                                    </c:if>
                                                </td>
                                            </tr>
                                        </c:forEach>
                                    </tbody>
                                </table>
                            </div>
                        </c:when>
                        <c:otherwise>
                            <div class="empty-state">
                                <div class="empty-icon">📚</div>
                                <h3>Aucun prêt en cours</h3>
                                <p class="text-muted">Vous n'avez actuellement aucun livre emprunté.</p>
                                <a href="/liste-exemplaires" class="btn btn-primary">Découvrir les livres disponibles</a>
                            </div>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>
        </main>
    </div>
</body>
</html>