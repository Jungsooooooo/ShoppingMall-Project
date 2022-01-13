package com.shopping.member.controller;

import java.util.List;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.shopping.member.dto.MemberDTO;
import com.shopping.member.service.MemberService;

//-----------------------------------------------------------------------------------------------------------
// public class MemberController
//-----------------------------------------------------------------------------------------------------------
@Controller // 컨트롤러 빈으로 등록된다.
@RequestMapping("/member") // 공통으로 처리할 URL 매핑
public class MemberController {

	@Autowired
	private MemberService service;

	private static final Logger logger = LoggerFactory.getLogger(MemberController.class);

	// -----------------------------------------------------------------------------------------------------------
	// 컨트롤러는 서비스를 호출하고, 서비스는 DAO를 호출하고, DAO는 SqlSession을 호출한다.
	// -----------------------------------------------------------------------------------------------------------
	@Inject
	private MemberService memberService;

	// -------------------------------------------------------------------------------------------------
	// public String memberList(Model model) : 회원 목록
	// -------------------------------------------------------------------------------------------------
	@RequestMapping(value = "/memberList", method = RequestMethod.GET)
	public String memberList(Model model) throws Exception {

		logger.info("Controller memberList().....");

		List<MemberDTO> memberList = memberService.selectMember();

		logger.info("Controller memberList() ==> " + memberList);

		model.addAttribute("memberList", memberList);

		return "member/memberList";
	} // End - public String memberList(Model model)

	// -------------------------------------------------------------------------------------------------
	// 회원 상세 정보
	// -------------------------------------------------------------------------------------------------
	@RequestMapping(value = "/memberView", method = RequestMethod.GET)
	public void getView(@RequestParam("userId") String userId, Model model) throws Exception {
		logger.info("MemberController id : " + userId);
		MemberDTO view = memberService.view(userId);
		model.addAttribute("view", view);
	}

	// -------------------------------------------------------------------------------------------------
	// 로그인 GET
	// -------------------------------------------------------------------------------------------------
	@RequestMapping(value = "/login", method = RequestMethod.GET)
	public String getLogin() throws Exception {
		return "/member/login";
	}

	// -------------------------------------------------------------------------------------------------
	// 로그인 POST
	// -------------------------------------------------------------------------------------------------
	@RequestMapping(value = "/login", method = RequestMethod.POST)
	public String login(MemberDTO memberDTO, HttpServletRequest req, RedirectAttributes rttr) throws Exception {

		HttpSession session = req.getSession();

		// 넘겨받은 회원정보를 가지고 Service에게 의뢰한다.
		MemberDTO login = memberService.login(memberDTO);

		// RedirectAttributes : redirect로 리턴하는 코드가 있어야 한다.
		// Model : jsp페이지를 거쳐갈때는 model로 값을 보내주면 된다.

		// 해당하는 회원정보가 없다면
		if (login == null) {
			session.setAttribute("member", null);
			rttr.addFlashAttribute("msg", false);
		} else {
			// 로그인이 정상이라면 세션을 발급한다.
			session.setAttribute("member", login);
			session.setAttribute("userid", memberDTO.getUserId());
		}
		return "redirect:/member/login";
	}

	// -------------------------------------------------------------------------------------------------
	// 로그아웃
	// -------------------------------------------------------------------------------------------------
	@RequestMapping(value = "/logout", method = RequestMethod.GET)
	public String logout(HttpSession session) throws Exception {
		// 로그아웃 버튼을 눌렀을 경우에는 세션을 없앤다.
		session.invalidate();
		return "redirect:/member/login";
	}

	// -------------------------------------------------------------------------------------------------
	// 회원 가입 : GET
	// -------------------------------------------------------------------------------------------------
	@RequestMapping(value = "/memberInsert", method = RequestMethod.GET)
	public String memberInsertGet() throws Exception {
		logger.info("MemberController memberInsertGET().....");
		return "/member/memberInsert";
	}

	// -------------------------------------------------------------------------------------------------
	// 회원 가입 : POST
	// -------------------------------------------------------------------------------------------------
	@RequestMapping(value = "/memberInsert", method = RequestMethod.POST)
	public String memberInsertPost(MemberDTO memberDTO) throws Exception {

		logger.info("MemberController memberInsertPost(MemberDTO memberDTO).....");

		// 회원 아이디가 존재하는지 먼저 검사한다.
		int result = memberService.idCheck(memberDTO);

		try {
			if (result == 1) {
				return "/member/memberInsert";
			} else if (result == 0) {
				memberService.memberInsert(memberDTO);
			}
		} catch (Exception e) {
			throw new RuntimeException();
		}
		return "redirect:/member/login";
		// return "redirect:/member/login";
	}

	// -----------------------------------------------------------------------------------------------------------
	// 아이디 중복 검사
	// -----------------------------------------------------------------------------------------------------------
	@ResponseBody
	@RequestMapping(value = "/idCheck", method = RequestMethod.POST)
	public int idCheck(MemberDTO memberDTO) throws Exception {

		logger.info("MemberController 아이디 검사()");

		int result = memberService.idCheck(memberDTO);

		logger.info("MemberController 아이디 검사() 결과 ==> " + result);

		return result;

	} // End - public int idCheck(MemberDTO memberDTO)

	// -------------------------------------------------------------------------------------------------
	// 회원 정보 수정 GET
	// -------------------------------------------------------------------------------------------------
	@RequestMapping(value = "/memberUpdate/{userId}", method = RequestMethod.GET)
	public String getMemberUpdate(@PathVariable String userId, Model model) throws Exception {
		MemberDTO view = memberService.view(userId);
		model.addAttribute("view", view);
		return "/member/memberUpdate";
	}
	
	// -------------------------------------------------------------------------------------------------
	// 회원 탈퇴
	// -------------------------------------------------------------------------------------------------
	@RequestMapping(value = "/memberDelete/{userId}", method = RequestMethod.GET)
	private String productDelete(@PathVariable String userId) throws Exception {
		memberService.memberDelete(userId);
		return "redirect:/member/logout";
	}

	// -------------------------------------------------------------------------------------------------
	// 회원 정보 수정 POST
	// -------------------------------------------------------------------------------------------------
	@RequestMapping(value = "/memberUpdate", method = RequestMethod.POST)
	public String postMemberUpdate(MemberDTO memberDTO) throws Exception {
		// logger.info(memberDTO.getAddress());
		memberService.update(memberDTO);
		return "redirect:/member/login";
	}

	// 아이디 찾기 폼
		@RequestMapping(value = "/findidpage", method = RequestMethod.GET)
		public String findidpage() throws Exception {
			return "/member/findidpage";
		}

		// 아이디 찾기
		@RequestMapping(value = "/findidform", method = RequestMethod.POST)
		public String findidform(HttpServletResponse response, @RequestParam("userEmail") String userEmail, Model md)
				throws Exception {
			md.addAttribute("userId", service.findidform(response, userEmail));
			return "/member/findidform";
		}

		// 비밀번호 찾기 폼
		@RequestMapping("/findpwpage")
		public String findpwpage() {
			return "/member/findpwpage";
		}

		// 비밀번호 찾기
		@RequestMapping( "/findpwform")
		public String memberfindpwform(HttpServletResponse response, MemberDTO memberDTO, Model md) throws Exception {
			md.addAttribute("userPw",service.memberfindpwform(response, memberDTO));
			return "/member/findpwform";
		}

		// -----------------------------------------------------------------------------------------------------------
		// 이메일 중복 검사
		// -----------------------------------------------------------------------------------------------------------
		@ResponseBody
		@RequestMapping(value = "/eCheck", method = RequestMethod.POST)
		public int eCheck(MemberDTO memberDTO) throws Exception {

			logger.info("MemberController 이메일 검사()");

			int result = memberService.eCheck(memberDTO);

			logger.info("MemberController 이메일 검사() 결과 ==> " + result);

			return result;

		}
		
		// -------------------------------------------------------------------------------------------------
		// new 로그인 GET
		// -------------------------------------------------------------------------------------------------
		@RequestMapping(value = "/newLogin", method = RequestMethod.GET)
		public void newLogin() throws Exception {
			
		}

} // End - public class MemberController