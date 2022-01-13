package com.shopping.main.service;

import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.shopping.main.dao.MainDAO;
import com.shopping.main.dto.BankDTO;
import com.shopping.main.dto.BuyDTO;
import com.shopping.main.dto.CartDTO;
import com.shopping.main.dto.PaymentMethodDTO;
import com.shopping.main.dto.PreBuyDTO;
import com.shopping.manager.dto.FaqDTO;
import com.shopping.manager.dto.FaqTypeDTO;
import com.shopping.manager.dto.ManagerDTO;
import com.shopping.manager.dto.SearchCriteria;
import com.shopping.member.dao.MemberDAO;
import com.shopping.member.dto.MemberDTO;

import lombok.extern.java.Log;

/*-------------------------------------------------------------------------------------------------
* public class MainServiceImpl
-------------------------------------------------------------------------------------------------*/
@Log
@Service
public class MainServiceImpl implements MainService {

	@Inject
	MainDAO mainDAO;
	@Inject
	private MemberDAO memberDAO;
	
	
	/*-----------------------------------------------------------------------------------------------------------
	* 상품 분류에 해당하는 화면
	----------------------------------------------------------------------------------------------------------*/
	@Override
	public List<ManagerDTO> productDetail(String productClass) throws Exception {
		
		log.info("MainController..." + productClass);
		return mainDAO.productDetail(productClass);
	}
	@Override
	public List<ManagerDTO> productDetailBest(String productClass) throws Exception {
		
		log.info("MainController..." + productClass);
		return mainDAO.productDetailBest(productClass);
	}
	@Override
	public List<ManagerDTO> productDetailregdate(String productClass) throws Exception {
		
		log.info("MainController..." + productClass);
		return mainDAO.productDetailregdate(productClass);
	}
	@Override
	public List<ManagerDTO> productDetaillowprice(String productClass) throws Exception {
		
		log.info("MainController..." + productClass);
		return mainDAO.productDetaillowprice(productClass);
	}
	@Override
	public List<ManagerDTO> productDetailhighprice(String productClass) throws Exception {
		
		log.info("MainController..." + productClass);
		return mainDAO.productDetailhighprice(productClass);
	}

	//----------------------------------------------------------------------------------------------------------
	//상품 분류에 해당하는 화면에서 상품이름을 클릭하면 상세화면으로 넘어간다.
	//----------------------------------------------------------------------------------------------------------
	public ManagerDTO productInDetail(String productName) throws Exception {
		log.info("MainController..." + productName);
		return mainDAO.productInDetail(productName);
	}
	
	//----------------------------------------------------------------------------------------------------------
	//바로구매하기 
	//로그인한 유저 상품 불러오기
	public List<PreBuyDTO> listPreBuy(String userId) throws Exception {
		return mainDAO.listPreBuy(userId);
	}
	//로그인한 유저 정보 불러오기
	@Override
	public MemberDTO view(String userId) throws Exception {
		log.info("MainServiceImpl view(String id).....");
		return mainDAO.view(userId);
	}
	//바로구매하기에서 결제방법 가져오기
	@Override
	public List<PaymentMethodDTO> selectPaymentMethod() throws Exception {
		log.info("ManagerDAOImpl selectProductType() Start....");
		return mainDAO.selectPaymentMethod();
	} 
	//무통장 입금 선택란 가져오기	
	@Override
	public List<BankDTO> selectBank() throws Exception {
		log.info("ManagerDAOImpl selectBank() Start....");
		return mainDAO.selectBank();
	} 
	
	//바로구매하기에서 구매확인 클릭 할 때 구매 디비에 정보 넣기
	@Override
	public int buy(BuyDTO completeBuy) throws Exception {
		log.info("------------------------------------------MainService...");
		return mainDAO.buy(completeBuy);
	}
	
	@Override
    public int buyCount(BuyDTO  completeBuy) {
        // TODO Auto-generated method stub
        return mainDAO.buyCount(completeBuy);
    }
 
    @Override
    public int updateBuy(BuyDTO completeBuy) {
    	return mainDAO.updateBuy(completeBuy);
        // TODO Auto-generated method stub
    }
    
    @Override
    public int sumBuyMoney(String userId) {
    return mainDAO.sumBuyMoney(userId);
    }
	
	//구매목록 보기
	@Override
    public List<BuyDTO> listBuy(String userId) {
        return mainDAO.listBuy(userId);
    }
	
	public List<BuyDTO> buyList(String userId) throws Exception {
		return mainDAO.buyList(userId);
	}
	
	//----------------------------------------------------------------------------------------------------------
	
	/*-----------------------------------------------------------------------------------------------------------
	 * 장바구니 담기
	----------------------------------------------------------------------------------------------------------*/	
	@Override
	public int addCart(CartDTO cart) throws Exception {
		log.info("------------------------------------------MainService...");
		return mainDAO.addCart(cart);
	}
	
	/*-----------------------------------------------------------------------------------------------------------
	* 장바구니
	----------------------------------------------------------------------------------------------------------*/
    @Override
    public List<CartDTO> cartMoney() {
        return null;
    }
    
    @Override
    public void insert(CartDTO dto) {
    	mainDAO.insert(dto);
    }
 
    @Override
    public List<CartDTO> listCart(String userId) {
        return mainDAO.listCart(userId);
    }
    
    @Override
    public List<CartDTO> listCart2(String productName,String userId) {
        return mainDAO.listCart2(productName,userId);
    }
    
    
    @Override
    public ManagerDTO listCart3(String productName) {
        return mainDAO.listCart3(productName);
    }
    
    @Override
    public List<ManagerDTO> listProductCount(String userId) {
        return mainDAO.listProductCount(userId);
    }
    
    // 장바구니 금액 합계
    @Override
    public int sumMoney(String userId) {
    return mainDAO.sumMoney(userId);
    }

    @Override
    public void delete(int cartNum) {
    	mainDAO.delete(cartNum);
    }
    @Override
    public void selectdelete(String cartNum) {
    	mainDAO.selectdelete(cartNum);
    }
 
    @Override
    public void deleteAll(String userId) {
    	mainDAO.deleteAll(userId);
    }
 
    @Override
    public void update(int cartNum) {
        // TODO Auto-generated method stub
    }
 
    @Override
    public int countCart(CartDTO dto) {
        // TODO Auto-generated method stub
        return mainDAO.countCart(dto);
    }
 
    @Override
    public int updateCart(CartDTO dto) {
    	return mainDAO.updateCart(dto);
        // TODO Auto-generated method stub
    }
 
    @Override
    public void modifyCart(CartDTO dto) {
    	log.info("서비스 성공 DAO 전송");
    	mainDAO.modifyCart(dto);
    }
    @Override
    public Integer onePrice(Integer productCode) {
		log.info("MainController..." + productCode);
    	return mainDAO.onePrice(productCode);
    }

	//------------------------------------------------------------------------------------------------------------
	// 타입 불러오기
	//-------------------------------------------------------------------------------------------------------
	@Override
	public List<FaqTypeDTO> selectFaqType() throws Exception {
		log.info("ManagerDAOImpl selectProductType() Start....");
		return mainDAO.selectFaqType();
	}
	
	//------------------------------------------------------------------------------------------------------------
	// 문의사항 띄우기
	//-------------------------------------------------------------------------------------------------------
	@Override
	public List<FaqDTO> selectFaq() throws Exception {
		log.info("ManagerDAOImpl selectProductType() Start....");
		return mainDAO.selectFaq();
	}
	
	//-------------------------------------------------------------------------------------------------
	// 전체 상품 수 구하기 (Paging 처리)
	//-------------------------------------------------------------------------------------------------
	@Override
	public int faqListTotalCount(SearchCriteria cri) throws Exception {
		return mainDAO.faqListTotalCount(cri);
	}
	
	/*-------------------------------------------------------------------------------------------------
	* 회원 목록 보기 (Paging 처리)
	-------------------------------------------------------------------------------------------------*/
	@Override
	public List<FaqDTO> faqListPaging(SearchCriteria cri) throws Exception {
		log.info("*** Board2ServiceImpl Criteria ==> " + cri);
		return mainDAO.faqListPaging(cri);
	}
	
	/*-------------------------------------------------------------------------------------------------
	* 장바구니에서 전체 구매
	-------------------------------------------------------------------------------------------------*/
	@Override
	public List<CartDTO> showCarts(String userId) throws Exception {
		return mainDAO.showCarts(userId);
	}
	
	/*-------------------------------------------------------------------------------------------------
	* 장바구니에서 선택 구매
	-------------------------------------------------------------------------------------------------*/
	@Override
	public CartDTO showSelectCarts(int cartNum) throws Exception {
		return mainDAO.showSelectCarts(cartNum);
	}		
	
	/*-------------------------------------------------------------------------------------------------
	* 댓글 쓰기 위해 구매자 확인
	-------------------------------------------------------------------------------------------------*/
	@Override
	public Integer checkBuy(String productName, String userId) throws Exception {
		return mainDAO.checkBuy(productName, userId);
	}
	
	/*-------------------------------------------------------------------------------------------------
	* 댓글 쓰기 위해 댓글 개수 확인
	-------------------------------------------------------------------------------------------------*/
	@Override
	public int checkComment(String productCode, String userId) throws Exception {
		return mainDAO.checkComment(productCode, userId);
	}
	
	//써치
	@Override
   public List<ManagerDTO> searchproducts(SearchCriteria scri) throws Exception {
      return mainDAO.searchproducts(scri);
      
    } 

}
