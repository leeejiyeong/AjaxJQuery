<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<style>
.center {
	text-align: center;
}

.pagination {
	display: inline-block;
}

.pagination a {
	color: black;
	float: left;
	padding: 8px 16px;
	text-decoration: none;
	transition: background-color .3s;
	border: 1px solid #ddd;
	margin: 0 4px;
}

.pagination a.active {
	background-color: #4CAF50;
	color: white;
	border: 1px solid #4CAF50;
}

.pagination a:hover:not(.active) {
	background-color: #ddd;
}
.right{
	float:right
}
</style>

<script src="js/jquery-3.6.3.min.js"></script>
<!DOCTYPE html>
<h3>노티스페이징폼</h3>
<hr>
<!-- insertForm start -->
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
							<input type="text"  size="78" id="noticeTitle" name="noticeTitle" required="required">						
						</td>
					</tr>	
					<tr>
						<th>내 용</th>
						<td colspan="3">
							<textarea rows="5" cols="75" id="noticeSubject" name="noticeSubject"></textarea>
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
<hr>
<!-- insertForm end -->

<div>
	showPage: <select id="perPage">
		<option value="5">5</option>
		<option value="10" selected>10</option>
		<option value="15">15</option>
	</select>
</div>

<div class="right">
	검색조건:
	<select id="searchCondition">
		<option value="title">제목</option>
		<option value="writer">작성자</option>
	</select>
	<input type="text" id="keyword">
	<button id="searchBtn">검색</button>
	
</div>

<table class="table">
	<thead>
		<tr>
			<th>글 번호</th>
			<th>작성자</th>
			<th>작성일자</th>
			<th>제목</th>
			<th>첨부파일</th>
			<th>조회수</th>
			<th>삭제</th>
		</tr>
	</thead>
	<tbody id="list">
	</tbody>
</table>
<div class="center">
	<div class="pagination"></div>
</div>

<script src="js/noticePaging.js">	
</script>