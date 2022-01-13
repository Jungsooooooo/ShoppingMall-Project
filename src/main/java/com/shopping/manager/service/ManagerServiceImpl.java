package com.shopping.manager.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.shopping.main.dto.BuyDTO;
import com.shopping.manager.dao.ManagerDAO;
import com.shopping.manager.dto.FaqDTO;
import com.shopping.manager.dto.FaqTypeDTO;
import com.shopping.manager.dto.FileDTO;
import com.shopping.manager.dto.ManagerDTO;
import com.shopping.manager.dto.ProductTypeDTO;
import com.shopping.manager.dto.SearchCriteria;
import com.shopping.member.dto.MemberDTO;

import lombok.extern.java.Log;

/*-------------------------------------------------------------------------------------------------
* public class ManagerServiceImpl
-------------------------------------------------------------------------------------------------*/
@Log
@Service
public class ManagerServiceImpl implements ManagerService {

	@Inject
	ManagerDAO managerDAO;

	/*-------------------------------------------------------------------------------------------------
	* 상품 등록
	-------------------------------------------------------------------------------------------------*/
	@Override
	public int productRegister(ManagerDTO managerDTO) throws Exception {
		return managerDAO.productRegister(managerDTO);
	}

	// -------------------------------------------------------------------------------------------------
	// 상품 목록 가져오기
	// -------------------------------------------------------------------------------------------------
	@Override
	public List<ProductTypeDTO> selectProductType() throws Exception {
		log.info("ManagerDAOImpl selectProductType() Start....");
		return managerDAO.selectProductType();
	}
	
	// -------------------------------------------------------------------------------------------------
	// 상품 목록 가져오기
	// -------------------------------------------------------------------------------------------------
	@Override
	public List<ManagerDTO> selectProduct() throws Exception {
		log.info("ManagerDAOImpl selectProduct() Start....");
		return managerDAO.selectProduct();
	}
	
	// -------------------------------------------------------------------------------------------------
	// 상품 목록 가져오기
	// -------------------------------------------------------------------------------------------------
	@Override
	public List<ManagerDTO> selectProductnew() throws Exception {
		log.info("ManagerDAOImpl selectProductnew() Start....");
		return managerDAO.selectProductnew();
	}


	/*-------------------------------------------------------------------------------------------------
	* 파일 등록
	-------------------------------------------------------------------------------------------------*/
	@Override
	public int fileInsert(FileDTO file) throws Exception {
		log.info("ManagerServiceImpl fileInsert => " + file);
		return managerDAO.fileInsert(file);
	}

	/*-------------------------------------------------------------------------------------------------
	* 회원 목록 보기 (Paging 처리)
	-------------------------------------------------------------------------------------------------*/
	@Override
	public List<MemberDTO> memberListPaging(SearchCriteria cri) throws Exception {
		log.info("*** Board2ServiceImpl Criteria ==> " + cri);
		return managerDAO.memberListPaging(cri);
	}

	/*-------------------------------------------------------------------------------------------------
	* 회원 목록 수 구하기 (Paging 처리)
	-------------------------------------------------------------------------------------------------*/
	@Override
	public int memberListTotalCount(SearchCriteria cri) throws Exception {
		return managerDAO.memberListTotalCount(cri);
	}
	
	/*-----------------------------------------------------------------------------------------------------------
	* 회원 번호에 해당하는 상세정보화면
	----------------------------------------------------------------------------------------------------------*/
	@Override
	public MemberDTO memberDetail(int userNum) throws Exception {
		return managerDAO.memberDetail(userNum);
	}
	
	/*-----------------------------------------------------------------------------------------------------------
	* 회원 수정
	----------------------------------------------------------------------------------------------------------*/
	public void memberUpdate(MemberDTO memberDTO) throws Exception {
		managerDAO.memberUpdate(memberDTO);
	}
	
	/*-----------------------------------------------------------------------------------------------------------
	* 회원 삭제
	----------------------------------------------------------------------------------------------------------*/
	public void memberDelete(int userNum) throws Exception {
		managerDAO.memberDelete(userNum);
	}

	// -------------------------------------------------------------------------------------------------
	// 상품 목록 보기 (Paging 처리)
	// -------------------------------------------------------------------------------------------------
	@Override
	public List<ManagerDTO> productListPaging(SearchCriteria cri) throws Exception {
		log.info("*** Board2ServiceImpl Criteria ==> " + cri);
		return managerDAO.productListPaging(cri);
	}

	// -------------------------------------------------------------------------------------------------
	// 전체 상품 수 구하기 (Paging 처리)
	// -------------------------------------------------------------------------------------------------
	@Override
	public int productListTotalCount(SearchCriteria cri) throws Exception {
		return managerDAO.productListTotalCount(cri);
	}

	// -------------------------------------------------------------------------------------------------
	// 상품 번호에 해당하는 상세정보화면
	// -------------------------------------------------------------------------------------------------
	@Override
	public ManagerDTO productDetail(int productCode) throws Exception {
		return managerDAO.productDetail(productCode);
	}

	// -------------------------------------------------------------------------------------------------
	// 상품 수정
	// -------------------------------------------------------------------------------------------------
	@Override
	public int productUpdate(ManagerDTO managerDTO) throws Exception {
		return managerDAO.productUpdate(managerDTO);
	}

	// -------------------------------------------------------------------------------------------------
	// 상품삭제
	// -------------------------------------------------------------------------------------------------
	@Override
	public int productDelete(int productCode) throws Exception {
		return managerDAO.productDelete(productCode);
	}
	
	//배송관련
	@Override
	public List<BuyDTO> orderListPaging(SearchCriteria cri) throws Exception {
		log.info("*** Board2ServiceImpl Criteria ==> " + cri);
		return managerDAO.orderListPaging(cri);
	}
	
	//배송관련
	@Override
	public int orderListTotalCount(SearchCriteria cri) throws Exception {
		return managerDAO.orderListTotalCount(cri);
	}
	
	// 배송 상태
	@Override
	public void delivery(BuyDTO buyDTO) throws Exception {
		managerDAO.delivery(buyDTO);
	}
	
	/*-----------------------------------------------------------------------------------------------------------
	* 배송 완료 후 상품 수량 삭제
	----------------------------------------------------------------------------------------------------------*/
	public void changeCount(BuyDTO buyDTO) throws Exception{
		managerDAO.changeCount(buyDTO);
	}
	
	// -------------------------------------------------------------------------------------------------
	// Faq 목록 가져오기
	// -------------------------------------------------------------------------------------------------
	@Override
	public List<FaqTypeDTO> selectFaqType() throws Exception {
		log.info("ManagerDAOImpl selectFaqType() Start....");
		return managerDAO.selectFaqType();
	}

	/*-------------------------------------------------------------------------------------------------
	* Faq 등록
	-------------------------------------------------------------------------------------------------*/
	@Override
	public int faqRegister(FaqDTO faqDTO) throws Exception {
		return managerDAO.faqRegister(faqDTO);
	}

	// -------------------------------------------------------------------------------------------------
	// 전체 Faq 수 구하기 (Paging 처리)
	// -------------------------------------------------------------------------------------------------
	@Override
	public int faqListTotalCount(SearchCriteria cri) throws Exception {
		return managerDAO.faqListTotalCount(cri);
	}

	/*-------------------------------------------------------------------------------------------------
	* Faq 목록 보기 (Paging 처리)
	-------------------------------------------------------------------------------------------------*/
	@Override
	public List<FaqDTO> faqListPaging(SearchCriteria cri) throws Exception {
		log.info("*** Board2ServiceImpl Criteria ==> " + cri);
		return managerDAO.faqListPaging(cri);
	}

	// -------------------------------------------------------------------------------------------------
	// Faq 상세 정보
	// -------------------------------------------------------------------------------------------------
	@Override
	public FaqDTO faqDetail(int bno) throws Exception {
		return managerDAO.faqDetail(bno);
	}

	// -------------------------------------------------------------------------------------------------
	// Faq 삭제
	// -------------------------------------------------------------------------------------------------
	@Override
	public int faqDelete(int bno) throws Exception {
		return managerDAO.faqDelete(bno);
	}
}
