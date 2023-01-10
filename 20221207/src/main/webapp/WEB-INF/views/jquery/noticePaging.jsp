<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<link rel="stylesheet" type="text/css"
	href="//cdn.datatables.net/1.13.1/css/jquery.dataTables.min.css">
<script src="js/jquery-3.6.3.min.js"></script>
<script src="//cdn.datatables.net/1.13.1/js/jquery.dataTables.min.js"></script> <!-- jquery를 사용하기 때문에 제이쿼리 링크는 이 링크 전에 적어줘야한다. -->

<h3>노티스페이징</h3>
<table id="example" class="display" style="width: 100%">
	<thead>
		<tr>
			<th>글 번호</th>
			<th>작성자</th>
			<th>작성일자</th>
			<th>제목</th>
			<th>첨부파일</th>
			<th>조회수</th>
		</tr>
	</thead>
	<tfoot>
		<tr>
			<th>글 번호</th>
			<th>작성자</th>
			<th>작성일자</th>
			<th>제목</th>
			<th>첨부파일</th>
			<th>조회수</th>
		</tr>
	</tfoot>
</table>

<script>
	$(document).ready(function() {
		$('#example').DataTable({
			ajax : 'noticeListPaging.do',
		});
	});
</script>