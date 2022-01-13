package com.shopping.member.dao;

import java.util.List;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Repository;

import com.shopping.member.dto.MemberDTO;
import com.shopping.member.service.MemberServieImpl;

//-----------------------------------------------------------------------------------------------------------
// public class MemberDAOImpl implements MemberDAO
//-----------------------------------------------------------------------------------------------------------
// MemberDAOImpl를 Bean으로 등록하기 위해서 root-context.xml안에 component-scan을 등록해야 한다.
// MemberDAOImpl에 @Repository 어노테이션이 설정되어 있더라도
// 스프링에서 해당 패키지를 스캔하지 않으면 Spring Bean으로 등록할 수가 없다.
// root-context.xml에 Bean으로 등록할 패키지를 기술해야 한다.
//-----------------------------------------------------------------------------------------------------------
@Repository
public class MemberDAOImpl implements MemberDAO {

	private static final Logger logger = LoggerFactory.getLogger(MemberDAOImpl.class);

	// -----------------------------------------------------------------------------------------------------------
	// 컨트롤러는 서비스를 호출하고, 서비스는 DAO를 호출하고, DAO는 SqlSession을 호출한다.
	// -----------------------------------------------------------------------------------------------------------
	@Inject
	private SqlSession sqlSession;

	private static final String nameSpace = "com.shopping.member.mapper.memberMapper";

	// -------------------------------------------------------------------------------------------------
	// public List<MemberDTO> selectMember() : 회원 목록
	// -------------------------------------------------------------------------------------------------
	@Override
	public List<MemberDTO> selectMember() throws Exception {
		return sqlSession.selectList(nameSpace + ".selectMember");
	} // End - public List<MemberDTO> selectMember()

	// -------------------------------------------------------------------------------------------------
	// 회원 상세 정보
	// -------------------------------------------------------------------------------------------------
	@Override
	public MemberDTO view(String id) throws Exception {
		return sqlSession.selectOne(nameSpace + ".view", id);
	}

	// -------------------------------------------------------------------------------------------------
	// 로그인
	// -------------------------------------------------------------------------------------------------
	@Override
	public MemberDTO login(MemberDTO memberDTO) throws Exception {
		logger.info("로그인 : " + memberDTO);
		return sqlSession.selectOne(nameSpace + ".login", memberDTO);
	}

	// -----------------------------------------------------------------------------------------------------------
	// 아이디 중복 검사
	// -----------------------------------------------------------------------------------------------------------
	@Override
	public int idCheck(MemberDTO memberDTO) throws Exception {

		logger.info("MemberDAOImpl 아이디 중복 검사()");
		return sqlSession.selectOne(nameSpace + ".idCheck", memberDTO);

	} // End - public int idCheck(MemberDTO memberDTO)

	// -------------------------------------------------------------------------------------------------
	// 회원 가입
	// -------------------------------------------------------------------------------------------------
	@Override
	public int memberInsert(MemberDTO memberDTO) throws Exception {
		logger.info("MemberDAOImpl memberInsert(MemberDTO memberDTO).....");
		return sqlSession.insert(nameSpace + ".insert", memberDTO);
	}

	// -------------------------------------------------------------------------------------------------
	// 회원가입 POST (Ajax)
	// -------------------------------------------------------------------------------------------------
	@Override
	public int register(MemberDTO memberDTO) throws Exception {
		logger.info("회원가입(Ajax) : " + memberDTO);
		return sqlSession.insert(nameSpace + ".register", memberDTO);
	}

	// -------------------------------------------------------------------------------------------------
	// 회원 정보 수정
	// -------------------------------------------------------------------------------------------------
	@Override
	public void update(MemberDTO memberDTO) throws Exception {
		sqlSession.update(nameSpace + ".update", memberDTO);
	}

	// 아이디 찾기
	public String findidform(String userEmail) throws Exception{
		return sqlSession.selectOne(nameSpace + ".findidform", userEmail);
	}

	// 비밀번호 찾기
		public String memberfindpwform(MemberDTO memberDTO) throws Exception {
			return sqlSession.selectOne(nameSpace + ".memberfindpwform", memberDTO);
	}

	// -------------------------------------------------------------------------------------------------
	// 회원 가입
	// -------------------------------------------------------------------------------------------------
	@Override
	public int memberDelete(String userId) throws Exception {
		logger.info("MemberDAOImpl memberInsert(MemberDTO memberDTO).....");
		return sqlSession.delete(nameSpace + ".delete", userId);
	}

	// -----------------------------------------------------------------------------------------------------------
	//이메일 중복 검사
	// -----------------------------------------------------------------------------------------------------------
	@Override
	public int eCheck(MemberDTO memberDTO) throws Exception {

		logger.info("MemberDAOImpl 이메일 중복 검사()");
		return sqlSession.selectOne(nameSpace + ".eCheck", memberDTO);

	}


} // End - public class MemberDAOImpl implements MemberDAO
