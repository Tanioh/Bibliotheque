<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Nouvel Abonnement</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/static/css/style.css">
    <style>
        .form-group { margin-bottom: 15px; }
        .form-group label { display: block; margin-bottom: 5px; font-weight: bold; }
        .form-group input, .form-group select { width: 100%; padding: 8px; border: 1px solid #ddd; border-radius: 4px; }
        .btn { padding: 10px 20px; margin: 5px; text-decoration: none; border: none; border-radius: 4px; cursor: pointer; }
        .btn-primary { background-color: #007bff; color: white; }
        .btn-secondary { background-color: #6c757d; color: white; }
        .checkbox-group { display: flex; align-items: center; }
        .checkbox-group input[type="checkbox"] { width: auto; margin-right: 10px; }
    </style>
</head>
<body>
    <div class="container">
        <h1>Créer un Nouvel Abonnement</h1>
        
        <c:if test="${not empty error}">
            <div class="alert alert-danger">${error}</div>
        </c:if>
        
        <form method="post" action="${pageContext.request.contextPath}/abonnements/creer">
            <div class="form-group">
                <label for="idAdherent">Adhérent :</label>
                <select id="idAdherent" name="idAdherent" required>
                    <option value="">Sélectionnez un adhérent</option>
                    <c:forEach var="adherent" items="${adherents}">
                        <option value="${adherent.idAdherent}">${adherent.nom} ${adherent.prenom} (${adherent.email})</option>
                    </c:forEach>
                </select>
            </div>
            
            <div class="form-group">
                <label for="typeAbonnement">Type d'Abonnement :</label>
                <select id="typeAbonnement" name="typeAbonnement" required>
                    <option value="">Sélectionnez un type</option>
                    <option value="mensuel">Mensuel</option>
                    <option value="trimestriel">Trimestriel</option>
                    <option value="semestriel">Semestriel</option>
                    <option value="annuel">Annuel</option>
                    <option value="etudiant">Étudiant</option>
                    <option value="senior">Senior</option>
                </select>
            </div>
            
            <div class="form-group">
                <label for="dateDebut">Date de Début :</label>
                <input type="date" id="dateDebut" name="dateDebut" required>
            </div>
            
            <div class="form-group">
                <label for="dateFin">Date de Fin :</label>
                <input type="date" id="dateFin" name="dateFin" required>
            </div>
            
            <div class="form-group">
                <label for="prix">Prix (€) :</label>
                <input type="number" id="prix" name="prix" step="0.01" min="0" required placeholder="0.00">
            </div>
            
            <div class="form-group">
                <div class="checkbox-group">
                    <input type="checkbox" id="autoRenouvellement" name="autoRenouvellement" value="true">
                    <label for="autoRenouvellement">Renouvellement automatique</label>
                </div>
            </div>
            
            <div class="form-actions">
                <button type="submit" class="btn btn-primary">Créer l'Abonnement</button>
                <a href="${pageContext.request.contextPath}/abonnements" class="btn btn-secondary">Annuler</a>
            </div>
        </form>
    </div>
    
    <script>
        // Auto-calculer la date de fin selon le type d'abonnement
        document.getElementById('typeAbonnement').addEventListener('change', function() {
            const dateDebut = document.getElementById('dateDebut').value;
            const prixInput = document.getElementById('prix');
            
            if (dateDebut) {
                const debut = new Date(dateDebut);
                let fin = new Date(debut);
                let prix = 0;
                
                switch(this.value) {
                    case 'mensuel':
                        fin.setMonth(fin.getMonth() + 1);
                        prix = 15.00;
                        break;
                    case 'trimestriel':
                        fin.setMonth(fin.getMonth() + 3);
                        prix = 40.00;
                        break;
                    case 'semestriel':
                        fin.setMonth(fin.getMonth() + 6);
                        prix = 75.00;
                        break;
                    case 'annuel':
                        fin.setFullYear(fin.getFullYear() + 1);
                        prix = 120.00;
                        break;
                    case 'etudiant':
                        fin.setFullYear(fin.getFullYear() + 1);
                        prix = 80.00;
                        break;
                    case 'senior':
                        fin.setFullYear(fin.getFullYear() + 1);
                        prix = 90.00;
                        break;
                }
                
                document.getElementById('dateFin').value = fin.toISOString().split('T')[0];
                prixInput.value = prix.toFixed(2);
            }
        });
        
        // Déclencher le calcul quand la date de début change
        document.getElementById('dateDebut').addEventListener('change', function() {
            const typeEvent = new Event('change');
            document.getElementById('typeAbonnement').dispatchEvent(typeEvent);
        });
        
        // Définir la date de début par défaut à aujourd'hui
        document.getElementById('dateDebut').value = new Date().toISOString().split('T')[0];
    </script>
</body>
</html>