<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
	ul{list-style: none; padding-left:0px;}
</style>
</head>
<body>
	<jsp:include page="../common/header.jsp" />
	<jsp:include page="../common/nav.jsp" />
	<c:set value="${bdto.bvo }" var="bvo"></c:set>
<div class="container">
	
	<h2>Modify Page</h2>

	<form action="/board/modify" method="post" enctype="multipart/form-data">
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
		<td>
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
			<br>
		<textarea rows="5" cols="50" name="content">${bvo.content }</textarea></td>
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

<!-- file 표시 영역 -->
<div>
	<ul>
		<!-- 파일 개수만큼 li를 추가하여 파일을 표시, 타입이 1(이미지파일)일 경우만 표시 -->
		<!-- li 
			 div=>img 그림표시
			 div=>div 파일이름, 작성일자 span 크기 설정 -->
			 
			 <!-- 하나의 파일만 따와서 fvo로 저장 -->
			 <c:forEach items="${flist }" var="fvo">
				 <li>
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
				 		<div><B>${fvo.fileName }</B></div>
				 		<div class="badge text-bg-secondary">${fvo.regDate }</div>
				 	</div>
				 	<span class="badge rounded-pill text-bg-success">${fvo.fileSize }Byte</span>
				 	<div>
				 		<button type="button" class="file-x btn btn-outline-secondary" data-uuid="${fvo.uuid }">X</button>
				 	</div>
				 	<br>	
				 </li>
			 </c:forEach>
	</ul>
</div>

<div class="mb-3" id="fileZone">
<!-- 첨부파일 표시 영역 -->
</div>
<div class="mb-3">
  <input type="file" class="form-control" name="files" id="files" style="display: none;" multiple="multiple">
  <!-- input button trigger 용도의 button -->
  <button type="button" id="trigger" class="btn btn-outline-primary">File Upload</button>
</div>





	<button type="submit" id="regBtn" class="btn btn-dark">수정완료</button>
	<a href="/board/list">
	<button type="button" class="btn btn-danger">수정취소</button>
	</a>
	</form>

</div>
	<script type="text/javascript" src="/resources/js/boardModify.js"></script>
	<script type="text/javascript" src="/resources/js/boardRegister.js"></script>
	<jsp:include page="../common/footer.jsp" />
</body>
</html>