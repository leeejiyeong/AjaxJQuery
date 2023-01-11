package co.micol.prj.notice.command;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;

import co.micol.prj.common.Command;
import co.micol.prj.common.Criteria;
import co.micol.prj.common.PageDTO;
import co.micol.prj.notice.service.NoticeService;
import co.micol.prj.notice.serviceImpl.NoticeServiceImpl;

public class NoticePageDTO implements Command {

	@Override
	public String exec(HttpServletRequest request, HttpServletResponse response) {
		
		String page = request.getParameter("page");
		String amount = request.getParameter("amount");
		String searchCondition = request.getParameter("searchCondition");
		String keyword = request.getParameter("keyword");
		
		Criteria cri = new Criteria(Integer.parseInt(page), Integer.parseInt(amount));
		
		//검색
		cri.setSearchCondition(searchCondition);
		cri.setKeyword(keyword);		
		
		//전체건수 계산
		NoticeService service = new NoticeServiceImpl();
		int total = service.pagingAllCount(cri);
		
		int pageInt = Integer.parseInt(page);
		PageDTO pageDTO = new PageDTO(cri, total);
		
		ObjectMapper mapper = new ObjectMapper();
		String json = "";
		try {
			json = mapper.writeValueAsString(pageDTO);
		} catch (JsonProcessingException e) {
			e.printStackTrace();
		}
		
		return "Ajax:" + json;
	}

}
