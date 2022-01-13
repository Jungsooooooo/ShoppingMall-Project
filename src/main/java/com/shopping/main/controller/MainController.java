package com.shopping.main.controller;

import java.text.DecimalFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.shopping.main.dto.BankDTO;
import com.shopping.main.dto.BuyDTO;
import com.shopping.main.dto.CartDTO;
import com.shopping.main.dto.PaymentMethodDTO;
import com.shopping.main.dto.PreBuyDTO;
import com.shopping.main.service.MainService;
import com.shopping.manager.dto.FaqDTO;
import com.shopping.manager.dto.ManagerDTO;
import com.shopping.manager.dto.PageMaker;
import com.shopping.manager.dto.SearchCriteria;
import com.shopping.member.dto.MemberDTO;
import com.shopping.member.service.MemberService;

import lombok.extern.java.Log;

/*-----------------------------------------------------------------------------------------------------------
* public class MainController
 ----------------------------------------------------------------------------------------------------------*/
@Log
@Controller
@RequestMapping(value = "/main")
public class MainController {
	
	@Inject
	MainService mainService;
	@Inject
	MemberService memberService;
	
	/*-----------------------------------------------------------------------------------------------------------
	* 상품 분류에 해당하는 화면
	----------------------------------------------------------------------------------------------------------*/
	@RequestMapping(value="/detail", method=RequestMethod.GET)
	private ModelAndView productDetail(ModelAndView mav,@RequestParam (value="productClass", required=false)String productClass, Model model,@RequestParam int listNum) throws Exception {
		log.info("1 ");
	if(productClass== null) {
		Map<String, Object> map=new HashMap<>();
		List<ManagerDTO> List = mainService.productDetailBest(productClass);
		map.put("listNum", listNum);
		map.put("productClass", productClass);
		mav.addObject("map", map);
		log.info("productClass의 값은:"+productClass);
		model.addAttribute("detail", List);
		mav.setViewName("main/detail");		
		return mav;
		
	}else {
		if(listNum == 1){
			List<ManagerDTO> List = mainService.productDetailregdate(productClass);
			Map<String, Object> map=new HashMap<>();
			map.put("productClass", productClass);
			mav.addObject("map", map);
			model.addAttribute("detail", List);
			mav.setViewName("main/detail");		
		} else if(listNum ==2) {
			List<ManagerDTO> List = mainService.productDetaillowprice(productClass);
			Map<String, Object> map=new HashMap<>();
			map.put("productClass", productClass);
			mav.addObject("map", map);
			model.addAttribute("detail", List);
			mav.setViewName("main/detail");
		} else if(listNum ==3) {
			List<ManagerDTO> List = mainService.productDetailhighprice(productClass);
			Map<String, Object> map=new HashMap<>();
			map.put("productClass", productClass);
			mav.addObject("map", map);
			model.addAttribute("detail", List);
			mav.setViewName("main/detail");
		}
		else {//전체 장바구니 상품들 찾는 메서드
			List<ManagerDTO> List = mainService.productDetail(productClass);
			Map<String, Object> map=new HashMap<>();
			map.put("productClass", productClass);
			mav.addObject("map", map);
			model.addAttribute("detail", List);
		}
		return mav;	
		}
	}
	
	//-----------------------------------------------------------------------------------------------------------
	// 상품 분류에 해당하는 화면에서 상품이름을 클릭하면 상세화면으로 넘어간다.
	//-----------------------------------------------------------------------------------------------------------
	@RequestMapping(value = "/productDetail/{productName}", method = RequestMethod.GET)
	private ModelAndView productInDetail(@PathVariable String productName, Model model, ModelAndView mav, HttpSession session) throws Exception {

		String userId = (String) session.getAttribute("userid");
	  
		if(userId != null) {
	        model.addAttribute("userId", userId);
	    }
	    
		Map<String, Object> map=new HashMap<>();
		List<CartDTO> list = mainService.listCart2(productName,userId);
		ManagerDTO productInDetail = mainService.listCart3(productName);
		map.put("list", list);
		model.addAttribute("productInDetail", productInDetail);
		mav.setViewName("main/productDetail");
		mav.addObject("map", map);
		
		Integer checkBuy = mainService.checkBuy(productName, userId);
		int checkComment = mainService.checkComment(Integer.toString(productInDetail.getProductCode()), userId);
		log.info("checkBuy" +checkBuy);
		log.info("checkComment" +checkComment);
		
		if(checkBuy == null) {
			model.addAttribute("checkBuy", 0);
			model.addAttribute("checkComment", checkComment);
		} else {
			model.addAttribute("checkBuy", checkBuy);
			model.addAttribute("checkComment", checkComment);
		}			
		
		return mav;
	}
	
	/*-------------------------------------------------------------------------------------------------
	* 구매로 가는 메서드
	-------------------------------------------------------------------------------------------------*/
	@RequestMapping(value="/buy/order", method=RequestMethod.GET)
	public void getAllBuy(PreBuyDTO preBuyDTO, int[] hidecheck, HttpSession session, Model model) throws Exception {
      		
	    // 캘린더 호출
	    Calendar cal = Calendar.getInstance();
	    int year = cal.get(Calendar.YEAR);  // 연도 추출
	    String ym = year + new DecimalFormat("00").format(cal.get(Calendar.MONTH) + 1);  // 월 추출
	    String ymd = ym +  new DecimalFormat("00").format(cal.get(Calendar.DATE));  // 일 추출
	    String subNum = "";  // 랜덤 숫자를 저장할 문자열 변수
	      
	    for(int i = 1; i <= 6; i ++) {  // 6회 반복
	        subNum += (int)(Math.random() * 10);  // 0~9까지의 숫자를 생성하여 subNum에 저장
	    }
	      
	    String buyNum = ymd + "_" + subNum;  // [연월일]_[랜덤숫자] 로 구성된 문자
	    model.addAttribute("buyNum",buyNum);
		
		String userId =(String)session.getAttribute("userid");
		
		if(preBuyDTO.getProductName() != null) { //상품 상세 페이지에서 바로구매
			log.info("-------------------------------------------구매 페이지 진입" + preBuyDTO);
			List<PreBuyDTO> listBuy = new ArrayList<PreBuyDTO>(); 
			listBuy.add(preBuyDTO);
			model.addAttribute("listBuy", listBuy);
			model.addAttribute("hidecheck", "no");
		} else {
			if(hidecheck == null) {//전체 장바구니 상품들 찾는 메서드
				List<CartDTO> listBuy = mainService.showCarts(userId);
				model.addAttribute("listBuy", listBuy);
				model.addAttribute("hidecheck", "all");
			} else {//선택 장바구니 상품들 찾는 메서드
				List<CartDTO> listBuy = new ArrayList<CartDTO>();
				for(int i = 0; i < hidecheck.length; i++) {
					CartDTO cart = new CartDTO(); 
					cart = mainService.showSelectCarts(hidecheck[i]);
					listBuy.add(cart);
					log.info("Cart  One  : " + cart);
					log.info("Carts List : " + listBuy);
				}
				model.addAttribute("listBuy", listBuy);
				model.addAttribute("hidecheck", hidecheck);
			}
		}
		
		//로그인한 정보 불러오기
		MemberDTO view =  memberService.view(userId);
		model.addAttribute("view", view);	
		
		//결제 방법 리스트
		log.info("결제 방법 리스트 가져오기 ");
		List<PaymentMethodDTO> list =  null;
		list = mainService.selectPaymentMethod();		
		model.addAttribute("selectPaymentMethod", list);	
		
		//무통장입금 선택란
		log.info("무통장입금 가져오기 ");
		List<BankDTO> list2 =  null;
		list2 = mainService.selectBank();		
		model.addAttribute("selectBank", list2);
	}	
		
	//----------------------------------------------------------------------------------------------------------
	// buy 디비 값 넣기
	//----------------------------------------------------------------------------------------------------------
	@ResponseBody
	@RequestMapping(value = "/buy/goCompleteBuy", method = RequestMethod.POST)
	public int completeBuy(BuyDTO completeBuy, HttpSession session) throws Exception {	 
		
		log.info("1----------------------------------------------구매확정 페이지"+completeBuy);
		MemberDTO member = (MemberDTO)session.getAttribute("member");
		
		completeBuy.setUserId(member.getUserId());
		
		int rtnValue = mainService.buy(completeBuy);		
		return rtnValue;		
		
	}
	
	/*-----------------------------------------------------------------------------------------------------------
	* 구매 완료 후 장바구니 비우기
	----------------------------------------------------------------------------------------------------------*/
	@RequestMapping(value = "/buy/deleteCart")
	public void deleteCart(String[] hidecheck, HttpSession session) throws Exception {
		
		String userId=(String)session.getAttribute("userid");
		
		for(int i = 0; i < hidecheck.length; i++) {
			log.info("hidecheck" +hidecheck[i]);
			
			if(hidecheck[i].equals("all")) {
		        mainService.deleteAll(userId);
			} else {
				mainService.selectdelete(hidecheck[i]);
			}
		}	
		
	}
			
	//----------------------------------------------------------------------------------------------------------
	// 구매목록 보기
	//----------------------------------------------------------------------------------------------------------
	@RequestMapping(value = "/buy/buyList/{userId}", method = RequestMethod.GET)
    public ModelAndView list(BuyDTO buy, HttpServletRequest request, HttpSession session, ModelAndView mav) throws Exception {
		
		log.info("구매목록 페이지 진입");
        Map<String, Object> map=new HashMap<>();
      
        String userId =(String)session.getAttribute("userid");
    	log.info("1----------------------------------------------구매목록 페이지 진입");
        //session에 저장된 userid를 getAttribute()메소드를 사용해서 얻어오고 오브젝트 타입이기 때문에
        //String 타입으로 타입변환한다.
    	log.info("2----------------------------------------------구매목록 페이지 진입");
        if(userId!=null) { 
            //로그인한 상태이면 실행
            List<BuyDTO> list = mainService.buyList(userId);//구매목록 목록
            List<ManagerDTO> list2 = mainService.listProductCount(userId);
            int sumBuyMoney = mainService.sumBuyMoney(userId); // 구매목록 전체 금액 호출
         // 장바구니 전체 긍액에 따라 배송비 구분
         // 배송료(10만원이상 => 무료, 미만 => 2500원)
            int fee = sumBuyMoney >= 100000 ? 0 : 2500;
            
        	log.info("3----------------------------------------------구매목록 페이지 진입");
           //hasp map에 장바구니에 넣을 각종 값들을 저장함
        	map.put("sumBuyMoney", sumBuyMoney); // 구매목록 전체 금액
        	map.put("fee", fee); // 배송금액
        	map.put("allSum", sumBuyMoney+fee); // 구매 상품 전체 금액
        	log.info("구매목록-----------------------------------------------" + list);
            map.put("list", list); //구매목록 목록
            map.put("list2", list2);
            map.put("count", list.size()); //레코드 갯수
        	log.info("4----------------------------------------------구매목록 페이지 진입");
        	//ModelAndView mav에 이동할 페이지의 이름과 데이터를 저장한다.
        	log.info("5----------------------------------------------구매목록 페이지 진입");
            mav.setViewName("main/buy/buyList"); //이동할 페이지의 이름
            mav.addObject("map", map); //데이터 저장
        	log.info("6----------------------------------------------구매목록 페이지 진입");
            return mav; //화면 이동
        } else { //로그인을 하지 않았으면 로그인 페이지로 이동시킨다.
            return new ModelAndView("member/login", "", null);
        }
    }
	
	/*-----------------------------------------------------------------------------------------------------------
	* 장바구니 담기
	----------------------------------------------------------------------------------------------------------*/
	@ResponseBody
	@RequestMapping(value = "/cart/goCart", method = RequestMethod.POST)
	public int addCart(CartDTO cart, HttpSession session) throws Exception {
		
		log.info("1----------------------------------------------장바구니 페이지 진입");
		MemberDTO member = (MemberDTO)session.getAttribute("member");
		
		cart.setUserId(member.getUserId());
		
		int count = mainService.countCart(cart);
		log.info("MainController Return ==> " + count);
		if(count == 0){
			// 없으면 insert
			int rtnValue = mainService.addCart(cart);
			return rtnValue;
		} else {
			// 있으면 update
			int rtnValue = mainService.updateCart(cart);
			return rtnValue;
		}	
	}
	
	/*-----------------------------------------------------------------------------------------------------------
	* 장바구니 목록보기
	----------------------------------------------------------------------------------------------------------*/
	@RequestMapping(value = "/cart/cartList", method = RequestMethod.GET)
    public ModelAndView list(CartDTO cart,HttpServletRequest request, HttpSession session, ModelAndView mav) throws Exception {
		
		log.info("장바구니 페이지 진입");
        Map<String, Object> map=new HashMap<>();
      
        String userId =(String)session.getAttribute("userid");
    	log.info("1----------------------------------------------장바구니 페이지 진입");
        //session에 저장된 userid를 getAttribute()메소드를 사용해서 얻어오고 오브젝트 타입이기 때문에
        //String 타입으로 타입변환한다.
    	log.info("1----------------------------------------------장바구니 페이지 진입");
        if(userId!=null) { 
            //로그인한 상태이면 실행
            List<CartDTO> list = mainService.listCart(userId);//장바구니 목록
            List<ManagerDTO> list2 = mainService.listProductCount(userId);
            int sumMoney = mainService.sumMoney(userId); // 장바구니 전체 금액 호출
            // 장바구니 전체 긍액에 따라 배송비 구분
            // 배송료(10만원이상 => 무료, 미만 => 2500원)
            int fee = sumMoney >= 100000 ? 0 : 2500;
            
        	log.info("1----------------------------------------------장바구니 페이지 진입");
           //hasp map에 장바구니에 넣을 각종 값들을 저장함
        	map.put("sumMoney", sumMoney); // 장바구니 전체 금액
        	map.put("fee", fee); // 배송금액
        	map.put("allSum", sumMoney+fee); // 주문 상품 전체 금액
            map.put("list", list); //장바구니 목록
            map.put("list2", list2);
            map.put("count", list.size()); //레코드 갯수
        	log.info("1----------------------------------------------장바구니 페이지 진입");
        	//ModelAndView mav에 이동할 페이지의 이름과 데이터를 저장한다.
        	log.info("2----------------------------------------------장바구니 페이지 진입");
            mav.setViewName("main/cart/cartList"); //이동할 페이지의 이름
            mav.addObject("map", map); //데이터 저장
        	log.info("3----------------------------------------------장바구니 페이지 진입");
            return mav; //화면 이동
        } else { //로그인을 하지 않았으면 로그인 페이지로 이동시킨다.
            return new ModelAndView("member/login", "", null);
        }
    }
	
	/*-----------------------------------------------------------------------------------------------------------
	* 장바구니 선택삭제
	----------------------------------------------------------------------------------------------------------*/
	 @RequestMapping(value = "/selectdelete")
	 public String ajaxTest(HttpServletRequest request) {
		 
		String[] ajaxMsg = request.getParameterValues("valueArr");
		int size = ajaxMsg.length;
		for(int i=0; i<size; i++) {
			mainService.selectdelete(ajaxMsg[i]);
		}
		return "redirect:cart/cartList";
	}
	 
	/*-----------------------------------------------------------------------------------------------------------
	* 장바구니 목록 삭제
	----------------------------------------------------------------------------------------------------------*/
	@RequestMapping("delete.do")
    public String delete(@RequestParam int cartNum) throws Exception{
        mainService.delete(cartNum);
        return "redirect:cart/cartList";
    }
	
	/*-----------------------------------------------------------------------------------------------------------
	* 장바구니 전체 삭제
	----------------------------------------------------------------------------------------------------------*/
    @RequestMapping("deleteAll.do")
    public String deleteAll(HttpSession session) throws Exception{
        String userId=(String)session.getAttribute("userid");
        if(userId!=null) {
            mainService.deleteAll(userId);
        }
        return "redirect:cart/cartList";
    }
    
	/*-----------------------------------------------------------------------------------------------------------
	* 장바구니 개별 수정
	----------------------------------------------------------------------------------------------------------*/
	@RequestMapping("update.do2")
    public String update2(@RequestParam int cartNum) throws Exception{
        mainService.delete(cartNum);
        return "redirect:cart/cartList";
    }
	
    /*-----------------------------------------------------------------------------------------------------------
	* 장바구니 수정
	----------------------------------------------------------------------------------------------------------*/
    @RequestMapping("update.do")
    public String update(@RequestParam int[] buy_productCount, @RequestParam int[] cartNum, HttpSession session) throws Exception{
	    // session의 id
	    String userId = (String) session.getAttribute("userid");
	    // 레코드의 갯수 만큼 반복문 실행
	    for(int i=0; i<buy_productCount.length; i++){
		    CartDTO dto = new CartDTO();
		    dto.setUserId(userId);
		    dto.setBuy_productCount(buy_productCount[i]);
		    dto.setCartNum(cartNum[i]);
		    mainService.modifyCart(dto);
	    }
	    return "redirect:cart/cartList";
    }

	//--------------------------------------------------------------------------------------------------
	// Faq 자료를 다 가져온다.
	//--------------------------------------------------------------------------------------------------
	@RequestMapping(value="/faq")
	private void getFaq(Model model, SearchCriteria cri) throws Exception {
		log.info("MainController getFaq() GET");
		
		// 데이터 타입의 자료를 모두 가져온다.		
		/*
		 * List<FaqTypeDTO> list= null; list = mainService.selectFaqType();
		 * log.info("ManagerController getData : " + list);
		 * model.addAttribute("selectFaqType", list);
		 */
		
		List<FaqDTO> list =null;
		list = mainService.selectFaq();
		log.info("managerController getData : " + list);
		model.addAttribute("selectFaq",list);
	}
	
	/*-----------------------------------------------------------------------------------------------------------
	* faq 목록(Paging 처리)
	----------------------------------------------------------------------------------------------------------*/
	@RequestMapping(value="/faq", method=RequestMethod.GET)
	   public ModelAndView faqList(SearchCriteria cri) throws Exception {
		
		log.info("---------------------------------------------------------------------");
		log.info("ManagerController memberList CRI ==> " + cri);
		log.info("---------------------------------------------------------------------");
		
		ModelAndView mav = new ModelAndView("/main/faq");
	    
		PageMaker pageMaker = new PageMaker();	
		pageMaker.setCri(cri);
		pageMaker.setTotalCount(mainService.faqListTotalCount(cri));
		
		//List<ManagerDTO>  list = managerService.memberListPaging(cri);
		List<FaqDTO>  list = mainService.faqListPaging(cri);
		
		mav.addObject("list", list);
	    mav.addObject("pageMaker", pageMaker);
	        
	    return mav;
	    
	   }
	//-------------------------------------------------------------------------------------------------
    // 상품보기_list에서 서치했을 때
    //-------------------------------------------------------------------------------------------------
    @RequestMapping("product_list_search")
    private String goodslist(Model model, SearchCriteria scri) throws Exception {

       
     /*  List<ManagerDTO> managerDTO = mainService.getSearchproduct(scri);
       model.addAttribute("product", managerDTO);
       */
       // 반찬 kind대로 뿌려주기
       List<ManagerDTO> products = mainService.searchproducts(scri);
       
       model.addAttribute("detail", products);
      
       log.info("ManagerController memberList CRI ==> " );
       return "main/detail";
       
    } // end String goodslist(Model model, SearchCriteria scri)
	
	
	
	
	
}