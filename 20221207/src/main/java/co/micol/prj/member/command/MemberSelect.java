package co.micol.prj.member.command;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import co.micol.prj.common.Command;
import co.micol.prj.member.service.MemberService;
import co.micol.prj.member.service.MemberVO;
import co.micol.prj.member.serviceImpl.MemberServiceImpl;

public class MemberSelect implements Command {

	@Override
	public String exec(HttpServletRequest request, HttpServletResponse response) {
		// 회원 한명 조회
		MemberService dao = new MemberServiceImpl();
		MemberVO vo = new MemberVO();
		
		vo.setMemberId(request.getParameter("memberId"));
		vo = dao.memberSelect(vo);
		
		String viewPage = null;
		
		if(vo != null) {
			request.setAttribute("member", vo);
			viewPage = "member/memberSelect.tiles";
		}else {
			request.setAttribute("message", "존재하지 않는 회원입니다.");
			viewPage = "member/memberLogin.tiles";
		}
			
		return viewPage;
	}

}
