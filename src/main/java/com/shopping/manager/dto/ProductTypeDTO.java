package com.shopping.manager.dto;

import java.util.Date;

import lombok.Data;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Data
@Setter
@Getter
@ToString

public class ProductTypeDTO {
	
	private		String	productClass;		//상품 분류
	private		String	name;					//상품 이름
	
	
	
}