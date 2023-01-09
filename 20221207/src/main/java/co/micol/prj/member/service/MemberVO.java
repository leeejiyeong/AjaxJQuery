package co.micol.prj.member.service;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Setter  
@Getter  
@ToString
public class MemberVO {
	private String memberId;
	private String memberName;
	private String memberPassword;
	private int memberAge;
	private String memberAddress;
	private String memberTel;
	private String memberAuthor;

}
