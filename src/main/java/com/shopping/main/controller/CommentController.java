package com.shopping.main.controller;

import java.util.List;

import javax.annotation.Resource;
import javax.inject.Inject;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.shopping.main.dto.CommentDTO;
import com.shopping.main.service.CommentService;

import lombok.extern.java.Log;

/*-------------------------------------------------------------------------------------------------
* public class CommentController
-------------------------------------------------------------------------------------------------*/
@Log
@Controller
@RequestMapping("/comment")
public class CommentController {
	
	@Inject
	CommentService commentService;
	
	/*-------------------------------------------------------------------------------------------------
	* 댓글 등록
	-------------------------------------------------------------------------------------------------*/
	@ResponseBody
	@RequestMapping("/insert")
	private int mCommentServiceInsert(@RequestParam int productCode, @RequestParam String content, @RequestParam String writer) throws Exception {
		
		System.out.println("CommentController insert() Start.....");
		System.out.println("productCode["+productCode+"]");
		System.out.println("content["+content+"]");
		
		CommentDTO comment = new CommentDTO();
		comment.setProductCode(productCode);
		comment.setContent(content);
		comment.setWriter(writer);
		
		return commentService.commentInsert(comment);
	}

	/*-------------------------------------------------------------------------------------------------
	* 댓글 리스트
	-------------------------------------------------------------------------------------------------*/
	@ResponseBody
	@RequestMapping("/list/{productCode}") 
    private List<CommentDTO> mCommentServiceList(@PathVariable int productCode, Model model) throws Exception{
		log.info("CommentController mCommentServiceList().....");
		List<CommentDTO> cList =  commentService.commentList(productCode);
		log.info("============================================================================");
		log.info("CommentController mCommentServiceList() Return : " + cList);
		return cList;
	       // return commentService.commentList(productCode);
    }
	
	/*-------------------------------------------------------------------------------------------------
	* 댓글 수정
	-------------------------------------------------------------------------------------------------*/
	@RequestMapping("/update")
	@ResponseBody
	private int mCommentServiceUpdateProc(@RequestParam int cno, @RequestParam String content) throws Exception {
	
		CommentDTO comment = new CommentDTO();
		comment.setCno(cno);
		comment.setContent(content);
		
		return commentService.commentUpdate(comment);
	}
	
	/*-------------------------------------------------------------------------------------------------
	* 댓글 삭제
	-------------------------------------------------------------------------------------------------*/
	@RequestMapping("/delete/{cno}")
	@ResponseBody
	private int mCommentServiceDelete(@PathVariable int cno) throws Exception {
		
		return commentService.commentDelete(cno);
	}
	
}/*End - public class CommentController*/

