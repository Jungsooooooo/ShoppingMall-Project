package com.shopping.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import com.shopping.member.dto.MemberDTO;

/*-------------------------------------------------------------------------------------------------
* public class LoginInterceptor
-------------------------------------------------------------------------------------------------*/
@SuppressWarnings("deprecation")
public class LoginInterceptor extends HandlerInterceptorAdapter {

	/*-------------------------------------------------------------------------------------------------
	* 관리자 페이지 접근 관리
	-------------------------------------------------------------------------------------------------*/
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		
		// 세션 객체를 가져온다.
		HttpSession session = request.getSession();
		
		//login처리를 담당하는 사용자 정보를 담고 있는 객체를 가져온다.
		MemberDTO memberDTO = (MemberDTO)session.getAttribute("member");
		Object obj = session.getAttribute("member");
		
		if(obj == null) {
			//로그인이 안되어 있는 상태 다시 돌려보낸다.(redirect)
			response.sendRedirect("/");
			return false;	//더이상 컨트롤러의 요청으로 가지 않도록 false로 반환한다.
		} else {
			//if(memberDTO.getUserId() != "master") {
			if(!memberDTO.getUserId().equals("master")) {
				response.sendRedirect("/");
				return false;	//더이상 컨트롤러의 요청으로 가지 않도록 false로 반환한다.
			}
			return true; 
		}
		
	}
	
	
	
}/*public class LoginInterceptor*/