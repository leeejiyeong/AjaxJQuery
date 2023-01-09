package co.micol.prj.member.command;

import java.io.UnsupportedEncodingException;
import java.security.GeneralSecurityException;
import java.security.NoSuchAlgorithmException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import co.micol.prj.common.AES256Util;
import co.micol.prj.common.Command;
import co.micol.prj.member.service.MemberService;
import co.micol.prj.member.service.MemberVO;
import co.micol.prj.member.serviceImpl.MemberServiceImpl;

public class MemberUpdate implements Command {

	@Override
	public String exec(HttpServletRequest request, HttpServletResponse response) {
		// 회원정보 수정 처리
		MemberService dao = new MemberServiceImpl();
		MemberVO vo = new MemberVO();	
		
		String password = request.getParameter("memberPassword");
		if(password != "") {
			try {
				AES256Util aes = new AES256Util();
				try {
					password = aes.encrypt(password);
					vo.setMemberPassword(password);
				} catch (NoSuchAlgorithmException e) {
					e.printStackTrace();
				} catch (GeneralSecurityException e) {
					e.printStackTrace();
				}
			} catch (UnsupportedEncodingException e) {
				e.printStackTrace();
			}
		}
		
		vo.setMemberId(request.getParameter("memberId"));
		vo.setMemberName(request.getParameter("memberName"));
		vo.setMemberAge(Integer.valueOf(request.getParameter("memberAge")));
		vo.setMemberAddress(request.getParameter("memberAddress"));
		vo.setMemberTel(request.getParameter("memberTel"));
		vo.setMemberAuthor(request.getParameter("memberAuthor"));
		
		int n = dao.memberUpdate(vo);
		if(n != 0) {
			request.setAttribute("message", "회원정보가 수정되었습니다.");
		}else {
			request.setAttribute("message", "회원정보 수정 실패.");
		}
		return "member/memberLogin.tiles";
	}

}
