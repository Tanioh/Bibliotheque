<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Liste des Abonnements</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/static/css/style.css">
    <style>
        .status-actif { color: green; font-weight: bold; }
        .status-expire { color: red; font-weight: bold; }
        .status-resilie { color: orange; font-weight: bold; }
        .btn { padding: 5px 10px; margin: 2px; text-decoration: none; border-radius: 3px; }
        .btn-primary { background-color: #007bff; color: white; }
        .btn-success { background-color: #28a745; color: white; }
        .btn-warning { background-color: #ffc107; color: black; }
        .btn-danger { background-color: #dc3545; color: white; }
    </style>
</head>
<body>
    <div class="container">
        <h1>Gestion des Abonnements</h1>
        
        <div class="actions">
            <a href="${pageContext.request.contextPath}/abonnements/nouveau" class="btn btn-primary">Nouvel Abonnement</a>
            <a href="${pageContext.request.contextPath}/abonnements/expirant" class="btn btn-warning">Abonnements Expirant</a>
            <a href="${pageContext.request.contextPath}/" class="btn btn-secondary">Retour Accueil</a>
        </div>
        
        <c:if test="${not empty success}">
            <div class="alert alert-success">${success}</div>
        </c:if>
        
        <c:if test="${not empty error}">
            <div class="alert alert-danger">${error}</div>
        </c:if>
        
        <table class="table">
            <thead>
                <tr>
                    <th>ID</th>
                    <th>Adhérent</th>
                    <th>Type</th>
                    <th>Date Début</th>
                    <th>Date Fin</th>
                    <th>Prix</th>
                    <th>Statut</th>
                    <th>Auto-Renouvellement</th>
                    <th>Actions</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="abonnement" items="${abonnements}">
                    <tr>
                        <td>${abonnement.idAbonnement}</td>
                        <td>${abonnement.adherent.nom} ${abonnement.adherent.prenom}</td>
                        <td>${abonnement.typeAbonnement}</td>
                        <td>${abonnement.dateDebut.dayOfMonth}/${abonnement.dateDebut.monthValue}/${abonnement.dateDebut.year}</td>
                        <td>${abonnement.dateFin.dayOfMonth}/${abonnement.dateFin.monthValue}/${abonnement.dateFin.year}</td>
                        <td><fmt:formatNumber value="${abonnement.prix}" type="currency"/></td>
                        <td class="status-${abonnement.statut}">${abonnement.statut}</td>
                        <td>${abonnement.autoRenouvellement ? 'Oui' : 'Non'}</td>
                        <td>
                            <a href="${pageContext.request.contextPath}/abonnements/${abonnement.idAbonnement}" class="btn btn-primary">Détails</a>
                            <c:if test="${abonnement.statut == 'actif'}">
                                <form style="display:inline" method="post" action="${pageContext.request.contextPath}/abonnements/${abonnement.idAbonnement}/resilier">
                                    <button type="submit" class="btn btn-danger" onclick="return confirm('Êtes-vous sûr de vouloir résilier cet abonnement ?')">Résilier</button>
                                </form>
                            </c:if>
                        </td>
                    </tr>
                </c:forEach>
                <c:if test="${empty abonnements}">
                    <tr>
                        <td colspan="9" style="text-align: center;">Aucun abonnement trouvé</td>
                    </tr>
                </c:if>
            </tbody>
        </table>
    </div>
</body>
</html>