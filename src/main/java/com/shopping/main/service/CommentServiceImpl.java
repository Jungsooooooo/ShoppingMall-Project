package com.shopping.main.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.shopping.main.dao.CommentDAO;
import com.shopping.main.dto.CommentDTO;

import lombok.extern.java.Log;

/*-------------------------------------------------------------------------------------------------
* public class commentServiceImpl
-------------------------------------------------------------------------------------------------*/
@Log
@Service
public class CommentServiceImpl implements CommentService {

	@Inject 
	CommentDAO commentDAO;
	
	/*-------------------------------------------------------------------------------------------------
	* 댓글 등록
	-------------------------------------------------------------------------------------------------*/
	@Override
	public int commentInsert(CommentDTO comment) throws Exception {
		return commentDAO.commentInsert(comment);
	}
	
	/*-------------------------------------------------------------------------------------------------
	* 댓글 리스트
	-------------------------------------------------------------------------------------------------*/
	@Override
	public List<CommentDTO> commentList(int productCode) throws Exception {
		return commentDAO.commentList(productCode);
	}
	
	/*-------------------------------------------------------------------------------------------------
	* 댓글 수정
	-------------------------------------------------------------------------------------------------*/
	@Override
	public int commentUpdate(CommentDTO comment) throws Exception {
		return commentDAO.commentUpdate(comment);
	}

	/*-------------------------------------------------------------------------------------------------
	* 댓글 삭제
	-------------------------------------------------------------------------------------------------*/
	@Override
	public int commentDelete(int cno) throws Exception {
		return commentDAO.commentDelete(cno);
	}

} // End - public class commentServiceImpl
