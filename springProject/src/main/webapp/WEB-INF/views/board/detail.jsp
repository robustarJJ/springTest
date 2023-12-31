<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
    <%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
    <%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
	.cmtQty{ color: red; }
	.cmtCon{ width: 70% }
	.noneCmt{ list-style: none; opacity: 0.5; }
	ul{list-style: none; padding-left:0px;}
</style>
</head>
<body>
<jsp:include page="../common/header.jsp"></jsp:include>
<jsp:include page="../common/nav.jsp" />
<c:set value="${bdto.bvo }" var="bvo"></c:set>

<sec:authorize access="isAuthenticated()"><!-- <=비회원으로 접속시 아래코드 사용x -->
<sec:authentication property="principal.mvo.email" var="authEmail"/>
<sec:authentication property="principal.mvo.nickName" var="authNickName"/>
<sec:authentication property="principal.mvo.authList" var="authList"/>

</sec:authorize>

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
		<td>${bvo.content }
			<div>
				<!-- 파일표시란 -->
				<c:set value="${bdto.flist }" var="flist"></c:set>
				<ul class="list-group list-group-flush">
					<c:forEach items="${flist }" var="fvo">
						<li>
							<c:choose>
								<c:when test="${fvo.fileType > 0 }">
									<div>
										<img alt="그림없음" src="/upload/${fn: replace(fvo.saveDir,'\\','/')}/${fvo.uuid}_${fvo.fileName}">
									</div>
								</c:when>
							</c:choose>
						</li>
					</c:forEach>
				</ul>
			</div>
		
		
		</td>
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
<!-- file 표시 영역 -->
<div>
	<ul class="list-group">
		<!-- 파일 개수만큼 li를 추가하여 파일을 표시, 타입이 1(이미지파일)일 경우만 표시 -->
		<!-- li 
			 div=>img 그림표시
			 div=>div 파일이름, 작성일자 span 크기 설정 -->
			 
			 <!-- 하나의 파일만 따와서 fvo로 저장 -->
			 <c:forEach items="${flist }" var="fvo">
				 <li class="list-group-item d-flex justify-content-between align-items-center">
				 	<c:choose>
				 		<c:when test="${fvo.fileType > 0 }">
				 			<div>
				 			<!-- /upload/year/month/day/uuid_th_file_name -->
				 				<img alt="그림이 없음." src="/upload/${fn: replace(fvo.saveDir,'\\','/')}/${fvo.uuid}_th_${fvo.fileName}">
				 			</div>
				 		</c:when>
				 		<c:otherwise>
				 			<div>
				 				<!-- file 아이콘 같은 모양 값으로 넣을 수 있음. -->
				 			</div>
				 		</c:otherwise>
				 	</c:choose>
				 	<div>
				 		<div>${fvo.fileName }</div>
				 		${fvo.regDate }
				 	</div>
				 	<span class="badge bg-primary rounded-pill">${fvo.fileSize }Byte</span>
				 </li>
			 </c:forEach>
	</ul>
</div>

<br>
	
	<c:set var="authValue" value="${authList }"/>
	<c:if test="${(authNickName ne null && authNickName==bvo.writer)}">
		<a href="/board/modify?bno=${bvo.bno }">
			<button type="button" class="btn btn-dark">수정하기</button>
		</a>
		<a href="/board/remove?bno=${bvo.bno }">
			<button type="button" class="btn btn-danger">삭제하기</button>
		</a>
	</c:if>
		<a href="/">
			<button type="button" class="btn btn-light">HOME</button>
		</a>
		<a href="/board/list">
			<button type="button" class="btn btn-light">LIST</button>
		</a>
</div>
<br><br><br>




<!-- 댓글 라인 등록 라인 -->
<div class="container">
	<!-- 댓글카운트 -->
	<div id="cmtCount">
		Comment(<span class="cmtQty">${bvo.cmtQty}</span>)
	</div>

<sec:authorize access="isAuthenticated()"> <!-- 비회원댓글작성막기 -->
	<div class="cmtCon">
		<div class="input-group mb-3">
		  <span class="input-group-text" id="cmtWriter">${authNickName }</span>
		  <input type="text" class="form-control input" placeholder="댓글을 등록해 주세요" id="cmtText">
		  <button type="button" class="btn btn-secondary" id="cmtPostBtn">Post</button>
		</div>
	</div>
</sec:authorize>


<!-- 댓글 표시 라인 -->
	<ul class="list-group list-group-flush" id="cmtListArea">
	  <li class="list-group-item">
	  	<div class="mb-3">
	  	<span class="fw-bold">${authNickName }</span>
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
        <h5 class="modal-title">${authNickName }</h5>
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

<script type="text/javascript"  src="/resources/js/boardComment.js">
</script>

<script type="text/javascript">
	getCommentList(bnoVal)
</script>

<!-- 게시글 수정 시 -> return "redirect:/board/detail?bno="+bvo.getBno(); -->
<script type="text/javascript">
		const isOk = `<c:out value="${isOk}"></c:out>`
		if(isOk==1){
			alert('게시글이 수정 되었습니다.');
		}
</script>	

<script type="text/javascript">
	const authEmail = `${authEmail}`;
	const authNickName = `${authNickName}`;
	const auth = `${authList}`;
			console.log(auth.substr(auth.lastIndexOf("=")+1, 10));
			console.log(typeof auth);
	let admin = auth.substr(auth.lastIndexOf("=")+1, 10);
	if(admin == 'ROLE_ADMIN'){
	console.log(authNickName+' 권한: '+admin);
	}
</script>


<jsp:include page="../common/footer.jsp" />
</body>
</html>