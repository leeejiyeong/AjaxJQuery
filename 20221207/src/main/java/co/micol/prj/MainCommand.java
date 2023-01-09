package co.micol.prj;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import co.micol.prj.common.Command;

public class MainCommand implements Command {

	@Override
	public String exec(HttpServletRequest request, HttpServletResponse response) {
		// 첫 페이지 보여주는 곳
		
		System.out.println(request.getAttribute("test"));
		return "main/main.tiles";
	}

}
