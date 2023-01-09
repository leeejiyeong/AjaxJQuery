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
	<div><h1>회원정보 수정</h1></div>
	<div>
		<form id="frm" action="memberUpdate.do" method="post">
			<div>
				<table border="1">
					<tr>
							<th width="150">아이디</th>
							<td width="300">${member.memberId }</td>
					</tr>
					<tr>
						<th>이름</th>
						<td>
							<input type="text" name="memberName" value="${member.memberName}">
						</td>
					</tr>
					<tr>
						<th>패스워드</th>
						<td>
							<input type="password" name="memberPassword">
						</td>
					</tr>
					<tr>
						<th>나이</th>
						<td>
							<input type="text" name="memberAge" value="${member.memberAge }">
						</td>
					</tr>
					<tr>
						<th>주소</th>
						<td>
							<input type="text" name="memberAddress" value="${member.memberAddress }">
						</td>
					</tr>
					<tr>
						<th>전화번호</th>
						<td>
							<input type="tel" name="memberTel" value="${member.memberTel }">
						</td>
					</tr>
					<tr>
						<th>권 한</th>
						<td>
							<input type="text" name="memberAuthor" value="${member.memberAuthor }">
						</td>
					</tr>
				</table>
			</div><br>
			<div>
				<input type="hidden" name="memberId" value="${member.memberId }">
				<input type="submit" value="수정">&nbsp;&nbsp;
				<input type="button" value="취소" onclick="location.href='memberList.do'">
			</div>
		</form>
	</div>
</div>
</body>
</html>