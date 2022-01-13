package com.shopping.member.service;

import java.io.PrintWriter;
import java.util.List;

import javax.inject.Inject;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import com.shopping.member.dao.MemberDAO;
import com.shopping.member.dto.MemberDTO;

//-----------------------------------------------------------------------------------------------------------
// public class MemberServieImpl implements MemberService
//-----------------------------------------------------------------------------------------------------------
@Service
public class MemberServieImpl implements MemberService {

	private static final Logger logger = LoggerFactory.getLogger(MemberServieImpl.class);

	// -----------------------------------------------------------------------------------------------------------
	// 컨트롤러는 서비스를 호출하고, 서비스는 DAO를 호출하고, DAO는 SqlSession을 호출한다.
	// -----------------------------------------------------------------------------------------------------------
	@Inject
	private MemberDAO memberDAO;

	// -------------------------------------------------------------------------------------------------
	// public List<MemberDTO> selectMember() : 회원 목록
	// -------------------------------------------------------------------------------------------------
	@Override
	public List<MemberDTO> selectMember() throws Exception {
		return memberDAO.selectMember();
	} // End - public List<MemberDTO> selectMember()

	// -------------------------------------------------------------------------------------------------
	// 회원 상세 정보
	// -------------------------------------------------------------------------------------------------
	@Override
	public MemberDTO view(String userId) throws Exception {
		logger.info("MemberServiceImpl view(String id).....");
		return memberDAO.view(userId);
	}

	// -------------------------------------------------------------------------------------------------
	// 로그인
	// -------------------------------------------------------------------------------------------------
	@Override
	public MemberDTO login(MemberDTO memberDTO) throws Exception {
		return memberDAO.login(memberDTO);
	}

	// -----------------------------------------------------------------------------------------------------------
	// 회원 아이디 중복 검사
	// -----------------------------------------------------------------------------------------------------------
	@Override
	public int idCheck(MemberDTO memberDTO) throws Exception {

		logger.info("MemberServieImpl 아이디 중복 검사()");
		int result = memberDAO.idCheck(memberDTO);
		return result;

	} // End - public int idCheck(MemberDTO memberDTO)

	// -------------------------------------------------------------------------------------------------
	// 회원 가입
	// -------------------------------------------------------------------------------------------------
	@Override
	public int memberInsert(MemberDTO memberDTO) throws Exception {
		logger.info("MemberServiceImpl memberInsert(MemberDTO memberDTO).....");

		if (!memberDTO.getUserPw().equals(memberDTO.getReuserPw())) {
			return -1;
		}
		int result = memberDAO.memberInsert(memberDTO);
		return result;
	}

	// -------------------------------------------------------------------------------------------------
	// 회원가입 POST (Ajax)
	// -------------------------------------------------------------------------------------------------
	@Override
	public int register(MemberDTO memberDTO) throws Exception {
		return memberDAO.register(memberDTO);
	}

	// -------------------------------------------------------------------------------------------------
	// 회원 정보 수정
	// -------------------------------------------------------------------------------------------------
	@Override
	public void update(MemberDTO memberDTO) throws Exception {
		logger.info("MemberServiceImpl update(MemberDTO memberDTO).....");
		memberDAO.update(memberDTO);
	}

	// -------------------------------------------------------------------------------------------------
	// 아이디 찾기
	// -------------------------------------------------------------------------------------------------
	public String findidform(HttpServletResponse response, String userEmail) throws Exception{
		response.setContentType("text/html;charset=utf-8");
		PrintWriter out = response.getWriter();
		String userId = memberDAO.findidform(userEmail);
		
		if (userId == null) {
			out.println("<script>");
			out.println("alert('가입된 이메일이 없습니다.');");
			out.println("history.go(-1);");
			out.println("</script>");
			out.close();
			return null;
		} else {
			return userId;
		}
	}

	// -------------------------------------------------------------------------------------------------
		// 비밀번호 찾기
		// -------------------------------------------------------------------------------------------------
		public String memberfindpwform(HttpServletResponse response, MemberDTO memberDTO) throws Exception {
			response.setContentType("text/html;charset=utf-8");
			PrintWriter out = response.getWriter();
			String userPw = memberDAO.memberfindpwform(memberDTO);
			
			if(userPw == null) {
				out.println("<script>");
				out.println("alert('입력한 id 또는 email을 찾을 수 없습니다.');");
				out.println("history.go(-1);");
				out.println("</script>");
				out.close();
				return null;
			}else {
				return userPw;
			}
		}



		// -------------------------------------------------------------------------------------------------
		// 게시글 삭제
		// -------------------------------------------------------------------------------------------------
		@Override
		public int memberDelete(String userId) throws Exception {
			return memberDAO.memberDelete(userId);
		}

		// -----------------------------------------------------------------------------------------------------------
		// 회원 이메일 중복 검사
		// -----------------------------------------------------------------------------------------------------------
		@Override
		public int eCheck(MemberDTO memberDTO) throws Exception {

			logger.info("MemberServieImpl 이메일 중복 검사()");
			int result = memberDAO.eCheck(memberDTO);
			return result;

		}

}
// End - public class MemberServieImpl implements MemberService
