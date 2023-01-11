package co.micol.prj.common;

import lombok.Getter;
import lombok.ToString;

@Getter
@ToString
public class PageDTO {
	//ex) 135건 -> 14페이지. 현재페이지가 3페이지면 1~3페이지
	
	private int startPage;
	private int endPage;
	private int currPage;
	private boolean prev, next;
	private int total;		//총 데이터 건수
	
	public PageDTO(Criteria cri, int total) {
		this.currPage = cri.getPage();
		this.total = total;
		this.endPage = (int)Math.ceil(1.0 * this.currPage/10) * 10;
		this.startPage = this.endPage - (10 - 1);
		
		int realEnd = (int) Math.ceil(total * 1.0 / cri.getAmount());
		if(this.endPage > realEnd) {
			this.endPage = realEnd;
		}
		this.prev = this.startPage > 1;			//현재페이지가 1보다 크면 이전페이지가 있고
		this.next = this.endPage < realEnd;		//마지막페이지가 총 페이지보다 작으면 다음페이지가 있다
	}
}
