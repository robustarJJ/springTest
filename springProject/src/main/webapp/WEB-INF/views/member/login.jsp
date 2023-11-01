<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
form{display: flex; justify-content: center;}
</style>
</head>
<body>
<jsp:include page="../common/header.jsp" />
<jsp:include page="../common/nav.jsp" />

<div class="container">
<form action="/member/login" method="post">
<div>
	<h4 class="mb-3">login page</h4>
	<div class="mb-3">
	  <label for="e" class="form-label" id="e" >email</label>
	  <input type="text" class="form-control" name="email" id="exampleFormControlInput1" placeholder="abc@ooo.com">
	</div>
	<div class="mb-3">
	  <label for="p" class="form-label">pwd</label>
	  <input type="password" class="form-control" name="pwd" id="p">
	</div>
	
	<c:if test="${not empty param.errMsg }">
		<div class="text-danger mb-3">
			<c:choose>
				<c:when test="${param.errMsg eq 'Bad credentials' }">
					<c:set var="errText" value="이메일 또는 비밀번호가 일치하지 않습니다." />
				</c:when>
				<c:otherwise>
					<c:set var="errText" value="로그인 에러. 관리자에게 문의하세요." />
				</c:otherwise>
			</c:choose>
			
			${errText}
		</div>
	</c:if>
	
	<div>
	<button type="submit" class="btn btn-dark" id="login">LOGIN</button>
</div>
</div>
</form>
</div>



<jsp:include page="../common/footer.jsp" />
</body>
</html>