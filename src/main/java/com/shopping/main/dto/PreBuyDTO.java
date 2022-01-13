package com.shopping.main.dto;

import java.util.Date;

import lombok.Data;

@Data
public class PreBuyDTO {
	//private int prebuyNum;          	// 바로구매 번호
	//private String userId;            	// 구매자
	private String productImage;    // 상품이미지명
	private String productName;    // 구매된 상품 이름
	private int productPrice;		    // 판매 가격
	private int buy_productCount;   // 판매수량
	private int productCode;    		// 상품번호
	private int discount_rate;			// 할인율
}
