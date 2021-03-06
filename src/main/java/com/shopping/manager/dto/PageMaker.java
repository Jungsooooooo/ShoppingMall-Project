package com.shopping.manager.dto;

import org.springframework.web.util.UriComponents;
import org.springframework.web.util.UriComponentsBuilder;

/*-----------------------------------------------------------------------------------------------------------
* public class PageMaker
-----------------------------------------------------------------------------------------------------------*/
public class PageMaker {

	private Criteria 	cri;
	private int 		totalCount;				// 전체 페이지 갯수
	private int 		startPage;				// 현재 화면에서 보이는 startPage 번호
	private int 		endPage;				// 현재 화면에 보이는 endPage 번호
	private boolean 	prev;					// 페이징 이전 버튼 활성화 여부
	private boolean 	next;					// 페이징 다음 버튼 활서화 여부
	private int 		displayPageNum = 10;	// 화면 하단에 보여줄 페이지의 갯수 (1,2,3,4,5,6,7,9,10)
    
    public String makeSearch(Integer page) {
        
        UriComponents uriComponents = UriComponentsBuilder.newInstance()
            .queryParam("page", page)
            .queryParam("perPageNum", cri.getPerPageNum())
            .queryParam("searchType", ((SearchCriteria)cri).getSearchType())
            .queryParam("keyword", ((SearchCriteria)cri).getKeyword())
            .build();           
        return uriComponents.toUriString();
    }
     
    public String makeQuery(Integer page) {
       
        UriComponents uriComponents = UriComponentsBuilder.newInstance()
            .queryParam("page", page)
            .queryParam("perPageNum", cri.getPerPageNum())
            .build();
             
        return uriComponents.toUriString();
    }
	
	public Criteria getCri() {
		return cri;
	}
	public void setCri(Criteria cri) {
		this.cri = cri;
	}
	public int getTotalCount() {
		return totalCount;
	}
	public void setTotalCount(int totalCount) {
		this.totalCount = totalCount;
		calculatePages();
	}
    
	//-----------------------------------------------------------------------------------------------------------
	// 페이지 계산
	//-----------------------------------------------------------------------------------------------------------
	private void calculatePages() {
		endPage = (int) (Math.ceil(cri.getPage() / (double) displayPageNum) * displayPageNum);
		
		startPage = (endPage - displayPageNum) + 1;
		if(startPage <= 0) startPage = 1;
		
		int tempEndPage = (int) (Math.ceil(totalCount / (double) cri.getPerPageNum()));
		if (endPage > tempEndPage) {
			endPage = tempEndPage;
		}
 
		prev = startPage == 1 ? false : true;
		next = endPage * cri.getPerPageNum() < totalCount ? true : false;
	}
    
	public int getStartPage() {
		return startPage;
	}
	public void setStartPage(int startPage) {
		this.startPage = startPage;
	}
	public int getEndPage() {
		return endPage;
	}
	public void setEndPage(int endPage) {
		this.endPage = endPage;
	}
	public boolean isPrev() {
		return prev;
	}
	public void setPrev(boolean prev) {
		this.prev = prev;
	}
	public boolean isNext() {
		return next;
	}
	public void setNext(boolean next) {
		this.next = next;
	}
	public int getDisplayPageNum() {
		return displayPageNum;
	}
	public void setDisplayPageNum(int displayPageNum) {
		this.displayPageNum = displayPageNum;
	}
	
} // End - public class PageMaker
