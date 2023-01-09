package co.micol.prj.web;

import java.io.IOException;
import java.util.HashMap;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import co.micol.prj.MainCommand;
import co.micol.prj.common.Command;
import co.micol.prj.member.command.AjaxMemberIdCheck;
import co.micol.prj.member.command.MemberAddAjax;
import co.micol.prj.member.command.MemberDelAjax;
import co.micol.prj.member.command.MemberDelete;
import co.micol.prj.member.command.MemberEdit;
import co.micol.prj.member.command.MemberGetAjax;
import co.micol.prj.member.command.MemberJoin;
import co.micol.prj.member.command.MemberJoinForm;
import co.micol.prj.member.command.MemberList;
import co.micol.prj.member.command.MemberListAjax;
import co.micol.prj.member.command.MemberListJquery;
import co.micol.prj.member.command.MemberLogin;
import co.micol.prj.member.command.MemberLoginForm;
import co.micol.prj.member.command.MemberLogout;
import co.micol.prj.member.command.MemberSelect;
import co.micol.prj.member.command.MemberUpdate;
import co.micol.prj.member.command.ProductList;
import co.micol.prj.member.command.ProductListForm;
import co.micol.prj.member.command.UpdateMemberAjax;
import co.micol.prj.notice.command.NoticeInsert;
import co.micol.prj.notice.command.NoticeInsertForm;
import co.micol.prj.notice.command.NoticeList;
import co.micol.prj.notice.command.NoticeSelect;

//@WebServlet("*.do")
public class FrontController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private HashMap<String, Command> map = new HashMap<String, Command>();
	
    public FrontController() {
        super();
    }

	public void init(ServletConfig config) throws ServletException {
		// 명령집단 map.put(k,V)
		map.put("/main.do", new MainCommand());//처음실행하는 페이지 
		map.put("/memberList.do", new MemberList()); //멤버목록 보기
		map.put("/memberJoinForm.do", new MemberJoinForm());//회원가입폼
		map.put("/AjaxMemberIdCheck.do", new AjaxMemberIdCheck()); //회원아이디 중복체크
		map.put("/memberJoin.do", new MemberJoin()); //회원가입 처리
		map.put("/memberLoginForm.do", new MemberLoginForm()); //로그인폼 호출
		map.put("/memberLogin.do", new MemberLogin());//로그인 처리
		map.put("/memberLogout.do", new MemberLogout()); //로그아웃 처리
		map.put("/memberSelect.do", new MemberSelect());  //멤버 한명 조회
		map.put("/memberEdit.do", new MemberEdit());  //멤버 수정폼 호출
		map.put("/memberDelete.do", new MemberDelete()); //멤버삭제
		map.put("/memberUpdate.do", new MemberUpdate()); //멤버 수정
		map.put("/noticeInsertForm.do", new NoticeInsertForm());//공지사항 등록 폼
		map.put("/noticeList.do", new NoticeList()); //공지사항 목록
		map.put("/noticeSelect.do", new NoticeSelect()); //공지사항 상세보기
		map.put("/noticeInsert.do", new NoticeInsert());//공지사항 등록
		map.put("/test.do", new Test());
		
		//jquery연습용
		map.put("/memberListJquery.do", new MemberListJquery());
		map.put("/memberAddAjax.do", new MemberAddAjax());			//회원가입(맴버추가)
		map.put("/memberListAjax.do", new MemberListAjax());		//멤버목록 가져오기 위함
		map.put("/memberDelAjax.do", new MemberDelAjax());			//맴버목록에서 삭제하기
		map.put("/memberGetAjax.do", new MemberGetAjax());			//한건조회
		map.put("/updateMemberAjax.do", new UpdateMemberAjax()); 	//수정하기
		
		map.put("/productList.do", new ProductList());				//상품리스트
		map.put("/productListForm.do", new ProductListForm());		//상품리스트 폼
	}

	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// 요청을 분석, 실행, 결과를 돌려주는 곳
		request.setCharacterEncoding("utf-8");
		String uri = request.getRequestURI();
		String contextPath = request.getContextPath();
		String page = uri.substring(contextPath.length());
		System.out.println(page + "==============");
		Command command = map.get(page);
		String viewPage = command.exec(request, response);

		//view Resolve start
		if(!viewPage.endsWith(".do")) {
			if(viewPage.startsWith("Ajax:")) {
				//ajax
				response.setContentType("text/html; charset=UTF-8");
				response.getWriter().print(viewPage.substring(5));
				return;
			}else if(!viewPage.endsWith(".tiles")){	
				viewPage = "WEB-INF/views/" + viewPage + ".jsp";	 //타일즈 적용안하는 것		
			}
			
			RequestDispatcher dispatcher = request.getRequestDispatcher(viewPage);
			dispatcher.forward(request, response);
		}else {
			response.sendRedirect(viewPage);
		}
		//view Resolve end
	}

}
