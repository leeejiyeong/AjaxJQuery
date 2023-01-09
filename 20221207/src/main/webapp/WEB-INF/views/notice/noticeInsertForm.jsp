<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<div align="center">
	<div><h1>공지사항 등록</h1></div>
	<div>
		<form id="frm" action="noticeInsert.do" method="post" enctype="multipart/form-data">
			<div>
				<table border="1">
					<tr>
						<th width="150">작성자</th>
						<td width="200">
							<input type="text" id="noticeWriter" name="noticeWriter" value= "${name}" readonly="readonly">
						</td>
						<th width="150">작성일자</th>
						<td width="200">
							<input type="date" id="noticeDate" name="noticeDate" required="required">
						</td>
					</tr>
					<tr>
						<th>제 목</th>
						<td colspan="3">
							<input type="text"  size="78" id="noticeTitle" name="noticeTitle" required="required">						</td>
					</tr>	
					<tr>
						<th>내 용</th>
						<td colspan="3">
							<textarea rows="10" cols="75" id="noticeSubject" name="noticeSubject"></textarea>
						</td>
					</tr>				
					<tr>
						<th>첨부파일</th>
						<td colspan="3">
							<input type="file" id="nfile" name="nfile">
						</td>
					</tr>							
				</table>
			</div><br>
			<div>
				<input type="submit" value="등록">&nbsp;&nbsp;
				<input type="reset" value="취소">
			</div>
		</form>
	</div>
</div>
</body>
</html>