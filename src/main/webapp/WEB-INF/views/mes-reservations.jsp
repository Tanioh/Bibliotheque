<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Mes réservations - Bibliothèque</title>
    <link rel="stylesheet" href="/static/css/style.css">
</head>
<body>
    <div class="container">
        <header class="header">
            <h1 class="header-title">📋 Mes réservations</h1>
            <nav class="nav">
                <a href="/mes-prets" class="btn btn-outline">📚 Mes prêts</a>
                <a href="/exemplaires" class="btn btn-outline">📖 Catalogue</a>
                <a href="/" class="btn btn-secondary">🏠 Accueil</a>
            </nav>
        </header>

        <main class="main-content">
            <div class="card">
                <div class="card-header">
                    <h2 class="card-title">Bonjour ${adherent.nom} ${adherent.prenom}</h2>
                    <p class="text-muted">Voici la liste de vos réservations</p>
                </div>
                
                <div class="card-content">
                    <c:choose>
                        <c:when test="${not empty reservations}">
                            <div class="table-container">
                                <table class="table">
                                    <thead>
                                        <tr>
                                            <th>Livre</th>
                                            <th>Auteur</th>
                                            <th>Date de réservation</th>
                                            <th>Statut</th>
                                            <th>Action</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:forEach var="reservation" items="${reservations}">
                                            <tr>
                                                <td class="font-semibold">${reservation.exemplaire.livre.titre}</td>
                                                <td>${reservation.exemplaire.livre.auteur}</td>
                                                <td>
                                                    ${reservation.dateReservation.dayOfMonth}/${reservation.dateReservation.monthValue}/${reservation.dateReservation.year}
                                                </td>
                                                <td>
                                                    <c:choose>
                                                        <c:when test="${reservation.statut.libelle == 'en_cours'}">
                                                            <span class="badge badge-warning">⏳ En attente</span>
                                                        </c:when>
                                                        <c:when test="${reservation.statut.libelle == 'confirmee'}">
                                                            <span class="badge badge-success">✅ Confirmée</span>
                                                        </c:when>
                                                        <c:when test="${reservation.statut.libelle == 'annulee'}">
                                                            <span class="badge badge-danger">❌ Annulée</span>
                                                        </c:when>
                                                        <c:otherwise>
                                                            <span class="badge badge-secondary">${reservation.statut.libelle}</span>
                                                        </c:otherwise>
                                                    </c:choose>
                                                </td>
                                                <td>
                                                    <c:if test="${reservation.statut.libelle == 'confirmee'}">
                                                        <a href="/prets/form?exemplaireId=${reservation.exemplaire.idExemplaire}&adherentId=${reservation.adherent.idAdherent}" class="btn btn-primary btn-sm">
                                                            📚 Emprunter
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
                                <div class="empty-icon">📋</div>
                                <h3>Aucune réservation</h3>
                                <p class="text-muted">Vous n'avez actuellement aucune réservation.</p>
                                <a href="/exemplaires" class="btn btn-primary">📖 Parcourir le catalogue</a>
                            </div>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>
        </main>
    </div>
</body>
</html>