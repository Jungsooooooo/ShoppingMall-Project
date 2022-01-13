package com.shopping.member.dto;

import java.sql.Timestamp;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString

//--------------------------------------------------------------
// public class MemberDTO
//--------------------------------------------------------------

public class MemberDTO {

	private int		userNum;
	private String	userId;
	private String	userPw;
	private String  reuserPw;
	private String	userName;
	private String	userPhone;
	private	String	userEmail;
	private String  zipcode;
	private	String	userAddr1;
	private	String	userAddr2;
	private	String	userBirth;
	private Timestamp regDate;
	
}// End- public class MemberDTO
