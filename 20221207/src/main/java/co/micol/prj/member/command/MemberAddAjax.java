package co.micol.prj.member.command;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;

import co.micol.prj.common.AES256Util;
import co.micol.prj.common.Command;
import co.micol.prj.member.service.MemberService;
import co.micol.prj.member.service.MemberVO;
import co.micol.prj.member.serviceImpl.MemberServiceImpl;

public class MemberAddAjax implements Command {

	@Override
	public String exec(HttpServletRequest request, HttpServletResponse response) {
		String id = request.getParameter("memberId");
		String name = request.getParameter("memberName");
		String pass = request.getParameter("memberPassword");
		try {
			AES256Util aes = new AES256Util();
			pass = aes.encrypt(pass);
		} catch (Exception e) {
			e.printStackTrace();
		}
		String age = request.getParameter("memberAge");
		String addr = request.getParameter("memberAddress");
		String phone = request.getParameter("memberTel");
		
		MemberVO vo = new MemberVO();
		vo.setMemberId(id);
		vo.setMemberName(name);
		vo.setMemberPassword(pass);
		vo.setMemberAge(Integer.parseInt(age));
		vo.setMemberAddress(addr);
		vo.setMemberTel(phone);
		vo.setMemberAuthor("User");
		
		System.out.println(vo);
		
		MemberService service = new MemberServiceImpl();
		int cnt = service.memberInsert(vo);
		ObjectMapper mapper = new ObjectMapper();
		Map<String, Object> map = new HashMap<>();
		
		//{"retCode": "Success", "data": vo}
		if(cnt > 0) {
			map.put("retCode", "Success");
			map.put("data", vo);
		}else {
			map.put("retCode", "Fail");
		}
		String json = "";
		try {
			json = mapper.writeValueAsString(map);
		} catch (JsonProcessingException e) {
			e.printStackTrace();
		}
		return "Ajax:" + json;
	}

}
