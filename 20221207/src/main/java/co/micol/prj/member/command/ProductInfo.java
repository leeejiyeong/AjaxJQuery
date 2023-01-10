package co.micol.prj.member.command;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import co.micol.prj.common.Command;

public class ProductInfo implements Command {

	@Override
	public String exec(HttpServletRequest request, HttpServletResponse response) {
		//상품 상세정보 (ex. CF001 상세정보) -> json형식
		//평점순위 4개 상품정보 -> json형식 으로 넘겨줘야한다.
		String item_code = request.getParameter("item");
		request.setAttribute("productCode", item_code);
		return "jquery/productInfo.tiles";
	}

}
