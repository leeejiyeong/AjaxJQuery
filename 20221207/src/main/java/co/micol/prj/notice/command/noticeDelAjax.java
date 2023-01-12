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
		// TODO Auto-generated method stub
		String nid = request.getParameter("id");
		NoticeVO vo = new NoticeVO();
		vo.setNoticeId(Integer.parseInt(nid));

		NoticeService service = new NoticeServiceImpl();

		int cnt = service.noticeDelete(vo);
		String json = "";
		if (cnt > 0)
			json = "{\"retCode\":\"Success\"}";
		else
			json = "{\"retCode\":\"Fail\"}";
		return "Ajax:" + json;
	}

}
