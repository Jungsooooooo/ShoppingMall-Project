package com.shopping.manager.dto;

import lombok.Data;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Data
@Getter
@Setter
@ToString
public class FaqTypeDTO {

	private String 	faqClass; // 질문종류번호
	private String	name; 		// 질문종류
}
