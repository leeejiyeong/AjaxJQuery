package co.micol.prj.member.command;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;

import co.micol.prj.common.Command;
import co.micol.prj.member.service.MemberService;
import co.micol.prj.member.service.MemberVO;
import co.micol.prj.member.serviceImpl.MemberServiceImpl;

public class UpdateMemberAjax implements Command {

	@Override
	public String exec(HttpServletRequest request, HttpServletResponse response) {
		
		String id = request.getParameter("id");
		String addr = request.getParameter("addr");
		String phone = request.getParameter("phone");
		
		MemberVO vo = new MemberVO();
		
		vo.setMemberId(id);
		vo.setMemberAddress(addr);
		vo.setMemberTel(phone);
		
		MemberService service = new MemberServiceImpl();
		int cnt = service.memberUpdate(vo);		//처리된 건수를 반환
		ObjectMapper mapper = new ObjectMapper();	//"{\"retCode\...어쩌구 저거 안쓸라고 쓰는거임
		Map<String, Object> map = new HashMap<>();
		
		
		String json = "";
		if(cnt > 0) {	//정상적으로 업데이트가 되면
			MemberVO svo = service.memberSelect(vo);
			//json = "{\"retCode\": \"Success\", \"memberId\": " + vo.getMemberId() + "}";
			map.put("retCode", "Success");
			map.put("data", svo);
			try {
				json = mapper.writeValueAsString(map);
			} catch (JsonProcessingException e) {
				e.printStackTrace();
			}
		}else {
			json = "{\"retCode\": \"Fail\"}";
		}
		
		return "Ajax:" + json;
	}

}
