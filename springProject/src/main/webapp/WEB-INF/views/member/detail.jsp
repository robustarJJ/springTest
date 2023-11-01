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
<jsp:include page="../common/header.jsp"></jsp:include>
<jsp:include page="../common/nav.jsp" />
<c:set value="${memDetail }" var="mvo" />
<div class="container">
<br>
<h2>Member Detail Page</h2>
<br>
<table class="table table-hover">
	<tr>
		<th>이메일ID</th>
		<td>${mvo.email }</td>
	</tr>	
	<tr>
		<th>닉네임</th>
		<td>${mvo.nickName }</td>
	</tr>	
	<tr>
		<th>가입일</th>
		<td>${mvo.regAt }</td>
	</tr>
</table>	

<a href="/member/modify?email=${mvo.email }">
	<button type="button" class="btn btn-dark">회원정보수정</button>
</a>
</div>
</body>
</html>