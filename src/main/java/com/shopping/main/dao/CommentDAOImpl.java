package com.shopping.main.dao;

import java.util.List;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.shopping.main.dto.CommentDTO;

import lombok.extern.java.Log;

/*-------------------------------------------------------------------------------------------------
* public class CommentDAOImpl
-------------------------------------------------------------------------------------------------*/
@Log
@Repository
public class CommentDAOImpl implements CommentDAO {

	@Inject
	SqlSession sqlSession;
	
	private static String namespace = "com.shopping.main.mappers.CommentMapper";
	
	/*-------------------------------------------------------------------------------------------------
	 * 댓글 등록
	-------------------------------------------------------------------------------------------------*/
	@Override
	public int commentInsert(CommentDTO commentDTO) throws Exception {
		log.info("CommentDAOImpl insert() => " + commentDTO);
		return sqlSession.insert(namespace + ".commentInsert", commentDTO);
	}
	
	/*-------------------------------------------------------------------------------------------------
	* 댓글 리스트
	-------------------------------------------------------------------------------------------------*/
	@Override
	public List<CommentDTO> commentList(int productCode) throws Exception {
		log.info("productCode ==> " + productCode);
		return sqlSession.selectList(namespace + ".commentList", productCode);
	}
	
	/*-------------------------------------------------------------------------------------------------
	* 댓글 수정
	-------------------------------------------------------------------------------------------------*/
	@Override
	public int commentUpdate(CommentDTO commentDTO) throws Exception {
		log.info("CommentDAOImpl update() => " + commentDTO);
		return sqlSession.update(namespace + ".commentUpdate", commentDTO);
	}

	/*-------------------------------------------------------------------------------------------------
	* 댓글 삭제
	-------------------------------------------------------------------------------------------------*/
	@Override
	public int commentDelete(int cno) throws Exception {
		log.info("CommentDAOImpl delete() => " + cno);
		return sqlSession.delete(namespace + ".commentDelete", cno);
	}

} // End - public class CommentDAOImpl
