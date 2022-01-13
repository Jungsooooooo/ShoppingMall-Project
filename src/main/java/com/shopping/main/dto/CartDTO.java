package com.shopping.main.dto;

import java.util.Date;

import lombok.Data;

/*-------------------------------------------------------------------------------------------------
* public class BoardDTO
-------------------------------------------------------------------------------------------------*/
@Data
public class CartDTO {

	private	int		cartNum;			//장바구니 번호
	private	String	userId;				//상품 구매자
	private	int		productCode;		//구매된 상품 번호
	private	String	productName;		//구매된 상품 이름
	private	int		productPrice;		//상품 가격
	private	int		discount_rate;		//할인율
	private	int		buy_productCount;	//판매수량
	private	String	productImage;		//상품 이미지명
	private	int		totalPrice; {
		// TODO Auto-generated method stub
		
	}
	
}/*End - public class BoardDTO*/