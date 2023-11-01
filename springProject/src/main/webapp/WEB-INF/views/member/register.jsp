<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<jsp:include page="../common/header.jsp" />
<jsp:include page="../common/nav.jsp" />
<!-- email, pwd, nick_name  -->
<div class="container">
<form action="/member/register" method="post">
	<h4 class="mb-3">Input your Information</h4>
	<div class="mb-3">
	  <label for="e" class="form-label" id="e" >email</label>
	  <input type="text" class="form-control" name="email" id="exampleFormControlInput1" placeholder="abc@ooo.com">
	</div>
	<div class="mb-3">
	  <label for="p" class="form-label">pwd</label>
	  <input type="password" class="form-control" name="pwd" id="p">
	</div>
	<div class="mb-3">
	  <label for="n" class="form-label">nick_name</label>
	  <input type="text" class="form-control" name="nickName" id="n">
	</div>

	<div>
	<button type="submit" class="btn btn-dark" id="regBtn">SinUp</button>
</div>
</form>
</div>
<jsp:include page="../common/footer.jsp" />
</body>
</html>