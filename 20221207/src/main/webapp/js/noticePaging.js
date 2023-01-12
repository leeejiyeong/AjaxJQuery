/**
 * noticePaging.js
 */
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
	function deleteRowFnc(e) {
		let id = $(e.currentTarget).attr('rowid')

		$.ajax({
			url: 'noticeDelAjax.do?id=' + id,
			dataType: 'json',
			success: function (result) {
				if (result.retCode == 'Success') {
					let page = localStorage.getItem('currentPage');
					let amount = localStorage.getItem('perPage')
					let sc = localStorage.getItem('searchCondition')
					let kw = localStorage.getItem('keyword')
					ajaxCall(page, amount, sc, kw);
				} else {
					alert('처리에러');
				}
			},
			error: function () {

			}
		})
	}
	
	//공지사항 등록 form submit 이벤트
	$('#frm').on('submit', function(e){
		//기존 이벤트 차단
		e.preventDefault();
		
		//폼객체를 쉽게 가져오는법(?)
		let frm = document.getElementById('frm');
		let fData = new FormData(frm);
		for(let val of fData.entries()){
			console.log(val);
		}
		
		//ajax호출
		$.ajax({
			url: 'noticeInsertAjax.do',
			method: 'post',
			data: fData,
			dataType: 'json',
			processData: false,
			contentType: false,
			success: function(result){
				if(result.retCode == 'Success'){
					ajaxCall(1,$('#perPage').val(), null, null);
				}else{
					alert('앗! 야생의 오류가 나타났다');
				}
			},
			error: function(err){
				console.log(err);
			}
		})
	})