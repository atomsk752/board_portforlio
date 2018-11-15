<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

<h1>Custom Login Page</h1>
<h2><c:out value="${error}"></c:out></h2>
<h2><c:out value="${logout}"></c:out></h2>
<form action="/login" method="post">
<input type="text" name="username" value="admin">
<input type="password" name="password" value="admin">
<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">
<input type="checkbox" name="remember-me">REMEMBER ME
<button type="submit">LOGIN</button>
</form>
</body>
</html>