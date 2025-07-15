<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Faire un prêt - Bibliothèque</title>
    <link rel="stylesheet" href="/static/css/style.css">
</head>
<body>
    <div class="container">
        <header class="header">
            <h1 class="header-title">📚 Nouveau prêt</h1>
            <nav class="nav">
                <a href="/adherents" class="btn btn-secondary">← Retour</a>
            </nav>
        </header>

        <main class="main-content">
            <div class="card">
                <div class="card-header">
                    <h2 class="card-title">Enregistrer un prêt</h2>
                    <p class="text-muted">Sélectionnez un adhérent et un livre disponible</p>
                </div>
                
                <div class="card-content">
                    <c:if test="${param.success != null}">
                        <div class="alert alert-success">
                            <strong>✅ Succès :</strong> Prêt enregistré avec succès !
                        </div>
                    </c:if>
                    
                    <c:if test="${not empty error}">
                        <div class="alert alert-danger">
                            <strong>❌ Erreur :</strong> ${error}
                        </div>
                    </c:if>
                    
                    <form method="post" action="/prets" class="form">
                        <div class="form-grid">
                            <div class="form-group">
                                <label for="adherentId" class="form-label">
                                    👤 Adhérent
                                </label>
                                <select id="adherentId" name="adherentId" class="form-select" required>
                                    <option value="">Sélectionnez un adhérent</option>
                                    <c:forEach var="adherent" items="${adherents}">
                                        <option value="${adherent.idAdherent}">
                                            ${adherent.nom} ${adherent.prenom} - ${adherent.email}
                                        </option>
                                    </c:forEach>
                                </select>
                            </div>
                            
                            <div class="form-group">
                                <label for="exemplaireId" class="form-label">
                                    📖 Exemplaire
                                </label>
                                <select id="exemplaireId" name="exemplaireId" class="form-select" required>
                                    <option value="">Sélectionnez un livre</option>
                                    <c:forEach var="ex" items="${exemplaires}">
                                        <option value="${ex.idExemplaire}">
                                            ${ex.livre.titre} - ${ex.livre.auteur} (État: ${ex.etat})
                                        </option>
                                    </c:forEach>
                                </select>
                            </div>
                            
                            <div class="form-group">
                                <label for="emplacementId" class="form-label">
                                    📍 Emplacement
                                </label>
                                <select id="emplacementId" name="emplacementId" class="form-select" required>
                                    <option value="">Sélectionnez un emplacement</option>
                                    <c:forEach var="emplacement" items="${emplacements}">
                                        <option value="${emplacement.idEmplacement}">
                                            ${emplacement.typeEmplacement}
                                        </option>
                                    </c:forEach>
                                </select>
                            </div>
                            
                            <div class="form-group">
                                <label for="datePret" class="form-label">
                                    📅 Date de prêt
                                </label>
                                <input 
                                    type="date" 
                                    id="datePret"
                                    name="datePret" 
                                    class="form-input"
                                    required 
                                />
                                <small class="form-help">Date de début du prêt</small>
                            </div>
                            
                            <div class="form-group">
                                <label for="dateRetourPrevue" class="form-label">
                                    📅 Date de retour prévue
                                </label>
                                <input 
                                    type="date" 
                                    id="dateRetourPrevue"
                                    name="dateRetourPrevue" 
                                    class="form-input"
                                    required 
                                />
                                <small class="form-help">Date limite pour le retour du livre</small>
                            </div>
                            
                            <div class="form-group">
                                <label for="statutId" class="form-label">
                                    🏷️ Statut du prêt
                                </label>
                                <select id="statutId" name="statutId" class="form-select" required>
                                    <option value="">Sélectionnez un statut</option>
                                    <c:forEach var="statut" items="${statuts}">
                                        <option value="${statut.idStatut}">${statut.libelle}</option>
                                    </c:forEach>
                                </select>
                            </div>
                        </div>
                        
                        <div class="btn-group">
                            <button type="submit" class="btn btn-primary">
                                ✅ Enregistrer le prêt
                            </button>
                            <a href="/adherents" class="btn btn-secondary">
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