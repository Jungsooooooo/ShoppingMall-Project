package com.shopping.main.dto;

import java.util.Date;

import com.fasterxml.jackson.annotation.JsonFormat;

import lombok.Data;

/*-------------------------------------------------------------------------------------------------
* public class CommentDTO
-------------------------------------------------------------------------------------------------*/
@Data
public class CommentDTO {
	
	private		int			cno;		//댓글 일련번호
	private		int			productCode;//댓글이 달릴 게시글의 일련번호
	private		String		content;	//댓글의 내용
	private		String		writer;		//댓글 작성자
	@JsonFormat(shape=JsonFormat.Shape.STRING, pattern = "yyyy-MM-dd HH:mm:ss")
	private		Date		reg_date;	//댓글 작성 일시
	
}/*End - public class CommentDTO*/
