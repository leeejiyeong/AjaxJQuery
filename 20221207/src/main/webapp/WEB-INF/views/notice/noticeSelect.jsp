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
	<div><h1>공지사항 상세내역</h1></div>
	<div>
		<table border="1">
			<tr>
				<th width="150">작성자</th>
				<td width="200">${notice.noticeWriter }</td>
				<th width="150">작성일자</th>
				<td width="200">${notice.noticeDate}</td>
			</tr>
			<tr>
				<th>제 목</th>
				<td colspan="3">${notice.noticeTitle }</td>
			</tr>	
			<tr>
				<th>내 용</th>
				<td colspan="3">
					<textarea rows="10" cols="50">${notice.noticeSubject }</textarea>
				</td>
			</tr>				
			<tr>
				<th>첨부파일</th>
				<td colspan="3">${notice.noticeFile }</td>
			</tr>							
		</table>
	</div><br>
	<div>
		<form id="frm" method="post">
			<c:if test="${name eq notice.noticeWriter }">
				<button type="button" onclick="noticeEdit('E')">글수정</button>
				<button type="button" onclick="noticeEdit('D')">글삭제</button>
			</c:if>
			<input type="hidden" name="${notice.noticeId }">
		</form>
	</div>
</div>
<script type="text/javascript">
	function noticeEdit(str) {
		if(str == 'E') {
			frm.action="noticeEditForm.do";
		}else {
			let yn = confirm("작성글을 삭제하겠나?");
			if(yn) {
				frm.action="noticeDelete.do";
			}else{
				return false;
			}
		}
		
		frm.submit();
	}
</script>
</body>
</html>