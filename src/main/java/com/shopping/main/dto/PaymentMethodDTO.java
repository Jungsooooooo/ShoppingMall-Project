package com.shopping.main.dto;

import java.util.Date;

import com.fasterxml.jackson.annotation.JsonFormat;

import lombok.Data;

@Data
public class PaymentMethodDTO {
	
	private String naverPay; 		//네이버페이
	private String phone; 			//핸드폰결제
	private String bank; 			//무통장
	private String creditCard; 	//신용카드

}
