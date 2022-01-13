package com.shopping.main.dto;

import java.util.Date;

import com.fasterxml.jackson.annotation.JsonFormat;

import lombok.Data;

@Data
public class BankDTO {
	
	private String account;
	private String bank;
	private String name;
	
}
