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
<h2>Member Modify Page</h2>
<br>


<form action="/member/modify" method="post">
	<table class="table table-hover">
		<tr>
			<th>이메일ID</th>
			<td><input type="email" value="${mvo.email }" name="email" readonly="readonly"></td>
		</tr>	
		<tr>
			<th>비밀번호</th>
			<td><input type="password" value="" name="pwd"></td>
		</tr>	
		<tr>
			<th>닉네임</th>
			<td><input type="text" value="${mvo.nickName }" name="nickName"></td>
		</tr>
	</table>	
	<button type="submit" class="btn btn-dark"> 수정완료 </button>
	<a href="/"><button type="button" class="btn btn-dark"> 메인으로 </button></a>
	<a href="/member/remove?email=${mvo.email }"><button type="button" class="btn btn-danger"> 회원탈퇴 </button></a>
</form>
</div>
</body>
</html>