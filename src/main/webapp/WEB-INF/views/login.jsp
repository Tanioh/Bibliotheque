<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<html>
<head>
    <title>Connexion Adhérent</title>
</head>
<body>
    <h1>Connexion Adhérent</h1>
    <c:if test="${not empty error}">
        <p style="color:red;">${error}</p>
    </c:if>
    <form method="post" action="/login">
        <label>Nom :</label>
        <input type="text" name="nom" required><br>
        <label>Email :</label>
        <input type="email" name="email" required><br>
        <button type="submit">Se connecter</button>
    </form>
</body>
</html>
