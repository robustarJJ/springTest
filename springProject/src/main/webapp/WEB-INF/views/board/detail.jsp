<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
	.cmtQty{ color: red; }
	.cmtCon{ width: 70% }
	.noneCmt{ list-style: none; opacity: 0.5; }
</style>
</head>
<body>
<jsp:include page="../common/header.jsp"></jsp:include>
<jsp:include page="../common/nav.jsp" />
<div class="container">
<br>
<h2>Detail Page</h2>
<table class="table table-hover">
	<tr>
		<th>#</th>
		<td>${bvo.bno }</td>
	</tr>	
	<tr>
		<th>제목</th>
		<td>${bvo.title }</td>
	</tr>	
	<tr>
		<th>작성자</th>
		<td>${bvo.writer }</td>
	</tr>	
	<tr>
		<th>내용</th>
		<td>${bvo.content }</td>
	</tr>
	<tr>
		<th>작성일</th>
		<td>${bvo.regAt }</td>
	</tr>	
	<tr>
		<th>조회수</th>
		<td>${bvo.readCount }</td>
	</tr>	
</table>
<br>

<a href="/board/modify?bno=${bvo.bno }">
	<button type="button" class="btn btn-dark">수정하기</button>
</a>
<a href="/board/remove?bno=${bvo.bno }">
	<button type="button" class="btn btn-danger">삭제하기</button>
</a>
<a href="/">
	<button type="button" class="btn btn-light">HOME</button>
</a>
<a href="/board/list">
	<button type="button" class="btn btn-light">LIST</button>
</a>
<c:if test="${ses.id ne null && ses.id == bvo.writer || ses.id=='admin'}">
</c:if>
<c:if test="${ses.id ne null && ses.id == bvo.writer || ses.id=='admin'}">
</c:if>
</div>
<br><br><br>



<!-- 댓글 라인 -->
<div class="container">
	<!-- 댓글카운트 -->
	<div id="cmtCount">
		Comment(<span class="cmtQty">${bvo.cmtQty}</span>)
	</div>

	<div class="cmtCon">
		<div class="input-group mb-3">
		  <span class="input-group-text" id="cmtWriter">Writer</span>
		  <input type="text" class="form-control input" placeholder="댓글을 등록해 주세요" id="cmtText">
		  <button type="button" class="btn btn-secondary" id="cmtPostBtn">Post</button>
		</div>
	</div>


<!-- 댓글 표시 라인 -->
	<ul class="list-group list-group-flush" id="cmtListArea">
	  <li class="list-group-item">
	  	<div class="mb-3">
	  	<span class="fw-bold">Writer</span>
	  	<span class="badge text-bg-secondary">modAt</span>
	  		<div>Content</div>
	  	</div>
		<button type="button" class="btn btn-outline-primary">%</button> 
		<button type="button" class="btn btn-outline-secondary cmtDelBtn">X</button>
	  </li>
	</ul>


<!-- 댓글 페이징 라인 -->
<div>
	<div>
		<button type="button" id="moreBtn" data-page="1" class="btn btn-outline-dark" style="visibility:hidden">MORE+</button>
	</div>
</div>


<!-- 모달창 라인 -->
<div class="modal" id="myModal" tabindex="-1">
  <div class="modal-dialog">
    <div class="modal-content">
    
      <div class="modal-header">
        <h5 class="modal-title">Wirter</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      
      <div class="modal-body">
        <input type="text" class="form-control" placeholder="댓글을 등록해 주세요" id="cmtTextMod">
	  	<button type="button" class="btn btn-secondary" id="cmtModBtn">Post</button>
      </div>
      
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
      </div>

    </div>
  </div>
</div>

</div>
<br><br>



<script type="text/javascript">
	let bnoVal = `<c:out value="${bvo.bno}" />`;
	console.log(bnoVal);
</script>
<script type="text/javascript"  src="/resources/js/boardComment.js"></script>
<script type="text/javascript">
	getCommentList(bnoVal)
</script>



	<jsp:include page="../common/footer.jsp" />	
</body>
</html>