package co.micol.prj.member.command;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;

import co.micol.prj.common.Command;
import co.micol.prj.member.service.MemberService;
import co.micol.prj.member.serviceImpl.MemberServiceImpl;

public class ProductDetail implements Command {

	@Override
	public String exec(HttpServletRequest request, HttpServletResponse response) {
		String productCd = request.getParameter("item");
		MemberService service = new MemberServiceImpl();
		Map<String, Object> map = service.productDetail(productCd);
		
		ObjectMapper mapper = new ObjectMapper();
		String json="";
		try {
			json = mapper.writeValueAsString(map);
		} catch (JsonProcessingException e) {
			e.printStackTrace();
		}
		
		return "Ajax:" + json;
	}

}
