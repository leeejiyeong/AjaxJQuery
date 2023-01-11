package co.micol.prj.notice.command;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;

import co.micol.prj.common.Command;
import co.micol.prj.notice.service.NoticeService;
import co.micol.prj.notice.service.NoticeVO;
import co.micol.prj.notice.serviceImpl.NoticeServiceImpl;

public class noticeDelAjax implements Command {

	@Override
	public String exec(HttpServletRequest request, HttpServletResponse response) {
		String nId = request.getParameter("id");
		NoticeVO vo = new NoticeVO();
		vo.setNoticeId(Integer.valueOf(nId));
		
		NoticeService service = new NoticeServiceImpl();
		int cnt - service.noticeDelete(vo);
		
		Map<String, Object> map = new HashMap<>();
		ObjectMapper mapper = new ObjectMapper();
		String json = "";
		
		try {
			json =  mapper.writeValueAsString(map);
		} catch (JsonProcessingException e) {
			e.printStackTrace();
		}
		return "Ajax:" + json;
	}

}
