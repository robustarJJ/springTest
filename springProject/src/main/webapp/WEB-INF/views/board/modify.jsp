<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<jsp:include page="../common/header.jsp" />
	<jsp:include page="../common/nav.jsp" />
<div class="container">
	
	<h2>Modify Page</h2>

	<form action="/board/modify" method="post">
	<table class="table table-hover">
	<tr>
		<th>#</th>
		<td><input type="text" name="bno" readonly="readonly" value="${bvo.bno }" ></td>
	</tr>	
	<tr>
		<th>제목</th>
		<td><input type="text" name="title" value="${bvo.title }" ></td>
	</tr>	
	<tr>
		<th>작성자</th>
		<td><input type="text" name="writer" value="${bvo.writer }" readonly="readonly" ></td>
	</tr>	
	<tr>
		<th>내용</th>
		<td><textarea rows="5" cols="50" name="content">${bvo.content }</textarea></td>
	</tr>	
	<tr>
		<th>작성일</th>
		<td>${bvo.regAt }</td>
	</tr>	
	<tr>
		<th>수정일</th>
		<td>${bvo.modAt }</td>
	</tr>	
	</table>
<br>
	<button type="submit" id="regBtn">수정완료</button>
	</form>

	<a href="/board/list">
	<button type="button">취소</button>
	</a>
</div>
	<jsp:include page="../common/footer.jsp" />
</body>
</html>