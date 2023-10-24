<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Register Page</title>
</head>
<body>
<jsp:include page="../common/header.jsp" />
<jsp:include page="../common/nav.jsp" />
<div class="container">
<form action="/board/register" method="post" enctype="multipart/form-data">
<div class="mb-3">
  <label for="exampleFormControlInput1" class="form-label">Title</label>
  <input type="text" class="form-control" name="title" id="exampleFormControlInput1" placeholder="제목입력">
</div>
<div class="mb-3">
  <label for="exampleFormControlInput1" class="form-label">Writer</label>
  <input type="text" class="form-control" name="writer" id="exampleFormControlInput1" placeholder="writer">
</div>
<div class="mb-3">
  <label for="exampleFormControlTextarea1" class="form-label">Content</label>
  <textarea class="form-control" name="content" id="exampleFormControlTextarea1" rows="3"></textarea>
</div>
<div class="mb-3">
  <input type="file" class="form-control" name="files" id="files" style="display: none;" multiple="multiple">
  <!-- input button trigger 용도의 button -->
  <button type="button" id="trigger" class="btn btn-outline-primary">File Upload</button>
</div>
<div class="mb-3" id="fileZone">
<!-- 첨부파일 표시 영역 -->
</div>
<div>
<button type="submit" class="btn btn-dark" id="regBtn">등록</button>
</div>

	<script type="text/javascript">
		const isUp = `<c:out value="${isUp}"></c:out>`
		console.log("isUP"+isUp);
		if(isUp=="2"){
			alert('제목을 입력해 주세요.');
		}
	</script>
	<script type="text/javascript" src="/resources/js/boardRegister.js"></script>
</form>
</div>

</body>
</html>