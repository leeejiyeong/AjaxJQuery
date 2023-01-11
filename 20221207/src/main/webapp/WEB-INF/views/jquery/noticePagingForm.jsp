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

<script>
	//tr만드는 함수
	function makeTr(obj={}){
		let tr = $('<tr />').append(
				$('<td />').text(obj.noticeId),
				$('<td />').text(obj.noticeWriter),
				$('<td />').text(obj.noticeDate),
				$('<td />').text(obj.noticeTitle),
				$('<td />').text(obj.noticeFile),
				$('<td />').text(obj.noticeHit),
				$('<td />').append($('<button />')
						.attr('rowId',obj.noticeId)
						.text('삭제')
						.on('click', deleteRowFnc)
				)
		)
		return tr;
	}
	
	
	//페이지 이동 함수
	function pageChangeFnc(e){
		e.preventDefault();	//기존의 이벤트는 차단한다는 뜻
		console.log(e.currentTarget.innerText)
		let page = e.currentTarget.getAttribute('page');
		let amount = e.currentTarget.getAttribute('amount');
		let sc = e.currentTarget.getAttribute('searchCondition');
		let kw = e.currentTarget.getAttribute('keyword');
		ajaxCall(page, amount, sc, kw);
		
	}
	
	function ajaxCall(page, amount, sc, kw){	//위에서 썼던거 함수로 묶어주기
		console.log(sc,kw);
		//한페이지 가져오는 기능
		$.ajax({
			url: 'noticePagingAjax.do?page='+page+'&amount=' + amount +'&searchCondition=' + sc +'&keyword=' + kw,
			dataType: 'json',
			success: function(result){
				console.log(result)
				$('#list tr').remove();			//기존화면 지워줘야 추가가 안됨
				for(let i = 0; i<result.length; i++){
					$('#list').append(makeTr(result[i]))				
				}
			},
			error: function(reject){
				console.log(reject);
			}
			
		})
		
		//pageDTO생성
		$.ajax({
			url: "noticePageDTO.do?page="+page + '&amount=' + amount +'&searchCondition=' + sc +'&keyword=' + kw,
			dataType: 'json',
			success: function(result){
				console.log(result)
				$('.pagination a').remove();	//화면 clear
				
				let start = result.startPage;
				let end = result.endPage;
				let curr = result.currPage;
				
				//이전페이지=
				if(result.prev == true){
					$('.pagination').append($('<a href=""/>')
							.html('&laquo;')
							.attr('page',start-1).attr('amount', amount).attr('searchCondition', sc).attr('keyword', kw)
							.on('click',pageChangeFnc)
						)
				}
				
				//현재페이지
				for(let p = start; p <= end; p++){
					let aTag = $('<a href="noticePagingAjax.do" />').text(p).attr('page', p)
					aTag.on('click', pageChangeFnc).attr('amount', amount).attr('searchCondition', sc).attr('keyword', kw)
					if(p == curr){
						aTag.addClass('active');	//현재페이지 정보
						//삭제 버튼 눌렀을때 정보를 전달하기 위함
						localStorage.setItem('currentPage', curr);
						localStorage.setItem('searchCondition', $('#searchCondition').val());
						localStorage.setItem('keyword', $('#keyword').val());
						localStorage.setItem('perPage', $('#perPage').val());
					}
					$('.pagination').append(aTag);
				}
				
				//이후페이지
				if(result.next == true){
					$('.pagination').append($('<a href=""/>')
						.html('&raquo;')
						.attr('page',end+1).attr('amount', amount).attr('searchCondition', sc).attr('keyword', kw)
						.on('click',pageChangeFnc)
					)
				}
	
			},
			error: function(reject){
				console.log(reject)
			}
		});
	}
	
	//첫페이지는 1페이지로 하겠다는뜻
	let amount = $('#perPage').val();
	ajaxCall(1, amount);
	
	//페이지수 선택목록 변경
	$('#perPage').on('change', function(){
		ajaxCall(1,$(this).val());
	})
	
	//검색버튼
	$('#searchBtn').on('click', function(){
		let searchCondition = $('#searchCondition').val();
		let keyword =$('#keyword').val();
		ajaxCall(1,$('#perPage').val(), searchCondition, keyword);
	})
	
	//삭제
	function deleteRowFnc(e){
		let id = e.currentTarget.attr('rowId');
		
		console.log(localStorage.getItem('currentPage'))
		console.log(localStorage.getItem('amount'))
		console.log(localStorage.getItem('searchCondition'))
		console.log(localStorage.getItem('keyword'))
		$.ajax({
			url:'noticeDelAjax.do?id='+ id,
			dataType: 'json',
			success: function(result){
				if(result.retCode == 'Success'){
					let page = localStorage.getItem('currentPage')
					let amount = localStorage.getItem('amount')
					let sc = localStorage.getItem('searchCondition')
					let kw = localStorage.getItem('keyword')
					ajaxCall(page, amount, sc, kw);
				}else{
					alery('에러에에에에엥')
				}
			},
			error: function(reject){
				console.log(reject)
			}
		})
		
		
	}
</script>