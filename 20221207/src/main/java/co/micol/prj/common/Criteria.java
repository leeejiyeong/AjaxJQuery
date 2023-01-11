package co.micol.prj.common;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class Criteria {
	private int page;	//현재페이지 정보
	private int amount;		//한페이지에 보여줄 건수
	private String searchCondition;		//검색조건
	private String keyword;				//검색키워드
	
	public Criteria() {
		this.page = 1;
		this.amount = 10;
	}
	
	public Criteria(int page, int amount) {
		this.page = page;
		this.amount = amount;
	}
}
