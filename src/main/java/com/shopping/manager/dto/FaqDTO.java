package com.shopping.manager.dto;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class FaqDTO {

	private int 	bno;		//번호
	private	String  title;		//제목
	private String  content;	//답변
	private	String	faqClass;	//질문목록
	
}
