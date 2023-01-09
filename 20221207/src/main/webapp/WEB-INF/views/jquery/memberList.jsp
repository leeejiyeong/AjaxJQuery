<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<link rel="stylesheet"
	href="//code.jquery.com/ui/1.13.2/themes/base/jquery-ui.css">
<link rel="stylesheet" href="css/style.css">
<script src="https://code.jquery.com/jquery-3.6.0.js"></script>
<script src="https://code.jquery.com/ui/1.13.2/jquery-ui.js"></script>



<h3>회원목록</h3>
<div align="center">
	<div>
		<h1>회 원 가 입</h1>
	</div>
	<div>
		<form id="frm" action="memberJoin.do" onsubmit="return formCheck()"
			method="post">
			<div>
				<table class="table" border="1">
					<tr>
						<th width="150">아이디</th>
						<td width="300"><input type="text" id="memberId"
							name="memberId" required="required" value="user1"
							title="마 니 아이디 뭐할꺼고">&nbsp;
							<button type="button" onclick="idChk()" id="btnId" value="No">중복체크</button>
						</td>
					</tr>
					<tr>
						<th width="150">이름</th>
						<td><input type="text" id="memberName" name="memberName"
							required="required" value="김또치" title="마 니 이름 뭔데"></td>
					</tr>
					<tr>
						<th width="150">패스워드</th>
						<td><input type="password" id="memberPassword"
							name="memberPassword" required="required" value="1234"
							title="마 비번 적어라"></td>
					</tr>
					<tr>
						<th width="150">패스워드확인</th>
						<td><input type="password" id="passwordChk"
							required="required" value="1234" title="마 비번 한번 더 적어라"></td>
					</tr>
					<tr>
						<th width="150">나이</th>
						<td><input type="text" id="memberAge" name="memberAge"
							value="20" title="마 니 몇살이고"></td>
					</tr>
					<tr>
						<th width="150">주소</th>
						<td><input type="text" id="memberAddress"
							name="memberAddress" value="대궁" title="마 니 어디사노"></td>
					</tr>
					<tr>
						<th width="150">전화번호</th>
						<td><input type="tel" id="memberTel" name="memberTel"
							value="010-2030-2030" title="마 니 폰번호 뭐고"></td>
					</tr>
				</table>
			</div>
			<br> <input type="submit" value="회원가입">&nbsp;&nbsp; <input
				type="reset" value="취소">&nbsp;&nbsp; <input type="button"
				onclick="location.href='main.do'" value="홈가기">
		</form>
	</div>
	<table class="table">
		<thead>
			<tr>
				<th>아이디</th>
				<th>이름</th>
				<th>나이</th>
				<th>주소</th>
				<th>연락처</th>
				<th>삭제</th>
				<th>수정</th>
			</tr>
		</thead>
		<tbody id="memberList">

		</tbody>
	</table>
</div>

<div id="dialog" title="기본 창">
	<p></p>
</div>

<script>

	//풍선알림말
	var tooltips = $( "[title]" ).tooltip({
    	position: {
      	my: "left top",
      	at: "right+5 top-5",
      	collision: "none"
    	}
  	});
	
	//회원목록 내용 추가하기
	function makeRow(obj={}){
		let tr = $('<tr />').append(
			$('<td />').text(obj.memberId),
			$('<td />').text(obj.memberName),
			$('<td />').text(obj.memberAge),
			$('<td />').text(obj.memberAddress),
			$('<td />').text(obj.memberTel),
			$('<td />').append($('<button />').text('삭제').on('click',delMemberFnc)),
			$('<td />').append($('<button />').text('수정').on('click',modifyFormFnc))
			);
		tr.attr('id',obj.memberId);		//tr의 attribute에 값을 저장
		return tr;
	}
	
	//회원정보 수정처리
	function updateMemberAjax(e){
		let tr = $(e.currentTarget).parent().parent();
		console.log(tr)
		let id = tr.children().eq(0).text();
		let addr = tr.children().eq(3).children().eq(0).val();
		let phone = tr.children().eq(4).children().eq(0).val();
		console.log(id, addr, phone)
		
		$.ajax({
			url: 'updateMemberAjax.do',
			method: 'post',
			data : {id: id, addr: addr, phone: phone},
			dataType: 'json',
			success: function(result){
				console.log(result)
				$('#'+id).replaceWith(makeRow(result.data));
				let ntr = makeRow(result.data);
				console.log(ntr)
			},
			error: function(reject){
				console.log(reject)
			}
		});
	}
	
	
	
	//회원목록 수정
	function modifyFormFnc(e){
		let obj = {
			url: '',
			dataType: 'json',
			success: function(){
				
			},
			error: function(){
				
			}
		}
		let id = $(e.currentTarget).parent().parent().attr('id')
		$.ajax({
			url: 'memberGetAjax.do?id='+id,
			//method: 'get'(default값)
			dataType: 'json',
			success: function(result){
				let ntr = $('<tr />').append(
					$('<td />').text(result.memberId),
					$('<td />').text(result.memberName),
					$('<td />').text(result.memberAge),
					$('<td />').append($('<input />').attr('type','text').val(result.memberAddress)),
					$('<td />').append($('<input />').attr('type','text').val(result.memberTel)),
					$('<td />').append($('<button />').text('삭제').attr('disabled','disabled')),
					$('<td />').append($('<button />').text('변경').on('click', updateMemberAjax))
				);
				ntr.attr('id',result.memberId);
				$('#'+id).replaceWith(ntr);
			},
			error: function(){
				
			}
		})
	}
	
	//회원목록 한줄 삭제버튼
	function delMemberFnc(e){
		console.log(e);
		let id = $(e.currentTarget).parent().parent().children().eq(0).text()	
		id = $(e.currentTarget).parent().parent().attr('id');
		
		$.ajax({
			url: 'memberDelAjax.do',
			method: 'post',
			data: {id: id},
			dataType: 'json',
			success: function(result){
				if(result.retCode == "Success"){
					$('#'+id).remove();
				}else{
					alert('처리 중 에러');
				}
			},
			error: function (reject){
				console.log(reject);
			}
		});
		console.log(id);
	}
	
    //서버에서 데이터 가져와서 값을 회원목록 테이블에 출력
    $.ajax({
        url: 'memberListAjax.do',    //json포멧으로 회원목록
        dataType: 'json',
        success: function(result){
            console.log(result)         //자바스크립트의 배열객체. forEach(function(){})
            $(result).each(function(idx, item){		//jquery객체로 변경
            	if(item.memberAge > 0){
            		$('#memberList').append(makeRow(item));
            	}
            })
        },      
        error: function(reject){
            console.log(reject)
        }
    })


    //아이디 중복체크하는 함수
    function idChk() {
        let searchId = $('#memberId').val();
        $.ajax({
            url: 'AjaxMemberIdCheck.do',
            data: {id: searchId}, //'id=' + searchId,  키:밸류 형식으로 중괄호 이용해서 적어도된다.
            method: 'post',
            success: function (result) {
                console.log(result)
                if (result == 0) {
                    //alert('이미 존재하는 아이디 입니다.')
                    $('#dialog p').text('이미 존재하는 아이디입니다.')
    				$( "#dialog" ).dialog();
                    $('#memberId').val(""); //쳤던 아이디 지워줌
                } else {
                    //alert('사용 가능한 아이디 입니다.')
                    $('#dialog p').text('사용가능한 아이디 입니다.')
                	$( "#dialog" ).dialog();
                }
            },
            error: function (reject) {
                console.log(reject)
            }
        })
    }

    //submit이벤트(회원가입 완료버튼)
    function formCheck() {
        console.log('허호호')
        //패스워드 일치 확인
        let pass1 = $('#memberPassword').val();
        let pass2 = $('#passwordChk').val();
        if (pass1 != pass2) {
            alert('비번이 다릅니다')
            return false;
        }

        let params = $('#frm').serialize();
        console.log(params);
        //ajax 호출 
        $.ajax({
            url: 'memberAddAjax.do', 	//요청페이지
            method: 'post', 			//post요청
            data: params, 				//서버 전송할 데이터
            dataType:  'json',			//처리결과의 컨텐트 타입 지정.
            success: function (result) {
				console.log(result)
				//JSON.parse(result)
				if(result.retCode == 'Success'){
					$('#memberList').append(makeRow(result.data));		//tr생성
				}else{
					alert('처리 중 에러발생');
				}
            },
            error: function (reject) {
				console.log(reject)
            }

        })
        return false; //true하면 완료눌렀을때 페이지가 이동함. 페이지 안에서 처리하려면 false해야함
    }
</script>