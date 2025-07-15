<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Gestion des Adhérents - Bibliothèque</title>
    <link rel="stylesheet" href="/static/css/style.css">
</head>
<body>
    <div class="container">
        <div class="header fade-in">
            <h1>📚 Système de Gestion de Bibliothèque</h1>
            <p class="subtitle">Gestion des adhérents</p>
        </div>
        
        <div class="nav fade-in">
            <div class="nav-links">
                <a href="/adherents/new" class="nav-link">➕ Ajouter un adhérent</a>
                <a href="/abonnements" class="nav-link">💳 Gestion des abonnements</a>
                <a href="/prets/new" class="nav-link">📖 Faire un prêt</a>
                <a href="/prets/return" class="nav-link">📥 Rendre un livre</a>
                <a href="/" class="nav-link admin">🏠 Accueil</a>
            </div>
        </div>
        
        <div class="card fade-in">
            <div class="card-header">
                <h2 class="card-title">👥 Liste des Adhérents</h2>
            </div>
            
            <!-- Affichage des messages d'erreur -->
            <c:if test="${not empty error}">
                <div class="alert alert-error">
                    ${error}
                </div>
            </c:if>
            
            <c:choose>
                <c:when test="${not empty adherents}">
                    <div class="table-container">
                        <table class="table">
                            <thead>
                                <tr>
                                    <th>ID</th>
                                    <th>Nom</th>
                                    <th>Prénom</th>
                                    <th>Email</th>
                                    <th>Statut</th>
                                    <th>Actions</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="adherent" items="${adherents}">
                                    <tr>
                                        <td><strong>#${adherent.idAdherent}</strong></td>
                                        <td>${adherent.nom}</td>
                                        <td>${adherent.prenom}</td>
                                        <td>${adherent.email}</td>
                                        <td>
                                            <span class="badge ${adherent.statut == 'actif' ? 'badge-success' : 'badge-warning'}">
                                                ${adherent.statut}
                                            </span>
                                        </td>
                                        <td>
                                            <a href="/adherents/${adherent.idAdherent}" class="btn btn-primary btn-sm">👁️ Détails</a>
                                            <a href="/adherents/edit/${adherent.idAdherent}" class="btn btn-warning btn-sm">✏️ Modifier</a>
                                            <a href="/adherents/delete/${adherent.idAdherent}" 
                                               class="btn btn-danger btn-sm"
                                               onclick="return confirm('Voulez-vous vraiment supprimer cet adhérent ?');">🗑️ Supprimer</a>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </div>
                </c:when>
                <c:otherwise>
                    <div class="text-center p-4">
                        <p class="mb-3">Aucun adhérent trouvé.</p>
                        <a href="/adherents/new" class="btn btn-primary">➕ Ajouter le premier adhérent</a>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>
        
        <div class="footer">
            <p>&copy; 2024 Système de Gestion de Bibliothèque. Tous droits réservés.</p>
        </div>
    </div>
    
    <style>
        .btn-sm {
            padding: 6px 12px;
            font-size: 0.875rem;
            margin: 2px;
        }
        
        .badge {
            padding: 4px 8px;
            border-radius: 12px;
            font-size: 0.75rem;
            font-weight: 600;
            text-transform: uppercase;
        }
        
        .badge-success {
            background: var(--success-color);
            color: white;
        }
        
        .badge-warning {
            background: var(--warning-color);
            color: white;
        }
    </style>
</body>
</html>