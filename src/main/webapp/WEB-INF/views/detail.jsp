<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Détails de l'adhérent - Bibliothèque</title>
    <link rel="stylesheet" href="/static/css/style.css">
</head>
<body>
    <div class="container">
        <header class="header">
            <h1 class="header-title">👤 Détails de l'adhérent</h1>
            <nav class="nav">
                <a href="/adherents" class="btn btn-secondary">← Retour à la liste</a>
                <a href="/adherents/form/${adherent.idAdherent}" class="btn btn-primary">✏️ Modifier</a>
            </nav>
        </header>

        <main class="main-content">
            <div class="card">
                <div class="card-header">
                    <h2 class="card-title">${adherent.nom} ${adherent.prenom}</h2>
                    <c:choose>
                        <c:when test="${adherent.statut == 'actif'}">
                            <span class="badge badge-success">✓ Actif</span>
                        </c:when>
                        <c:when test="${adherent.statut == 'inactif'}">
                            <span class="badge badge-danger">✗ Inactif</span>
                        </c:when>
                        <c:when test="${adherent.statut == 'suspendu'}">
                            <span class="badge badge-warning">⚠️ Suspendu</span>
                        </c:when>
                        <c:otherwise>
                            <span class="badge badge-secondary">${adherent.statut}</span>
                        </c:otherwise>
                    </c:choose>
                </div>
                
                <div class="card-content">
                    <div class="detail-grid">
                        <div class="detail-item">
                            <span class="detail-label">🆔 Identifiant</span>
                            <span class="detail-value font-mono">#${adherent.idAdherent}</span>
                        </div>
                        
                        <div class="detail-item">
                            <span class="detail-label">👤 Nom complet</span>
                            <span class="detail-value font-semibold">${adherent.nom} ${adherent.prenom}</span>
                        </div>
                        
                        <div class="detail-item">
                            <span class="detail-label">🎂 Âge</span>
                            <span class="detail-value">${adherent.age} ans</span>
                        </div>
                        
                        <div class="detail-item">
                            <span class="detail-label">📧 Email</span>
                            <span class="detail-value">
                                <a href="mailto:${adherent.email}" class="link">${adherent.email}</a>
                            </span>
                        </div>
                        
                        <div class="detail-item">
                            <span class="detail-label">📞 Numéro</span>
                            <span class="detail-value font-mono">${adherent.numero}</span>
                        </div>
                        
                        <div class="detail-item">
                            <span class="detail-label">🏷️ Profil</span>
                            <span class="detail-value">
                                <c:choose>
                                    <c:when test="${adherent.profil != null}">
                                        <span class="badge badge-primary">${adherent.profil.nomProfil}</span>
                                    </c:when>
                                    <c:otherwise>
                                        <span class="text-muted">Aucun profil assigné</span>
                                    </c:otherwise>
                                </c:choose>
                            </span>
                        </div>
                        
                        <div class="detail-item">
                            <span class="detail-label">📚 Quota de Prêts</span>
                            <span class="detail-value">
                                <c:choose>
                                    <c:when test="${quotaRestant > 0}">
                                        <span class="badge badge-success">${quotaRestant} prêt(s) restant(s)</span>
                                    </c:when>
                                    <c:when test="${quotaRestant == 0 && quotaMax > 0}">
                                        <span class="badge badge-warning">Quota atteint (${nbPretsEnCours}/${quotaMax})</span>
                                    </c:when>
                                    <c:otherwise>
                                        <span class="badge badge-danger">Aucun prêt autorisé</span>
                                    </c:otherwise>
                                </c:choose>
                                <br><small class="text-muted">Prêts en cours: ${nbPretsEnCours} / Maximum: ${quotaMax}</small>
                            </span>
                        </div>
                        
                        <div class="detail-item">
                            <span class="detail-label">⚠️ Statut Pénalité</span>
                            <span class="detail-value">
                                <c:choose>
                                    <c:when test="${estPenalise}">
                                        <span class="badge badge-danger">Pénalisé - ${joursRestantsPenalite} jour(s) restant(s)</span>
                                        <c:if test="${penaliteActive != null}">
                                            <br><small class="text-muted">Raison: ${penaliteActive.raison}</small>
                                            <br><small class="text-muted">Fin prévue: ${penaliteActive.dateFin}</small>
                                        </c:if>
                                        <br><br>
                                        <form method="post" action="/adherents/${adherent.idAdherent}/annuler-penalite" style="display: inline;">
                                            <button type="submit" class="btn btn-warning btn-sm" onclick="return confirm('Êtes-vous sûr de vouloir annuler cette pénalité ?')">
                                                🚫 Annuler la pénalité
                                            </button>
                                        </form>
                                    </c:when>
                                    <c:otherwise>
                                        <span class="badge badge-success">✓ Aucune pénalité</span>
                                    </c:otherwise>
                                </c:choose>
                            </span>
                        </div>
                    </div>
                </div>
                
                <div class="card-footer">
                    <div class="btn-group">
                        <a href="/adherents/form/${adherent.idAdherent}" class="btn btn-primary">
                            ✏️ Modifier les informations
                        </a>
                        <a href="/prets/form" class="btn btn-outline">
                            📚 Faire un prêt
                        </a>
                        <a href="/adherents" class="btn btn-secondary">
                            ← Retour à la liste
                        </a>
                    </div>
                </div>
            </div>
        </main>
    </div>
</body>
</html>