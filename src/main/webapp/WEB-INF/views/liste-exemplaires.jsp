<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Exemplaires disponibles - Bibliothèque</title>
    <link rel="stylesheet" href="/static/css/style.css">
</head>
<body>
    <div class="container">
        <header class="header">
            <h1 class="header-title">📚 Exemplaires disponibles</h1>
            <nav class="nav">
                <a href="/mes-prets" class="btn btn-outline">📚 Mes prêts</a>
                <a href="/mes-reservations" class="btn btn-outline">📋 Mes réservations</a>
                <a href="/" class="btn btn-secondary">🏠 Accueil</a>
            </nav>
        </header>

        <main class="main-content">
            <div class="card">
                <div class="card-header">
                    <h2 class="card-title">Catalogue des livres</h2>
                    <p class="text-muted">Découvrez notre collection et réservez vos ouvrages préférés</p>
                </div>
                
                <div class="card-content">
                    <c:choose>
                        <c:when test="${not empty exemplaires}">
                            <div class="table-container">
                                <table class="table">
                                    <thead>
                                        <tr>
                                            <th>ID</th>
                                            <th>Titre</th>
                                            <th>Auteur</th>
                                            <th>Genre</th>
                                            <th>Année</th>
                                            <th>État</th>
                                            <th>Action</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:forEach var="ex" items="${exemplaires}">
                                            <tr>
                                                <td class="font-mono">#${ex.idExemplaire}</td>
                                                <td class="font-semibold">${ex.livre.titre}</td>
                                                <td>${ex.livre.auteur}</td>
                                                <td>
                                                    <span class="badge badge-secondary">${ex.livre.genre}</span>
                                                </td>
                                                <td class="text-muted">${ex.livre.annee}</td>
                                                <td>
                                                    <c:choose>
                                                        <c:when test="${ex.etat == 'bon'}">
                                                            <span class="badge badge-success">✓ Bon état</span>
                                                        </c:when>
                                                        <c:when test="${ex.etat == 'neuf'}">
                                                            <span class="badge badge-primary">★ Neuf</span>
                                                        </c:when>
                                                        <c:otherwise>
                                                            <span class="badge badge-warning">${ex.etat}</span>
                                                        </c:otherwise>
                                                    </c:choose>
                                                </td>
                                                <td>
                                                    <a href="/reservation/form/${ex.idExemplaire}" class="btn btn-primary btn-sm">
                                                        📖 Réserver
                                                    </a>
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
                                <h3>Aucun exemplaire disponible</h3>
                                <p class="text-muted">Il n'y a actuellement aucun livre disponible à la réservation.</p>
                            </div>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>
        </main>
    </div>
</body>
</html>