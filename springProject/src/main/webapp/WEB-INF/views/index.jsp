<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>
<html>
<head>
	<title>Home</title>
	<link rel="stylesheet" href="/resources/footer.css" />
	<style type="text/css">
		h5 { padding-left: 30px }
	</style>
</head>
<body>
<jsp:include page="common/header.jsp" />
<jsp:include page="common/nav.jsp" />

<div id="wrapper">
<br>
<h5>
	The time on the server is ${serverTime}.
</h5>
</div>

<jsp:include page="common/footer.jsp" />
</body>
</html>
