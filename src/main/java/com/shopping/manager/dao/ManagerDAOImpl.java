package com.shopping.manager.dao;

import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.shopping.main.dto.BuyDTO;
import com.shopping.manager.dto.FaqDTO;
import com.shopping.manager.dto.FaqTypeDTO;
import com.shopping.manager.dto.FileDTO;
import com.shopping.manager.dto.ManagerDTO;
import com.shopping.manager.dto.ProductTypeDTO;
import com.shopping.manager.dto.SearchCriteria;
import com.shopping.member.dto.MemberDTO;

import lombok.extern.java.Log;

/*-------------------------------------------------------------------------------------------------
* public class ManagerDAOImpl
-------------------------------------------------------------------------------------------------*/
@Log
@Repository
public class ManagerDAOImpl implements ManagerDAO {

	@Inject
	SqlSession sqlSession;

	private static String namespace = "com.shopping.mappers.ManagerMapper";

	/*-------------------------------------------------------------------------------------------------
	* 상품 등록
	-------------------------------------------------------------------------------------------------*/
	@Override
	public int productRegister(ManagerDTO managerDTO) throws Exception {
		return sqlSession.insert(namespace + ".insert", managerDTO);
	}

	// -------------------------------------------------------------------------------------------------
	// 상품 유형 목록 보기
	// -------------------------------------------------------------------------------------------------
	@Override
	public List<ProductTypeDTO> selectProductType() throws Exception {
		log.info("ManagerDAOImpl selectProductType() Start....");
		return sqlSession.selectList(namespace + ".selectProductType");
	}
	
	// -------------------------------------------------------------------------------------------------
	// 상품 유형 목록 보기
	// -------------------------------------------------------------------------------------------------
	@Override
	public List<ManagerDTO> selectProduct() throws Exception {
		log.info("ManagerDAOImpl selectProduct() Start....");
		return sqlSession.selectList(namespace + ".selectProductnew");
	}
	
	// -------------------------------------------------------------------------------------------------
	// 상품 유형 목록 보기
	// -------------------------------------------------------------------------------------------------
	@Override
	public List<ManagerDTO> selectProductnew() throws Exception {
		log.info("ManagerDAOImpl selectProductnew() Start....");
		return sqlSession.selectList(namespace + ".selectProductnew");
	}

	/*-------------------------------------------------------------------------------------------------
	* 파일 등록
	-------------------------------------------------------------------------------------------------*/
	@Override
	public int fileInsert(FileDTO file) throws Exception {
		log.info("ManagerDAOImpl fileInsert => " + file);
		return sqlSession.insert(namespace + ".fileInsert", file);
	}

	/*-------------------------------------------------------------------------------------------------
	* 회원 목록 보기 (Paging 처리)
	-------------------------------------------------------------------------------------------------*/
	@Override
	@SuppressWarnings("unchecked")
	public List<MemberDTO> memberListPaging(SearchCriteria cri) throws Exception {
		log.info("*** ManagerDAOImpl Criteria ==> " + cri);
		log.info("***** ManagerDAOImpl Criteria cri.getSearchType() ==> " + cri.getSearchType());

		return sqlSession.selectList(namespace + ".memberListPaging", cri);
	}

	/*-------------------------------------------------------------------------------------------------
	* 회원 목록 수 구하기 (Paging 처리)
	-------------------------------------------------------------------------------------------------*/
	@Override
	public int memberListTotalCount(SearchCriteria cri) throws Exception {
		return sqlSession.selectOne(namespace + ".memberListTotalCount", cri);
	}
	
	/*-----------------------------------------------------------------------------------------------------------
	* 회원 번호에 해당하는 상세정보화면
	----------------------------------------------------------------------------------------------------------*/
	@Override
	public MemberDTO memberDetail(int userNum) throws Exception {
		return sqlSession.selectOne(namespace + ".memberDetail", userNum);
	}
	
	/*-----------------------------------------------------------------------------------------------------------
	* 회원 수정
	----------------------------------------------------------------------------------------------------------*/
	public void memberUpdate(MemberDTO memberDTO) throws Exception {
		sqlSession.update(namespace + ".memberUpdate", memberDTO);
	}
	
	/*-----------------------------------------------------------------------------------------------------------
	* 회원 삭제
	----------------------------------------------------------------------------------------------------------*/
	public void memberDelete(int userNum) throws Exception {
		sqlSession.delete(namespace + ".memberDelete", userNum);
	}
	
	// -------------------------------------------------------------------------------------------------
	// 상품 목록 보기 (Paging 처리) + 검색 추가(Criteria를 SearchCriteria로 변경)
	// -------------------------------------------------------------------------------------------------
	@Override
	@SuppressWarnings("unchecked")
	// public List<BoardDTO> boardListPaging(Criteria cri) throws Exception {
	public List<ManagerDTO> productListPaging(SearchCriteria cri) throws Exception {
		log.info("*** Board2DAOImpl Criteria ==> " + cri);
		// log.info("*** boardDAOImpl Criteria ==> " + cri.getPageStart());
		// log.info("*** boardDAOImpl Criteria ==> " + cri.getPerPageNum());
		log.info("***** boardDAOImpl Criteria cri.getSearchType() ==> " + cri.getSearchType());

		return sqlSession.selectList(namespace + ".productListPaging", cri);
	}

	// -------------------------------------------------------------------------------------------------
	// 전체 상품 수 구하기 (Paging 처리)
	// -------------------------------------------------------------------------------------------------
	@Override
	public int productListTotalCount(SearchCriteria cri) throws Exception {
		return sqlSession.selectOne(namespace + ".productListTotalCount", cri);
	}

	// -------------------------------------------------------------------------------------------------
	// 상품 번호에 해당하는 상세정보화면
	// -------------------------------------------------------------------------------------------------
	@Override
	public ManagerDTO productDetail(int productCode) throws Exception {
		log.info("Board2DAOImpl boardDetail() => ");
		return sqlSession.selectOne(namespace + ".productDetail", productCode);
	}

	// -------------------------------------------------------------------------------------------------
	// 상품 수정
	// -------------------------------------------------------------------------------------------------
	@Override
	public int productUpdate(ManagerDTO managerDTO) throws Exception {
		log.info("Board2DAOImpl boardUpdate() => " + managerDTO);
		return sqlSession.update(namespace + ".productUpdate", managerDTO);
	}

	// -------------------------------------------------------------------------------------------------
	// 상품 삭제
	// -------------------------------------------------------------------------------------------------
	@Override
	public int productDelete(int productCode) throws Exception {
		log.info("Board2DAOImpl boardDelete() => " + productCode);
		return sqlSession.delete(namespace + ".productDelete", productCode);
	}
	// 배송 상태
	@Override
	@SuppressWarnings("unchecked")
	public List<BuyDTO> orderListPaging(SearchCriteria cri) throws Exception {
		log.info("*** ManagerDAOImpl Criteria ==> " + cri);
		log.info("***** ManagerDAOImpl Criteria cri.getSearchType() ==> " + cri.getSearchType());

		return sqlSession.selectList(namespace + ".orderListPaging", cri);
	}
	
	// 배송 상태
	@Override
	public int orderListTotalCount(SearchCriteria cri) throws Exception {
		return sqlSession.selectOne(namespace + ".orderListTotalCount", cri);
	}
	
	// 배송 상태
	@Override
	public void delivery(BuyDTO buyDTO) throws Exception {
		sqlSession.update(namespace + ".delivery", buyDTO);
	}
		
	/*-----------------------------------------------------------------------------------------------------------
	* 배송 완료 후 상품 수량 삭제
	----------------------------------------------------------------------------------------------------------*/
	public void changeCount(BuyDTO buyDTO) throws Exception{
		sqlSession.update(namespace + ".changeCount", buyDTO);
	}

	// -------------------------------------------------------------------------------------------------
	// Faq 유형 목록 보기
	// -------------------------------------------------------------------------------------------------
	@Override
	public List<FaqTypeDTO> selectFaqType() throws Exception {
		log.info("ManagerDAOImpl selectFaqType() Start....");
		return sqlSession.selectList(namespace + ".selectFaqType");
	}

	/*-------------------------------------------------------------------------------------------------
	* Faq 등록
	-------------------------------------------------------------------------------------------------*/
	@Override
	public int faqRegister(FaqDTO faqDTO) throws Exception {
		return sqlSession.insert(namespace + ".faqinsert", faqDTO);
	}

	// -------------------------------------------------------------------------------------------------
	// Faq 수 구하기 (Paging 처리)
	// -------------------------------------------------------------------------------------------------
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

	// -------------------------------------------------------------------------------------------------
	// Faq 상세 조회
	// -------------------------------------------------------------------------------------------------
	@Override
	public FaqDTO faqDetail(int bno) throws Exception {
		log.info("Board2DAOImpl FaqDetail() => ");
		return sqlSession.selectOne(namespace + ".faqDetail", bno);
	}

	// -------------------------------------------------------------------------------------------------
	// 게시글 삭제
	// -------------------------------------------------------------------------------------------------
	@Override
	public int faqDelete(int bno) throws Exception {
		log.info("Board2DAOImpl faqDelete() => " + bno);
		return sqlSession.delete(namespace + ".faqDelete", bno);
	}

}/* End - public class BoardDAOImpl */
