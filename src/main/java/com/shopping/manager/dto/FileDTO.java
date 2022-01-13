package com.shopping.manager.dto;

import lombok.Data;

/*-------------------------------------------------------------------------------------------------
* public class FileDTO
-------------------------------------------------------------------------------------------------*/
@Data
public class FileDTO {
	
	private		int			fno;			// 파일 일련번호
	private		int			productCode;	// 상품등록 번호
	private		String		fileName;		// 저장될 파일명
	private		String		fileOriName;	// 원래 파일명
	private		String		fileUrl;		// 파일의 위치
	
}/*End - public class FileDTO*/
