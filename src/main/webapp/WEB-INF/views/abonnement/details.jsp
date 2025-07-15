<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Détails de l'Abonnement</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/static/css/style.css">
    <style>
        .detail-card { background: #f8f9fa; padding: 20px; border-radius: 8px; margin: 20px 0; }
        .detail-row { display: flex; margin-bottom: 10px; }
        .detail-label { font-weight: bold; width: 200px; }
        .detail-value { flex: 1; }
        .status-actif { color: green; font-weight: bold; }
        .status-expire { color: red; font-weight: bold; }
        .status-resilie { color: orange; font-weight: bold; }
        .btn { padding: 10px 15px; margin: 5px; text-decoration: none; border: none; border-radius: 4px; cursor: pointer; }
        .btn-primary { background-color: #007bff; color: white; }
        .btn-success { background-color: #28a745; color: white; }
        .btn-danger { background-color: #dc3545; color: white; }
        .btn-secondary { background-color: #6c757d; color: white; }
        .form-inline { display: inline-block; margin-left: 10px; }
        .form-inline input { padding: 8px; margin-right: 5px; border: 1px solid #ddd; border-radius: 4px; }
    </style>
</head>
<body>
    <div class="container">
        <h1>Détails de l'Abonnement #${abonnement.idAbonnement}</h1>
        
        <c:if test="${not empty success}">
            <div class="alert alert-success">${success}</div>
        </c:if>
        
        <c:if test="${not empty error}">
            <div class="alert alert-danger">${error}</div>
        </c:if>
        
        <div class="detail-card">
            <h3>Informations de l'Abonnement</h3>
            
            <div class="detail-row">
                <div class="detail-label">ID Abonnement :</div>
                <div class="detail-value">${abonnement.idAbonnement}</div>
            </div>
            
            <div class="detail-row">
                <div class="detail-label">Adhérent :</div>
                <div class="detail-value">
                    <strong>${abonnement.adherent.nom} ${abonnement.adherent.prenom}</strong><br>
                    Email: ${abonnement.adherent.email}<br>
                    Téléphone: ${abonnement.adherent.numero}
                </div>
            </div>
            
            <div class="detail-row">
                <div class="detail-label">Type d'Abonnement :</div>
                <div class="detail-value">${abonnement.typeAbonnement}</div>
            </div>
            
            <div class="detail-row">
                <div class="detail-label">Date de Début :</div>
                <div class="detail-value">${abonnement.dateDebut.dayOfMonth}/${abonnement.dateDebut.monthValue}/${abonnement.dateDebut.year}</div>
            </div>
            
            <div class="detail-row">
                <div class="detail-label">Date de Fin :</div>
                <div class="detail-value">${abonnement.dateFin.dayOfMonth}/${abonnement.dateFin.monthValue}/${abonnement.dateFin.year}</div>
            </div>
            
            <div class="detail-row">
                <div class="detail-label">Prix :</div>
                <div class="detail-value"><fmt:formatNumber value="${abonnement.prix}" type="currency"/></div>
            </div>
            
            <div class="detail-row">
                <div class="detail-label">Statut :</div>
                <div class="detail-value">
                    <span class="status-${abonnement.statut}">${abonnement.statut}</span>
                </div>
            </div>
            
            <div class="detail-row">
                <div class="detail-label">Renouvellement Auto :</div>
                <div class="detail-value">${abonnement.autoRenouvellement ? 'Activé' : 'Désactivé'}</div>
            </div>
            
            <div class="detail-row">
                <div class="detail-label">Date de Création :</div>
                <div class="detail-value"><fmt:formatDate value="${abonnement.dateCreation}" pattern="dd/MM/yyyy HH:mm"/></div>
            </div>
        </div>
        
        <div class="actions">
            <a href="${pageContext.request.contextPath}/abonnements" class="btn btn-secondary">Retour à la Liste</a>
            
            <c:if test="${abonnement.statut == 'actif'}">
                <!-- Formulaire de renouvellement -->
                <form class="form-inline" method="post" action="${pageContext.request.contextPath}/abonnements/${abonnement.idAbonnement}/renouveler">
                    <input type="date" name="nouvelleDateFin" required>
                    <button type="submit" class="btn btn-success">Renouveler</button>
                </form>
                
                <!-- Formulaire de résiliation -->
                <form class="form-inline" method="post" action="${pageContext.request.contextPath}/abonnements/${abonnement.idAbonnement}/resilier">
                    <button type="submit" class="btn btn-danger" onclick="return confirm('Êtes-vous sûr de vouloir résilier cet abonnement ?')">Résilier</button>
                </form>
            </c:if>
            
            <a href="${pageContext.request.contextPath}/abonnements/adherent/${abonnement.adherent.idAdherent}" class="btn btn-primary">Voir tous les abonnements de cet adhérent</a>
        </div>
        
        <!-- Informations supplémentaires -->
        <div class="detail-card">
            <h3>Informations Complémentaires</h3>
            
            <c:choose>
                <c:when test="${abonnement.statut == 'actif'}">
                    <c:set var="today" value="<%=new java.util.Date()%>" />
                    <c:choose>
                        <c:when test="${abonnement.dateFin lt today}">
                            <div class="alert alert-warning">
                                ⚠️ Cet abonnement a expiré le ${abonnement.dateFin.dayOfMonth}/${abonnement.dateFin.monthValue}/${abonnement.dateFin.year}.
                            </div>
                        </c:when>
                        <c:otherwise>
                            <div class="alert alert-success">
                                ✅ Cet abonnement est actif jusqu'au ${abonnement.dateFin.dayOfMonth}/${abonnement.dateFin.monthValue}/${abonnement.dateFin.year}.
                            </div>
                        </c:otherwise>
                    </c:choose>
                </c:when>
                <c:when test="${abonnement.statut == 'expire'}">
                    <div class="alert alert-danger">
                        ❌ Cet abonnement a expiré le ${abonnement.dateFin.dayOfMonth}/${abonnement.dateFin.monthValue}/${abonnement.dateFin.year}.
                    </div>
                </c:when>
                <c:when test="${abonnement.statut == 'resilie'}">
                    <div class="alert alert-warning">
                        🚫 Cet abonnement a été résilié.
                    </div>
                </c:when>
            </c:choose>
            
            <c:if test="${abonnement.autoRenouvellement and abonnement.statut == 'actif'}">
                <div class="alert alert-info">
                    🔄 Le renouvellement automatique est activé pour cet abonnement.
                </div>
            </c:if>
        </div>
    </div>
    
    <script>
        // Définir la date de renouvellement par défaut (1 an à partir d'aujourd'hui)
        const renewalInput = document.querySelector('input[name="nouvelleDateFin"]');
        if (renewalInput) {
            const today = new Date();
            const nextYear = new Date(today.getFullYear() + 1, today.getMonth(), today.getDate());
            renewalInput.value = nextYear.toISOString().split('T')[0];
        }
    </script>
</body>
</html>