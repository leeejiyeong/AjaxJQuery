<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<script src="js/jquery-3.6.3.min.js"></script>
<h3>회원목록</h3>
<div align="center">
    <div>
        <h1>회 원 가 입</h1>
    </div>
    <div>
        <form id="frm" action="memberJoin.do" onsubmit="return formCheck()" method="post">
            <div>
                <table class="table" border="1">
                    <tr>
                        <th width="150">아이디</th>
                        <td width="300">
                            <input type="text" id="memberId" name="memberId" required="required" value="user1">&nbsp;
                            <button type="button" onclick="idChk()" id="btnId" value="No">중복체크</button>
                        </td>
                    </tr>
                    <tr>
                        <th width="150">이름</th>
                        <td>
                            <input type="text" id="memberName" name="memberName" required="required" value="김또치"> 
                        </td>
                    </tr>
                    <tr>        
                        <th width="150">패스워드</th>
                        <td>
                            <input type="password" id="memberPassword" name="memberPassword" required="required" value="1234">
                        </td>
                    </tr>
                    <tr>
                        <th width="150">패스워드확인</th>
                        <td>
                            <input type="password" id="passwordChk" required="required" value="1234">
                        </td>
                    </tr>
                    <tr>
                        <th width="150">나이</th>
                        <td>
                            <input type="text" id="memberAge" name="memberAge" value="20">
                        </td>
                    </tr>
                    <tr>
                        <th width="150">주소</th>
                        <td>
                            <input type="text" id="memberAddress" name="memberAddress" value="대궁">
                        </td>
                    </tr>
                    <tr>
                        <th width="150">전화번호</th>
                        <td>
                            <input type="tel" id="memberTel" name="memberTel" value="010-2030-2030">
                        </td>
                    </tr>
                </table>
            </div><br>
            <input type="submit" value="회원가입">&nbsp;&nbsp;
            <input type="reset" value="취소">&nbsp;&nbsp;
            <input type="button" onclick="location.href='main.do'" value="홈가기">
        </form>
    </div>
</div>

<script>
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
                    alert('이미 존재하는 아이디 입니다.')
                    $('#memberId').val(""); //쳤던 아이디 지워줌
                } else {
                    alert('사용 가능한 아이디 입니다.')
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
            },
            error: function (reject) {
				console.log(reject)
            }

        })
        return false; //true하면 완료눌렀을때 페이지가 이동함. 페이지 안에서 처리하려면 false해야함
    }
</script>