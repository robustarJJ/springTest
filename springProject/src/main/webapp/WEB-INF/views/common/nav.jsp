<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
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
        <li class="nav-item">
          <a class="nav-link" href="/board/register">Board Reg</a>
        </li>
        <li class="nav-item">
          <a class="nav-link" href="/member/register">SinUp</a>
        </li>
        <li class="nav-item">
          <a class="nav-link" href="/member/login">LogIn</a>
        </li>
        <li class="nav-item">
          <a class="nav-link" href="/member/logout">LogOut</a>
        </li>
      </ul>
    </div>
  </div>
</nav>
<br>

</body>
</html>