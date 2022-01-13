package com.shopping.my;

import java.text.DateFormat;
import java.util.Date;
import java.util.List;
import java.util.Locale;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.shopping.manager.controller.ManagerController;
import com.shopping.manager.dto.ManagerDTO;
import com.shopping.manager.dto.ProductTypeDTO;
import com.shopping.manager.service.ManagerService;
import com.shopping.member.dto.MemberDTO;

import lombok.extern.java.Log;

/**
 * Handles requests for the application home page.
 */
@Log
@Controller
public class HomeController {

	@Inject
	ManagerService managerService;

	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);

	/**
	 * Simply selects the home view to render by returning its name.
	 * 
	 * @return
	 */
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String detail(Model model) throws Exception {
		log.info("ManagerController getProductRegister() GET");

		// 데이터 타입의 자료를 모두 가져온다.
		List<ManagerDTO> list = null;
		list = managerService.selectProduct();
		model.addAttribute("detail", list);


		return "home";
	}

}
