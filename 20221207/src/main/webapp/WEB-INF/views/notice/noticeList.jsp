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
<div align="center">
	<div><h1>공지사항 목록</h1></div>
	<div>
		<table border="1">
			<thead>
				<tr>
					<th width="70" align="center">순번</th>
					<th width="250" align="center">제 목</th>
					<th width="150" align="center">작성자</th>
					<th width="150" align="center">작성일자</th>
					<th width="150" align="center">조회수</th>
				</tr>
			</thead>
			<tbody>
				<c:if test="${empty notices }">
					<tr>
						<td colspan="5" align="center">게시글이 없습니다.</td>
					</tr>
				</c:if>
				<c:if test="${not empty notices }">
					<c:forEach items="${notices }" var="n">
						<tr onmouseover="this.style.background='#fcecae'" 
							onmouseleave="this.style.background='#FFFFFF'"
							onclick="noticeSelect('${n.noticeId}')">
							<td align="center">${n.noticeId }</td>
							<td align="center">${n.noticeTitle }</td>
							<td align="center">${n.noticeWriter }</td>
							<td align="center">${n.noticeDate }</td>
							<td align="center">${n.noticeHit }</td>
						</tr>					
					</c:forEach>
				</c:if>
			</tbody>
		</table>
	</div><br>
	<div>
		<form id="frm" action="noticeSelect.do" method="post">
			<c:if test="${not empty id }">
				<input type="button" value="글작성" onclick="location.href='noticeInsertForm.do'">
			</c:if>
			<input type="hidden" id="noticeId" name="noticeId">
		</form>
	</div>
</div>
<script type="text/javascript">
	function noticeSelect(id) {  //선택글 상세보기
		document.getElementById("noticeId").value = id;
		frm.submit();
	}
</script>

</body>
</html>