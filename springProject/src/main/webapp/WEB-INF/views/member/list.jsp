<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
    <%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<jsp:include page="../common/header.jsp" />
<jsp:include page="../common/nav.jsp" />
<c:set value="${list }" var="mvo" />
<div class="container">	
<table class="table table-hover">
		<thead>
		<tr>
			<th>E-mail ID</th>
			<th>Nick Name</th>
			<th>Reg Date</th>
			<th>Last Login</th>
			<th>Auth</th>
		</tr>
		</thead>
		<tbody>
		<c:forEach items="${memList}" var="mvo">
			<tr>
				<td><a href="/member/detail?email=${mvo.email }&writer=${mvo.nickName }">${mvo.email }</a></td>
				<td>${mvo.nickName }</td>
				<td>${mvo.regAt }</td>
				<td>${mvo.lastLogin }</td>
				<td><c:forEach items="${mvo.authList }" var="authList">
				${authList.auth }
				
				</c:forEach></td>
			</tr>	
		</c:forEach>
		</tbody>	
	</table>
</div>
</body>
</html>