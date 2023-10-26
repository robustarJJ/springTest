<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
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
	
	<!-- 검색라인 -->
	<div class="col-sm-12 col-md-6">
		<form action="/board/list" method="get">
			<div class="input-group mb-3">
			<c:set value="${ph.pgvo.type}" var="typed"></c:set>
				<select class="form-select" name="type" id="inputGroupSelect01">
		    		<option ${typed eq null ? 'selected' : '' }>Choose...</option>
		    		<option value="t" ${typed eq 't' ? 'selected' : '' }>제목</option>
		    		<option value="w" ${typed eq 'w' ? 'selected' : '' }>작성자</option>
		    		<option value="c" ${typed eq 'c' ? 'selected' : '' }>내용</option>
		    		<option value="tw" ${typed eq 'tw' ? 'selected' : '' }>제목 + 작성자</option>
		    		<option value="tc" ${typed eq 'tc' ? 'selected' : '' }>제목 + 내용</option>
		    		<option value="cw" ${typed eq 'cw' ? 'selected' : '' }>내용 + 작성자</option>
		    		<option value="twc" ${typed eq 'twc' ? 'selected' : '' }>모두</option>
	  			</select>
	        	<input class="form-control me-2" name="keyword" type="search" value="${ph.pgvo.keyword }" placeholder="Search" aria-label="Search">
	        	<input type="hidden" name="pageNo" value="1">
	        	<input type="hidden" name="qty" value="${ph.pgvo.qty }">
	        	<button class="btn btn-outline-success" type="submit">
	        		Search
	        		<span class="position-absolute top-0 start-100 translate-middle badge rounded-pill bg-danger">
    					${ph.totalCount }
    				<span class="visually-hidden">unread messages</span>
  					</span>
	        	</button>
	        </div>
	      </form>
      </div>


	<table class="table table-hover">
		<thead>
		<tr>
			<th>#</th>
			<th>제목</th>
			<th>작성자</th>
			<th>작성일</th>
			<th>조회수</th>
			<th>댓글수</th>
			<th>파일수</th>
		</tr>
		</thead>
		<tbody>
		<c:forEach items="${list}" var="bvo">
			<tr>
				<td>${bvo.bno }</td>
				<td><a href="/board/detail?bno=${bvo.bno }&writer=${bvo.writer }">${bvo.title }</a></td>
				<td>${bvo.writer }</td>
				<td>${bvo.regAt }</td>
				<td>${bvo.readCount }</td>
				<td>${bvo.cmtQty }</td>
				<td>${bvo.hasFile }</td>
			</tr>	
		</c:forEach>
		</tbody>	
	</table>
	
	<!-- 페이징 라인 -->
	<nav aria-label="Page navigation example">
  	<ul class="pagination">
  	<!-- 이전 -->
    <li class="page-item ${(ph.prev eq false) ? 'disabled' : ''}">
      <a class="page-link" href="/board/list?pageNo=${ph.startPage - 1}&qty=${ph.pgvo.qty}&type=${ph.pgvo.type}&keyword=${ph.pgvo.keyword}" aria-label="Previous">
        <span aria-hidden="true">&laquo;</span>
      </a>
    </li>
  	<c:forEach begin="${ph.startPage }" end="${ph.endPage }" var="i">
  		<li><a class="page-link" href="/board/list?pageNo=${i }&qty=${ph.pgvo.qty}&type=${ph.pgvo.type}&keyword=${ph.pgvo.keyword}">${i }</a></li>
  	</c:forEach>
    <!-- 다음 -->
    	<li class="page-item ${(ph.next eq false) ? 'disabled' : ''}">
    	<a class="page-link" href="/board/list?pageNo=${ph.endPage + 1 }&qty=${ph.pgvo.qty}&type=${ph.pgvo.type}&keyword=${ph.pgvo.keyword}" aria-label="Next">
        <span aria-hidden="true">&raquo;</span>
    	</a>
		</li> 
  	</ul>
	</nav>
	
</div>

	<script type="text/javascript">
	// 게시글 삭제 시 -> return "redirect:/board/list";
		const isOk = `<c:out value="${isOk}"></c:out>`
		if(isOk==1){
			alert('게시글을 삭제 하였습니다.');
		}
	
	// 게시글 등록 시 -> 
		const isUp = `<c:out value="${isUp}"></c:out>`
		console.log("isUP"+isUp);
		if(isUp=="1"){
			alert('게시글을 등록 하였습니다.');
		}
	</script>
	

	<jsp:include page="../common/footer.jsp" />
</body>
</html>