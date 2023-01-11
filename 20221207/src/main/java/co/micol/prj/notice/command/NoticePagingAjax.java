package co.micol.prj.notice.command;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;

import co.micol.prj.common.Command;
import co.micol.prj.common.Criteria;
import co.micol.prj.notice.service.NoticeService;
import co.micol.prj.notice.service.NoticeVO;
import co.micol.prj.notice.serviceImpl.NoticeServiceImpl;

public class NoticePagingAjax implements Command {

	@Override
	public String exec(HttpServletRequest request, HttpServletResponse response) {
		String page = request.getParameter("page");
		String amount = request.getParameter("amount");
		String searchCondition = request.getParameter("searchCondition");
		String keyword = request.getParameter("keyword");
		
		
		//페이지 건수 나누는거
		Criteria cri = new Criteria(Integer.parseInt(page),Integer.parseInt(amount));
		
		//검색
		cri.setSearchCondition(searchCondition);
		cri.setKeyword(keyword);
		
		NoticeService service = new NoticeServiceImpl();
		List<NoticeVO> list = service.noticePagingList(cri);
		
		ObjectMapper mapper = new ObjectMapper();
		String json = "";
		
		try {
			json =  mapper.writeValueAsString(list);
		} catch (JsonProcessingException e) {
			e.printStackTrace();
		}
		return "Ajax:" + json;
	}

}
