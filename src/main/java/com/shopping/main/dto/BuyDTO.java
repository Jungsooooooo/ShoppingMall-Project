package com.shopping.main.dto;

import java.util.Date;

import com.fasterxml.jackson.annotation.JsonFormat;

import lombok.Data;

/*-------------------------------------------------------------------------------------------------
* public class CommentDTO
-------------------------------------------------------------------------------------------------*/
@Data
public class BuyDTO {

	private String	buyNum;
	private String 	userId;             		// 구매자o
	private String 	userName;     			// 구매자 이름o
	private int 		productCode;		   	// 구매된 상품 번호o
	private String 	productName; 			// 구매된 상품 이름o
	private int 		productPrice; 			// 판매 가격o
	private int		discount_rate;		//할인율
	private int 		buy_productCount;  	// 판매수량o
	private String 	productImage; 			// 상품이미지명o
	@JsonFormat(shape=JsonFormat.Shape.STRING, pattern = "yyyy-MM-dd HH:mm:ss")
	private Date 	reg_date;   			 	// 구매일자o
	private String 	payment_method;		// 결제 수단o
	private String 	deliveryName; 		 	// 배송받는 사람 이름o
	private String 	deliveryTel;  				// 배송지 전화번호o
	private String	deliveryAddress1;		// 배송지 주소o
	private String	deliveryAddress2;		// 배송지 주소o	
	private int sum;
	private int shippingFee;
	private int finalSum;
	private String	shipping;     			// 배송상황o default '상품준비중' 	
}
