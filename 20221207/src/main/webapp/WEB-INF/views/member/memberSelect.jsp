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
<br>
<br>

	${member.memberName } : ${member.memberAuthor }<br>
	
	<button type="button" onclick="memberEdit('E')">회원정보수정</button> &nbsp;&nbsp;
	<button type="button" onclick="memberEdit('D')">회원정보삭제</button><br>
	<form id="frm" method="post">
		<input type="hidden" name="memberId" value="${member.memberId }">
	</form>	
</div>
<br>
<script type="text/javascript">
	function memberEdit(str){
		if(str == 'E') {
			frm.action="memberEdit.do";
		}else {
			let yn = confirm("회원정보를 삭제합니다.");
			if(yn){
				frm.action="memberDelete.do";
			}else {
				return false;
			}			
		}
		
		frm.submit();
	}
</script>
</body>
</html>