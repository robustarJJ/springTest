<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
    <%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
	.container-fluid{
		padding: 30px;
		padding-bottom: 20px;
		padding-top: 10px;
	}
	/* #header {
		  position: fixed;
		  display: flex;
		  top: 50;
		  left: 0;
		  right: 0;
} */
</style>
</head>
<body >
<header>
<nav class="navbar navbar-expand-lg bg-body-tertiary" id="header">
  <div class="container-fluid">
    <a class="navbar-brand" href="/">Home</a>
    <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
      <span class="navbar-toggler-icon"></span>
    </button>
    <div class="collapse navbar-collapse" id="navbarNav">
      <ul class="navbar-nav">
        <li class="nav-item">
          <a class="nav-link" href="/board/list">Board List</a>
        </li>
        ${principal }
        <sec:authorize access="isAuthenticated()">
        <!-- 현재 인증한 사용자의 정보를 가져와서 해당 권한이 있는 케이스를 open -->
        <!-- 사용자 정보는 principal -->
        <sec:authentication property="principal.mvo.email" var="authEmail"/>
        <sec:authentication property="principal.mvo.nickName" var="authNickName"/>
        <sec:authentication property="principal.mvo.authList" var="auths"/>
        
        	<!-- admin 계정만 할 수 있는 일을 처리 -->
        <c:choose>
        	<c:when test="${auths.stream().anyMatch(authVO -> authVO.auth.equals('ROLE_ADMIN')).get() }">
	        	<li class="nav-item">
	        		<a class="nav-link" href="/member/list"> ADMIN > ${authNickName }(${authEmail })</a>
	        	</li>
        	</c:when>
        	<c:otherwise>
	        	<li class="nav-item">
	        		<a class="nav-link" href="/member/detail?email=${authEmail }">${authNickName }(${authEmail })</a>
	        	</li>
        	</c:otherwise>
        </c:choose>
        
        <!-- 로그인 해야 open 되는 메뉴들 -->
		<li class="nav-item">
			<a class="nav-link" href="/board/register">Board Reg</a>
		</li>
        
	    <li class="nav-item">
			<a class="nav-link" href="" id="logoutLink">LogOut</a>
	    </li>
	        <form action="/member/logout" method="post" id="logoutForm">
	        	<input type="hidden" name="email" value="${authEmail }">
	        </form>
        </sec:authorize>
        
        <!-- 아직 로그인 전 상태에서 open 되어야 할 메뉴 -->
        <sec:authorize access="isAnonymous()">
	        <li class="nav-item">
	          <a class="nav-link" href="/member/register">SinUp</a>
	        </li>
	        <li class="nav-item">
	          <a class="nav-link" href="/member/login">LogIn</a>
	        </li>
        </sec:authorize>
        
      </ul>
    </div>
  </div>
</nav>
<br>
</header>
<script type="text/javascript">
document.getElementById('logoutLink').addEventListener('click',(e)=>{
	e.preventDefault();
	document.getElementById('logoutForm').submit();
});
</script>
</body>
</html>