package com.shopping.main.dao;

import java.util.List;
import java.util.Map;

import com.shopping.main.dto.BankDTO;
import com.shopping.main.dto.BuyDTO;
import com.shopping.main.dto.CartDTO;
import com.shopping.main.dto.PaymentMethodDTO;
import com.shopping.main.dto.PreBuyDTO;
import com.shopping.manager.dto.FaqDTO;
import com.shopping.manager.dto.FaqTypeDTO;
import com.shopping.manager.dto.ManagerDTO;
import com.shopping.manager.dto.SearchCriteria;
import com.shopping.member.dto.MemberDTO;


/*-------------------------------------------------------------------------------------------------
* public interface MainDAO
-------------------------------------------------------------------------------------------------*/
public interface MainDAO {
	
	/*-----------------------------------------------------------------------------------------------------------
	* 상품 분류에 해당하는 화면
	----------------------------------------------------------------------------------------------------------*/
	public List<ManagerDTO> productDetail(String productClass) throws Exception;
	public List<ManagerDTO> productDetailBest(String productClass) throws Exception;
	public List<ManagerDTO> productDetailregdate(String productClass) throws Exception;
	public List<ManagerDTO> productDetaillowprice(String productClass) throws Exception;
	public List<ManagerDTO> productDetailhighprice(String productClass) throws Exception;
	
	//----------------------------------------------------------------------------------------------------------
	//상품 분류에 해당하는 화면에서 상품이름을 클릭하면 상세화면으로 넘어간다.
	//----------------------------------------------------------------------------------------------------------
	public ManagerDTO productInDetail(String productName) throws Exception;
	
	//----------------------------------------------------------------------------------------------------------
	//바로구매하기 
	//로그인한 유저 상품 불러오기
	public List<PreBuyDTO> listPreBuy(String userId) throws Exception;
	//로그인한 유저 정보 불러오기
	public MemberDTO view(String userId) throws Exception;		
	//바로구매하기에서 결제방법 가져오기	
	public List<PaymentMethodDTO> selectPaymentMethod() throws Exception;		
	//무통장 입금 선택란 가져오기	
	public List<BankDTO> selectBank() throws Exception;
	
	//바로구매하기에서 구매확인 클릭 할 때 구매 디비에 정보 넣기
		public int buy(BuyDTO completeBuy) throws Exception;	
		int buyCount(BuyDTO completeBuy); //구매목록 상품 갯수
		int updateBuy(BuyDTO completeBuy); //구매목록 수정 
		int sumBuyMoney(String userId);
		
		// 구매목록 보기
		List<BuyDTO> listBuy(String userId);
		
		public List<BuyDTO> buyList(String userId) throws Exception;
	//----------------------------------------------------------------------------------------------------------
		
	/*-----------------------------------------------------------------------------------------------------------
	* 장바구니 담기
	----------------------------------------------------------------------------------------------------------*/
	public int addCart(CartDTO cart) throws Exception;
	
	/*-----------------------------------------------------------------------------------------------------------
	* 장바구니
	----------------------------------------------------------------------------------------------------------*/
	public List<CartDTO> cartMoney();
		    void insert(CartDTO dto); //장바구니 추가
		    List<CartDTO> listCart(String userId); //장바구니 목록
		    List<CartDTO> listCart2(String productName,String userId);
		    ManagerDTO listCart3(String productName);
		    List<ManagerDTO> listProductCount(String userId);
		    int sumMoney(String userId);
		    void delete(int cartNum); //장바구니 개별 삭제
		    void selectdelete(String cartNum);
		    void deleteAll(String userId); //장바구니 비우기
		    void update(int cartNum); 
		    int countCart(CartDTO dto); //장바구니 상품 갯수
		    int updateCart(CartDTO dto); //장바구니 수정 
		    void modifyCart(CartDTO dto);
		    Integer onePrice(Integer productCode);
	
	//----------------------------------------------------------------------------------------------------------
	//상품 분류에 해당하는 화면에서 상품이름을 클릭하면 상세화면으로 넘어간다.
	//----------------------------------------------------------------------------------------------------------
	public List<FaqTypeDTO> selectFaqType() throws Exception;
		
	//----------------------------------------------------------------------------------------------------------
	//상품 분류에 해당하는 화면에서 상품이름을 클릭하면 상세화면으로 넘어간다.
	//----------------------------------------------------------------------------------------------------------
	public List<FaqDTO> selectFaq() throws Exception;
		
	//-------------------------------------------------------------------------------------------------
	// FAQ 페이징 처리
	//-------------------------------------------------------------------------------------------------
	public int faqListTotalCount(SearchCriteria cri) throws Exception;
		
	/*-------------------------------------------------------------------------------------------------
	* 회원 목록 보기 (Paging 처리)
	-------------------------------------------------------------------------------------------------*/
	public List<FaqDTO> faqListPaging(SearchCriteria cri) throws Exception;

	/*-------------------------------------------------------------------------------------------------
	* 장바구니에서 전체 구매
	-------------------------------------------------------------------------------------------------*/
	public List<CartDTO> showCarts(String userId) throws Exception;
		
	/*-------------------------------------------------------------------------------------------------
	* 장바구니에서 전체 구매
	-------------------------------------------------------------------------------------------------*/
	public CartDTO showSelectCarts(int cartNum) throws Exception;
	
	/*-------------------------------------------------------------------------------------------------
	* 댓글 쓰기 위해 구매자 확인
	-------------------------------------------------------------------------------------------------*/
	public Integer checkBuy(String productName, String userId) throws Exception;
	
	/*-------------------------------------------------------------------------------------------------
	* 댓글 쓰기 위해 댓글 개수 확인
	-------------------------------------------------------------------------------------------------*/
	public int checkComment(String productCode, String userId) throws Exception;
	
   // 서치한 거 뿌려주기
   public List<ManagerDTO> searchproducts(SearchCriteria scri) throws Exception;
	
	
	
}