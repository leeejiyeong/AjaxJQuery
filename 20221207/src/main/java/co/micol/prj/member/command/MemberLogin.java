package co.micol.prj.member.command;

import java.io.UnsupportedEncodingException;
import java.security.GeneralSecurityException;
import java.security.NoSuchAlgorithmException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import co.micol.prj.common.AES256Util;
import co.micol.prj.common.Command;
import co.micol.prj.member.service.MemberService;
import co.micol.prj.member.service.MemberVO;
import co.micol.prj.member.serviceImpl.MemberServiceImpl;

public class MemberLogin implements Command {

	@Override
	public String exec(HttpServletRequest request, HttpServletResponse response) {
		// 로그인 처리
		MemberService dao = new MemberServiceImpl();
		MemberVO vo = new MemberVO();
		HttpSession session = request.getSession();  //서버가 만들어 보관하고 있는 세션객체를 호출
		
		String password = request.getParameter("memberPassword");
		try {
			AES256Util aes = new AES256Util();
			try {
				password = aes.encrypt(password);
			} catch (NoSuchAlgorithmException e) {
				e.printStackTrace();
			} catch (GeneralSecurityException e) {
				e.printStackTrace();
			} //암호화 됨
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}
		
		String message = null;
		vo.setMemberId(request.getParameter("memberId"));
		vo.setMemberPassword(password);
		
		vo = dao.memberSelect(vo);
		
		String path = "";
		
		if(vo != null) {
			session.setAttribute("id", vo.getMemberId());
			session.setAttribute("author", vo.getMemberAuthor());
			session.setAttribute("name", vo.getMemberName());
			
			message = vo.getMemberName() + "님 환영합니다.";
			request.setAttribute("message", message);
//			request.setAttribute("member", vo);
			
			if(vo.getMemberAuthor().equals("ADMIN")) {
				path = "jquery/memberList.tiles";
			}else {
				path = "member/memberLogin.tiles";				
			}
			
		}else {
			message = "아이디 또는 패스워드가 틀립니다.";
			request.setAttribute("message", message);
		}
		return path;
	}

}
