package com.shopping.manager.dto;

import java.util.Date;

import lombok.Data;

/*-------------------------------------------------------------------------------------------------
* public class BoardDTO
-------------------------------------------------------------------------------------------------*/
@Data
public class ManagerDTO {

	private		int		productCode;		//등록번호
	private		String	productClass;		//상품 분류
	private		String	productName;		//상품 이름
	private		int		productPrice;		//상품 가격
	private		int		productCount;		//상품 재고수량
	private		String	productImage;		//상품 이미지명
	private		String	productContent;		//상세 설명
	private		int		discount_rate;		//상품 할인율
	private		Date	reg_date;			//상품 등록일자
	
}/*End - public class BoardDTO*/