package com.shopping.manager.controller;

import java.io.File;
import java.util.List;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.commons.io.FilenameUtils;
import org.apache.commons.lang3.RandomStringUtils;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestPart;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.shopping.main.dto.BuyDTO;
import com.shopping.manager.dto.FaqDTO;
import com.shopping.manager.dto.FaqTypeDTO;
import com.shopping.manager.dto.FileDTO;
import com.shopping.manager.dto.ManagerDTO;
import com.shopping.manager.dto.PageMaker;
import com.shopping.manager.dto.ProductTypeDTO;
import com.shopping.manager.dto.SearchCriteria;
import com.shopping.manager.service.ManagerService;
import com.shopping.member.dto.MemberDTO;

import lombok.extern.java.Log;

/*-----------------------------------------------------------------------------------------------------------
* public class ManagerController
 ----------------------------------------------------------------------------------------------------------*/
@Log
@Controller
@RequestMapping(value = "/manager")
public class ManagerController {
	
	@Inject
	ManagerService managerService;
	
	/*-----------------------------------------------------------------------------------------------------------
	* 회원가입 페이지 이동
	----------------------------------------------------------------------------------------------------------*/
	@RequestMapping(value = "managerMain", method = RequestMethod.GET)
	public void managerMainGET() throws Exception {
		
		log.info("매니저 메인 페이지 진입");
				
	}

	/*-----------------------------------------------------------------------------------------------------------
	 * 상품 등록 : GET
	 ----------------------------------------------------------------------------------------------------------*/
	@RequestMapping(value="/product/productRegister", method=RequestMethod.GET)
	public void getProductRegister(Model model) throws Exception {
		log.info("ManagerController getProductRegister() GET");
		
		// 데이터 타입의 자료를 모두 가져온다.		
		List<ProductTypeDTO> list= null;
		list = managerService.selectProductType();
		log.info("ManagerController getData : " + list);
		model.addAttribute("selectProductType", list);
	}
	
	/*-----------------------------------------------------------------------------------------------------------
	* 상품 등록 : POST, 파일 등록
	----------------------------------------------------------------------------------------------------------*/
	@RequestMapping(value="/product/productRegister", method=RequestMethod.POST)
	private String registerProc(HttpServletRequest request, @RequestPart MultipartFile productImage) throws Exception {
		
		System.out.println("상품등록 페이지 진입.....");
		log.info("상품등록 페이지 진입");
		
		//게시글 등록 화면에서 입력한 값들을 실어나르기 위해 BoardVO를 생성한다.
		ManagerDTO managerDTO 	= new ManagerDTO();
		FileDTO	file	= new FileDTO();
		
		managerDTO.setProductClass(request.getParameter("productClass"));
		managerDTO.setProductName(request.getParameter("productName"));
		managerDTO.setProductPrice (Integer.parseInt(request.getParameter("productPrice")));
		managerDTO.setProductCount (Integer.parseInt(request.getParameter("productCount")));
		managerDTO.setProductContent (request.getParameter("productContent"));
		log.info("discount_rate=============================" +request.getParameter("discount_rate"));
		log.info("discount_rate=============================" +request.getParameter("discount_rate").length());
		
		if(request.getParameter("discount_rate").length() <= 0) {
			managerDTO.setDiscount_rate(0);
			log.info("getDiscount_rate=============================" +managerDTO.getDiscount_rate());
		} else if(Integer.parseInt(request.getParameter("discount_rate")) < 0 || Integer.parseInt(request.getParameter("discount_rate")) > 100) {
			managerDTO.setDiscount_rate(0);
		} else {
			managerDTO.setDiscount_rate (Integer.parseInt(request.getParameter("discount_rate")));
		}
		
		if(productImage.isEmpty()) {	// 업로드할 파일이 없는 경우
			managerService.productRegister(managerDTO);	// 게시글만 올린다.
		} else {	// 업로드할 파일이 있는 경우
			//FilenameUtils : commons-io defendency를 사용.
			String 	fileName = productImage.getOriginalFilename();
			String 	fileNameExtension = FilenameUtils.getExtension(fileName).toLowerCase();
			File	destinationFile;
			String	destinationFileName;
			// fileUrl = "uploadFiles 폴더의 위치";
			// uploadFiles 폴더의 위치 확인 : uploadFiles 우클릭 -> Properties -> Resource - > Location 
			String	fileUrl = "C:/upload/"; 
			
			
			do {
				destinationFileName = RandomStringUtils.randomAlphanumeric(32) + "." + fileNameExtension;
				destinationFile     = new File(fileUrl + destinationFileName);
			} while(destinationFile.exists());
			
			managerDTO.setProductImage (destinationFileName);
			
			// MultipartFile.transferTo() : 요청 시점의 임시 파일을 로컬 파일 시스템에 영구적으로 복사해준다.
			destinationFile.getParentFile().mkdirs();
			productImage.transferTo(destinationFile);
			
			managerService.productRegister(managerDTO);	// 게시글 올리기
			
			// 파일관련 자료를 Files 테이블에 등록한다.
			file.setProductCode(managerDTO.getProductCode());
			file.setFileName(destinationFileName);
			file.setFileOriName(fileName);
			file.setFileUrl(fileUrl);
			
			managerService.fileInsert(file); // 파일 올리기 완료
		}
		
		return "redirect:/manager/product/list";
	}
	
	/*-----------------------------------------------------------------------------------------------------------
	* 회원 목록(Paging 처리)
	----------------------------------------------------------------------------------------------------------*/
	@RequestMapping(value="/member/memberList", method=RequestMethod.GET)
	   public ModelAndView memberList(SearchCriteria cri) throws Exception {
		
		log.info("---------------------------------------------------------------------");
		log.info("ManagerController memberList CRI ==> " + cri);
		log.info("---------------------------------------------------------------------");
		
		ModelAndView mav = new ModelAndView("/manager/member/memberList");
	    
		PageMaker pageMaker = new PageMaker();	
		pageMaker.setCri(cri);
		pageMaker.setTotalCount(managerService.memberListTotalCount(cri));
		
		//List<ManagerDTO>  list = managerService.memberListPaging(cri);
		List<MemberDTO>  list = managerService.memberListPaging(cri);
		
		mav.addObject("list", list);
	    mav.addObject("pageMaker", pageMaker);
	        
	    return mav;
	    
	}
	
	/*-----------------------------------------------------------------------------------------------------------
	* 회원 번호에 해당하는 상세정보화면
	----------------------------------------------------------------------------------------------------------*/
	@RequestMapping("/member/memberDetail/{userNum}")
	private String memberDetail(@PathVariable int userNum, Model model) throws Exception {
		model.addAttribute("detail", managerService.memberDetail(userNum));
		
		return "/manager/member/memberDetail";
	}
	
	/*-----------------------------------------------------------------------------------------------------------
	* 회원 수정
	----------------------------------------------------------------------------------------------------------*/
	@RequestMapping("/member/update")
	private String memberUpdate(MemberDTO memberDTO, HttpServletRequest request, Model model) throws Exception {
		
		log.info("memberUpdate-----------------------------------------------------------------");
		managerService.memberUpdate(memberDTO);
		
		log.info("userNum-----------------------------------------------------------------" +memberDTO.getUserNum());
		model.addAttribute("detail", managerService.memberDetail(memberDTO.getUserNum()));
		return "/manager/member/memberDetail";
		
	}
	
	/*-----------------------------------------------------------------------------------------------------------
	* 회원 삭제
	----------------------------------------------------------------------------------------------------------*/
	@RequestMapping("/member/delete/{userNum}")
	private String memberDelete(@PathVariable int userNum) throws Exception {
		
		log.info("memberDelete-----------------------------------------------------------------");
		managerService.memberDelete(userNum);
		
		return "redirect:/manager/member/memberList";
	}
		
	//-------------------------------------------------------------------------------------------------
	// 상품 목록 보여주기(Paging 처리)
	//-------------------------------------------------------------------------------------------------
	@RequestMapping(value="/product/list", method = RequestMethod.GET)
	public ModelAndView productList(SearchCriteria cri) throws Exception {
	        
		log.info("---------------------------------------------------------------------");
		log.info("ManagerController productList CRI ==> " + cri);
		log.info("---------------------------------------------------------------------");
		
		ModelAndView mav = new ModelAndView("/manager/product/list");
	       
	    PageMaker pageMaker = new PageMaker();
	    // cri <= 검색조건과 검색할 값
	    pageMaker.setCri(cri);
	    // cri(검색할 조건과 값)을 가지고 검색한 총 건수를 TotalCount 변수에 저장한다.
	    pageMaker.setTotalCount(managerService.productListTotalCount(cri));
        
	    log.info("Board2Controller openBoardList pageMaker.getTotalCount(cri) ==> " + pageMaker.getTotalCount());

	    List<ManagerDTO>  list = managerService.productListPaging(cri);
	    mav.addObject("list", list);
	    mav.addObject("pageMaker", pageMaker);
	    
	    return mav;
	        
	}
	
	//-------------------------------------------------------------------------------------------------
	// 상품 번호에 해당하는 상세정보화면
	//-------------------------------------------------------------------------------------------------
	@RequestMapping("/product/detail/{productCode}")
	private String productDetail(@PathVariable int productCode, Model model) throws Exception {
		//product에 해당하는 자료를 찾아와서 model에 담는다.
		model.addAttribute("detail", managerService.productDetail(productCode));	//게시글의 정보를 가져와서 저장한다.
		return "/manager/product/detail";
	}
	
	//-------------------------------------------------------------------------------------------------
	// 상품을 수정 한다.
	//-------------------------------------------------------------------------------------------------
	@RequestMapping("/updateProc")
	private String productUpdateProc(HttpServletRequest request) throws Exception {
		//서비스에게 넘계줄 자료를 저장한다.
		log.info("1---------------------------------------------------------------------");
		ManagerDTO product = new ManagerDTO();
		product.setProductName(request.getParameter("name"));
		product.setProductClass(request.getParameter("class"));
		product.setProductContent(request.getParameter("content"));		
		product.setProductCode(Integer.parseInt(request.getParameter("productCode")));		
		product.setProductPrice(Integer.parseInt(request.getParameter("productPrice")));
		product.setProductCount(Integer.parseInt(request.getParameter("productCount")));
		product.setDiscount_rate(Integer.parseInt(request.getParameter("discount_rate")));
		
		log.info("2---------------------------------------------------------------------");
		managerService.productUpdate(product);
		log.info("3---------------------------------------------------------------------");
		
		return "redirect:/manager/product/list";
	}
	
	//-------------------------------------------------------------------------------------------------
	// 상품을 삭제한다.
	//-------------------------------------------------------------------------------------------------
	@RequestMapping("/delete/{productCode}")
	private String productDelete(@PathVariable int productCode) throws Exception {
		
		ManagerDTO managerDTO = managerService.productDetail(productCode);	
		String	fileUrl = "C:/upload/"; 
		String filePath = fileUrl +"/" + managerDTO.getProductImage();
		File file = new File(filePath);
		if(file.exists()) {
			file.delete();
		}
		
		managerService.productDelete(productCode);
		return "redirect:/manager/product/list";
	}
	
	//배송 관련
	@RequestMapping(value="/buy/buyList", method=RequestMethod.GET)
	   public ModelAndView buyList(SearchCriteria cri) throws Exception {
		
		log.info("---------------------------------------------------------------------");
		log.info("ManagerController buyList CRI ==> " + cri);
		log.info("---------------------------------------------------------------------");
		
		ModelAndView mav = new ModelAndView("/manager/buy/buyList");
	    
		PageMaker pageMaker = new PageMaker();	
		pageMaker.setCri(cri);
		pageMaker.setTotalCount(managerService.orderListTotalCount(cri));
		
		//List<ManagerDTO>  list = managerService.memberListPaging(cri);
		List<BuyDTO>  list = managerService.orderListPaging(cri);
		
		mav.addObject("list", list);
	    mav.addObject("pageMaker", pageMaker);
	    log.info("배송목록---");
	    return mav;
	    
	}
	
	//-------------------------------------------------------------------------------------------------
	// 주문 상세 목록 - 상태 변경
	//-------------------------------------------------------------------------------------------------
	@RequestMapping(value = "/buy/buyList", method = RequestMethod.POST)
	public String delivery(BuyDTO buyDTO) throws Exception {
		log.info("post order view"+buyDTO);
				
		managerService.delivery(buyDTO);
		
		log.info("..............." +buyDTO.getShipping());
		
		if(buyDTO.getShipping().equals("배송완료")) {
			log.info("..............." +buyDTO);
			managerService.changeCount(buyDTO);
		}
		return "redirect:/manager/buy/buyList?n=" + buyDTO.getBuyNum();
	}
	
	//-----------------------------------------------------------------------------------------------------------
	// faq 등록 : GET
	//----------------------------------------------------------------------------------------------------------
	@RequestMapping(value="/faq/faqRegister", method=RequestMethod.GET)
	public void getFaqRegister(Model model) throws Exception {
		log.info("ManagerController getFaqTypeRegister() GET");
		
		// 데이터 타입의 자료를 모두 가져온다.		
		List<FaqTypeDTO> list= null;
		list = managerService.selectFaqType();
		log.info("ManagerController getData : " + list);
		model.addAttribute("selectFaqType", list);
	}
	
	//-----------------------------------------------------------------------------------------------------------
	// faq 등록 : POST, 파일 등록
	//----------------------------------------------------------------------------------------------------------
	@RequestMapping(value="/faq/faqRegister", method=RequestMethod.POST)
	private String Postfaqregister(HttpServletRequest request) throws Exception {
		
		System.out.println("상품등록 페이지 진입.....");
		log.info("상품등록 페이지 진입");
		
		//게시글 등록 화면에서 입력한 값들을 실어나르기 위해 BoardVO를 생성한다.
		FaqDTO faqDTO  	= new FaqDTO();
		
		
		faqDTO.setFaqClass(request.getParameter("faqClass"));
		faqDTO.setTitle(request.getParameter("title"));
		faqDTO.setContent(request.getParameter("content"));
		System.out.println(faqDTO);
		
		managerService.faqRegister(faqDTO);
		
		
		return "redirect:/manager/faq/list";
	}
	//-----------------------------------------------------------------------------------------------------------
	// faq 목록(Paging 처리)
	//----------------------------------------------------------------------------------------------------------
	@RequestMapping(value="/faq/list", method=RequestMethod.GET)
	   public ModelAndView faqList(SearchCriteria cri) throws Exception {

		
		log.info("---------------------------------------------------------------------");
		log.info("ManagerController memberList CRI ==> " + cri);
		log.info("---------------------------------------------------------------------");
		
		ModelAndView mav = new ModelAndView("/manager/faq/list");
	    
		PageMaker pageMaker = new PageMaker();	
		pageMaker.setCri(cri);
		pageMaker.setTotalCount(managerService.faqListTotalCount(cri));
		
		//List<ManagerDTO>  list = managerService.memberListPaging(cri);
		List<FaqDTO>  list = managerService.faqListPaging(cri);
		
		mav.addObject("list", list);
	    mav.addObject("pageMaker", pageMaker);
	        
	    return mav;
	    
	   }
	
	//-------------------------------------------------------------------------------------------------
	//Faq 번호에 해당하는 상세정보화면
	//-------------------------------------------------------------------------------------------------
		@RequestMapping("/faq/detail/{bno}")
		private String faqDetail(@PathVariable int bno, Model model) throws Exception {
			//product에 해당하는 자료를 찾아와서 model에 담는다.
			model.addAttribute("detail", managerService.faqDetail(bno));	//게시글의 정보를 가져와서 저장한다.
			return "/manager/faq/detail";
		}
		
	//-------------------------------------------------------------------------------------------------
	//faq 번호에 해당하는 자료를 삭제한다.
	//-------------------------------------------------------------------------------------------------
		@RequestMapping("/faq/delete/{bno}")
		private String faqDelete(@PathVariable int bno) throws Exception {
			managerService.faqDelete(bno);
			return "redirect:/manager/faq/list";
		}	

	
}