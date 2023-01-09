package co.micol.prj.member.map;

import java.util.List;
import java.util.Map;

import co.micol.prj.member.service.MemberVO;

public interface MemberMapper {
	List<MemberVO> memberSelectList(); //전체조회
	MemberVO memberSelect(MemberVO vo); //한사람 조회 또는 로그인
	int memberInsert(MemberVO vo);  //입력
	int memberDelete(MemberVO vo);  //삭제
	int memberUpdate(MemberVO vo);  //수정
	
	boolean isIdCheck(String id);  //아이디 중복체크 존재하면 false
	
	//상품목록
	List<Map<String, Object>> productList();
}
