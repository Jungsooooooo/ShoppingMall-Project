package com.shopping.manager.dto;

/*-----------------------------------------------------------------------------------------------------------
* public class Criteria
-----------------------------------------------------------------------------------------------------------*/
public class Criteria {

    private int page;		// 현재 페이지 번호
    private int perPageNum;	// 한 페이지당 보여줄 글의 갯수
    
    // 특정 페이지의 게시글 시작 번호, 게시글 시작 행 번호
    //현재 페이지의 게시글 시작 번호 = (현재 페이지 번호 - 1) * 페이지당 보여줄 게시글 갯수
    /*
	현재 페이지 번호	페이지당 보여줄 게시글 수	계산식		게시글 시작 행 번호
	3					5							(3-1)*5		10
	8					10							(8-1)*10	70
	14					10							(14-1)*10	130
	*/
    
	/* limit 구문에서 시작 위치를 지정할 때 사용된다. 예를 들어 10개씩 출력하는 경우 3페이지의 데이터는 limit 20, 10 과 같은 형태가 되어야 한다. */
	/* this.page 가 1이면 0이 되어야 한다 mysql limit 0, 10 해야 처음부터 10개씩 나온다. */
	/* 마이바티스 조회쿼리의 #{pageStart}에 전달된다. */
	public int getPageStart() {	
		return (this.page-1)*perPageNum;
	}
	
	// 최초로 게시판 목록에 들어 왔을 때를 위해서 기본 셋팅을 해야 한다. 
	// 왜냐하면 페이징을 처리하기 위해선 현재 페이지 번호와 페이지당 게시글 수가 필요한데 
	// 처음 게시판에 들어오게 되면 두 개의 정보를 가져올 방법이 없기 때문에 
	// 기본 생성자를 통해 기본 값을 셋팅한다. 
	// 현재 페이지를 1페이지로, 페이지당 보여줄 게시글의 수를 10개로 기본 셋팅한다.
	
	// 기본 생성자
	public Criteria() {
		// 최초 게시판에 진입할 때를 위해서 기본 값을 설정 해야 한다.
		this.page = 1;
		this.perPageNum = 10;
	}
	
	public int getPage() {
		return page;
	}
	
	// 페이지가 음수값이 되지 않게 설정. 음수가 되면 1페이지를 나타낸다.
	public void setPage(int page) {
		if(page <= 0) {
			this.page = 1;
		} else {
			this.page = page;
		}
	}
	
	public int getPerPageNum() {
		return perPageNum;
	}

	// 페이지당 보여줄 게시글 수가 변하지 않게 설정한다.
	public void setPerPageNum(int pageCount) {
		int cnt = this.perPageNum;
		if(pageCount != cnt) {
			this.perPageNum = cnt;
		} else {
			this.perPageNum = pageCount;
		}
	}

	@Override
	public String toString() {
		return "Criteria [page=" + page + ", perPageNum=" + perPageNum + "]";
	}
    
}/*End - public class Criteria*/
