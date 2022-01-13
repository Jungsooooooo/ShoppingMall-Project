package com.shopping.main.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.shopping.main.dto.BankDTO;
import com.shopping.main.dto.BuyDTO;
import com.shopping.main.dto.CartDTO;
import com.shopping.main.dto.PaymentMethodDTO;
import com.shopping.main.dto.PreBuyDTO;
import com.shopping.manager.dto.FaqDTO;
import com.shopping.manager.dto.FaqTypeDTO;
import com.shopping.manager.dto.FileDTO;
import com.shopping.manager.dto.ManagerDTO;
import com.shopping.manager.dto.ProductTypeDTO;
import com.shopping.manager.dto.SearchCriteria;
import com.shopping.member.dto.MemberDTO;

import lombok.extern.java.Log;

/*-------------------------------------------------------------------------------------------------
* public class MainDAOImpl
-------------------------------------------------------------------------------------------------*/
@Log
@Repository
public class MainDAOImpl implements MainDAO {

	@Inject
	SqlSession sqlSession;
	
	private static String namespace = "com.shopping.mappers.MainMapper";
	
	/*-----------------------------------------------------------------------------------------------------------
	* 상품 분류에 해당하는 화면
	----------------------------------------------------------------------------------------------------------*/
	@Override
	public List<ManagerDTO> productDetail(String productClass) throws Exception {
		log.info("MainDAOImpl productDetail() => " + productClass);
		return sqlSession.selectList(namespace + ".productDetail", productClass);
	}
	@Override
	public List<ManagerDTO> productDetailBest(String productClass) throws Exception {
		log.info("MainDAOImpl productDetail() => " + productClass);
		return sqlSession.selectList(namespace + ".productDetailBest", productClass);
	}
	@Override
	public List<ManagerDTO> productDetailregdate(String productClass) throws Exception {
		log.info("MainDAOImpl productDetail() => " + productClass);
		return sqlSession.selectList(namespace + ".productDetailregdate", productClass);
	}
	@Override
	public List<ManagerDTO> productDetaillowprice(String productClass) throws Exception {
		log.info("MainDAOImpl productDetail() => " + productClass);
		return sqlSession.selectList(namespace + ".productDetaillowprice", productClass);
	}
	@Override
	public List<ManagerDTO> productDetailhighprice(String productClass) throws Exception {
		log.info("MainDAOImpl productDetail() => " + productClass);
		return sqlSession.selectList(namespace + ".productDetailhighprice", productClass);
	}
	
	//----------------------------------------------------------------------------------------------------------
	//상품 분류에 해당하는 화면에서 상품이름을 클릭하면 상세화면으로 넘어간다.
	//----------------------------------------------------------------------------------------------------------
	public ManagerDTO productInDetail(String productName) throws Exception {
		log.info("MainDAOImpl productInDetail() => " + productName);
		return sqlSession.selectOne(namespace + ".productInDetail", productName);
	}
	
	/*-----------------------------------------------------------------------------------------------------------
	* 장바구니 담기
	----------------------------------------------------------------------------------------------------------*/
	@Override
	public int addCart(CartDTO cart) throws Exception {
		log.info("------------------------------------------MainDAO...");
		return sqlSession.insert(namespace + ".addCart", cart);
	}
	
	//----------------------------------------------------------------------------------------------------------
	//바로구매하기 
	//로그인한 유저 상품 불러오기
	public List<PreBuyDTO> listPreBuy(String userId) throws Exception {
		return sqlSession.selectList(namespace + ".listPreBuy", userId);
	}
	//로그인한 유저 정보 불러오기
	@Override
	public MemberDTO view(String id) throws Exception {
		return sqlSession.selectOne(namespace + ".view", id);
	}
	//바로구매하기에서 결제방법 가져오기
	@Override
	public List<PaymentMethodDTO> selectPaymentMethod() throws Exception {
		log.info("ManagerDAOImpl selectPaymentMethod() Start....");
		return sqlSession.selectList(namespace + ".selectPaymentMethod");
	}
	//무통장 입금 선택란 가져오기	
	@Override
	public List<BankDTO> selectBank() throws Exception {
		log.info("ManagerDAOImpl selectBank() Start....");
		return sqlSession.selectList(namespace + ".selectBank");
	}
	
	//바로구매하기에서 구매확인 클릭 할 때 구매 디비에 정보 넣기
	@Override
	public int buy(BuyDTO completeBuy) throws Exception {
		log.info("------------------------------------------MainDAO");
		return sqlSession.insert(namespace + ".buy", completeBuy);
	}	
	@Override
    public int buyCount(BuyDTO completeBuy) {
    	//Map<String,Object>map=new HashMap<String,Object>();
    	return sqlSession.selectOne(namespace + ".buyCount", completeBuy);
        // TODO Auto-generated method stub
        
    }
 
    @Override
    public int updateBuy(BuyDTO completeBuy) {
        return sqlSession.update(namespace + ".updateBuy", completeBuy);
 
    }
    
    @Override
    public int sumBuyMoney(String userId) {
    	sqlSession.selectOne(namespace + ".sumBuyMoney", userId);
    return sqlSession.selectOne(namespace + ".sumBuyMoney", userId);
    }
	
	//구매목록 보기
    @Override
    public List<BuyDTO> listBuy(String userId) {
	log.info("MainDAOImpl productInDetail() => " + userId);
    return sqlSession.selectList(namespace + ".listBuy", userId);
    }
	
    public List<BuyDTO> buyList(String userId) throws Exception {
		return sqlSession.selectList(namespace + ".buyList", userId);
	}
    
	//----------------------------------------------------------------------------------------------------------
	
	/*-----------------------------------------------------------------------------------------------------------
	* 장바구니
	----------------------------------------------------------------------------------------------------------*/
	@Override
    public List<CartDTO> cartMoney() {
        // TODO Auto-generated method stub
        return null;
    }
    //장바구니에 담기
    @Override
    public void insert(CartDTO dto) {
    //dto에 저장된 값을 받아서 sql세션에 저장하고 cart.insert로 넘어감 mapper로.
        sqlSession.insert("main.insert", dto); 
    }
 
    @Override
    public List<CartDTO> listCart(String userId) {
    	log.info("MainDAOImpl productInDetail() => " + userId);
        return sqlSession.selectList(namespace + ".listCart", userId);
    }
    
    @Override
    public List<CartDTO> listCart2(@Param("productName") String productName,@Param("userId")String userId) {
    	log.info("MainDAOImpl 이거 찾는중" + userId);
    	HashMap<String,String>inputValues = new HashMap<String,String>();
    	inputValues.put("productName", productName);
    	inputValues.put("userId",userId);
        return sqlSession.selectList(namespace + ".listCart2", inputValues);
    }
    
    @Override
    public ManagerDTO listCart3(String productName) {
    	log.info("MainDAOImpl productInDetail() => " + productName);
        return sqlSession.selectOne(namespace + ".listCart3", productName);
    }
    
    @Override
    public List<ManagerDTO> listProductCount(String userId) {
    	log.info("MainDAOImpl productInDetail() => " + userId);
        return sqlSession.selectList(namespace + ".listProductCount", userId);
    }
    // 5. 장바구니 금액 합계
    @Override
    public int sumMoney(String userId) {
    	sqlSession.selectOne(namespace + ".sumMoney", userId);
    return sqlSession.selectOne(namespace + ".sumMoney", userId);
    }
    
    @Override
    public void delete(int cartNum) {
        sqlSession.delete(namespace + ".delete", cartNum);
    }
    @Override
    public void selectdelete(String cartNum) {
        sqlSession.delete(namespace + ".selectdelete", cartNum);
    }
 
    @Override
    public void deleteAll(String userId) {
        sqlSession.delete(namespace + ".deleteAll", userId);
    }
 
    @Override
    public void update(int cartNum) {
        // TODO Auto-generated method stub
    }

    @Override
    public int countCart(CartDTO dto) {
    	//Map<String,Object>map=new HashMap<String,Object>();
    	return sqlSession.selectOne(namespace + ".countCart", dto);
        // TODO Auto-generated method stub
        
    }
 
    @Override
    public int updateCart(CartDTO dto) {
        return sqlSession.update(namespace + ".updateCart", dto);
 
    }
 
    @Override
    public void modifyCart(CartDTO dto) {
    	log.info("DAO 성공 Mapper 전송");
        sqlSession.update(namespace+".modifyCart", dto);
    }
    @Override
    public Integer onePrice(Integer productCode) {
    	return sqlSession.selectOne(namespace+".onePrice", productCode);
    }
	
	/*-----------------------------------------------------------------------------------------------------------
	* faq
	----------------------------------------------------------------------------------------------------------*/
	@Override
	public List<FaqTypeDTO> selectFaqType() throws Exception {

		return sqlSession.selectList(namespace + ".selectFaqType" );
	}
	
	@Override
	public List<FaqDTO> selectFaq() throws Exception {

		return sqlSession.selectList(namespace + ".selectFaq" );
	}
	
	//-------------------------------------------------------------------------------------------------
	// 전체 글 갯수 구하기 (Paging 처리)
	//-------------------------------------------------------------------------------------------------
	@Override
	public int faqListTotalCount(SearchCriteria cri) throws Exception {
		return sqlSession.selectOne(namespace + ".faqListTotalCount", cri);
	}
	
	/*-------------------------------------------------------------------------------------------------
	* faq 목록 보기 (Paging 처리)
	-------------------------------------------------------------------------------------------------*/
	@Override
	@SuppressWarnings("unchecked")
	public List<FaqDTO> faqListPaging(SearchCriteria cri) throws Exception {
		log.info("*** ManagerDAOImpl Criteria ==> " + cri);
		log.info("***** ManagerDAOImpl Criteria cri.getSearchType() ==> " + cri.getSearchType());
		
		return sqlSession.selectList(namespace + ".faqListPaging", cri);
	}
	
	/*-------------------------------------------------------------------------------------------------
	* 장바구니에서 전체 구매
	-------------------------------------------------------------------------------------------------*/
	@Override
	public List<CartDTO> showCarts(String userId) throws Exception {
	    return sqlSession.selectList(namespace + ".showCarts", userId);
	}
	
	/*-------------------------------------------------------------------------------------------------
	* 장바구니에서 선택 구매
	-------------------------------------------------------------------------------------------------*/
	@Override
	public CartDTO showSelectCarts(int cartNum) throws Exception {
	    return sqlSession.selectOne(namespace + ".showSelectCarts", cartNum);
	}
	
	/*-------------------------------------------------------------------------------------------------
	* 댓글 쓰기 위해 구매자 확인
	-------------------------------------------------------------------------------------------------*/
	@Override
	public Integer checkBuy(@Param("productName") String productName, @Param("userId")String userId) throws Exception {
		HashMap<String,String> inputValues = new HashMap<String,String>();
		log.info(userId + "--" + productName);
    	inputValues.put("productName", productName);
    	inputValues.put("userId",userId);
		return sqlSession.selectOne(namespace +".checkBuy", inputValues);
	}
	
	/*-------------------------------------------------------------------------------------------------
	* 댓글 쓰기 위해 댓글 개수 확인
	-------------------------------------------------------------------------------------------------*/
	@Override
	public int checkComment(@Param("productCode") String productCode, @Param("userId")String userId) throws Exception {
		HashMap<String,String> inputValues = new HashMap<String,String>();
    	inputValues.put("productCode", productCode);
    	inputValues.put("userId",userId);
		return sqlSession.selectOne(namespace +".checkComment", inputValues);
	}
	
   //-----------------------------------------------------------------------------------------------------------
   // 서치한 거 뿌려주기
   //-----------------------------------------------------------------------------------------------------------
   @Override
   public List<ManagerDTO> searchproducts(SearchCriteria scri) throws Exception {
      return sqlSession.selectList(namespace + ".searchproducts", scri);
      
   }
	
}/*End - public class BoardDAOImpl*/
