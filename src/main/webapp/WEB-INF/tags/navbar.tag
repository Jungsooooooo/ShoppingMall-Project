<%@ tag language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"	uri="http://java.sun.com/jsp/jstl/core" %>
<style>
.dropdown { height:20px; margin-top:14.5px; }
.dropdown a { color:#333; text-decoration:none; }
</style>
<br><br>
<div class="top_gnb_area" >
    <nav class="navbar fixed top navbar-expand-lg navbar-light " style="background-color: #ffffff; width:100%; float:left">
    <a class="navbar-brand" href="/"><h1>1'st Fit</h1></a>
        <ul class="navbar-nav me-auto">
    	    <c:if test="${member == null }">
               	<li class="nav-item">
               		<a class="nav-link active" aria-current="page" href="/member/login">로그인</a>
               	</li>
               	<li class="nav-item">
               		<a class="nav-link active" aria-current="page" href="/member/memberInsert">회원가입</a>
                </li>
            </c:if>
            <c:if test="${member != null }">
            	<li class="nav-item">
            		<a class="nav-link active" aria-current="page" href="/member/logout">로그아웃</a>
            	</li>
            	<li class="dropdown">
					<a class="dropdown-toggle" data-toggle="dropdown" href="#">마이페이지 </a>
					<ul class="dropdown-menu">
						<li><a href="/member/memberUpdate/${member.userId}">회원정보수정</a></li>
						<li><a href="/main/buy/buyList/${member.userId}">주문조회</a></li>
					</ul>
				</li>
            </c:if>
            <li class="nav-item">
         		<a class="nav-link active" aria-current="page" href="/main/cart/cartList">장바구니</a>
       		</li>
           	<li class="nav-item">
          		<a class="nav-link active" aria-current="page" href="/main/faq">문의사항</a>
        	</li>
        	<c:if test="${member.userId == 'master'}">
				<li>
				<a class="nav-link active" aria-current="page" href="/manager/managerMain">관리자 페이지</a>
				</li>
			</c:if>
		</ul>
		
	<form class="d-flex" style="width:12%;" action="/main/product_list_search" id="searchList">
	  	<input class="form-control me-2" type="text"  name="keyword" id="searchKeyword" placeholder="검색어를 입력하십시오" aria-label="Search">
	  	<button class="btn btn-outline-success" type="submit">Search</button>
	</form>
</nav>
</div>

<div class="top_area">
	<div class="logo_area" style="text-align: center;">
		<a onclick="location.href='/'">
        <img alt="logo pictures" src="/resources/images/MLogo.png">
        </a>
	</div>
</div>

<div class="navi_bar_area">
	<div style="text-align: center;">
       	<nav class="navbar navbar-expand-lg navbar-light "style="width: 600px;background color:#ffffff;margin-left: 30%; margin-right:30%;position: relative;text-align: center;">
           	<ul class="navbar-nav me-auto mb-2 mb-lg-0 ms-lg-4" style="text-align: center;">
                <li class="nav-item" style="margin-left:25px; margin-right:25px;"><a class="nav-link" href="/main/detail?listNum=0">베스트상품</a></li>
                <li class="nav-item" style="margin-left:25px; margin-right:25px;"><a class="nav-link" href="/main/detail?productClass=100&listNum=0">아우터</a></li>
                <li class="nav-item" style="margin-left:25px; margin-right:25px;"><a class="nav-link" href="/main/detail?productClass=200&listNum=0">상의</a></li>
                <li class="nav-item" style="margin-left:25px; margin-right:25px;"><a class="nav-link" href="/main/detail?productClass=300&listNum=0">하의</a></li>
                <li class="nav-item" style="margin-left:25px; margin-right:25px;"><a class="nav-link" href="/main/detail?productClass=400&listNum=0">신발</a></li>
                <li class="nav-item" style="margin-left:25px; margin-right:25px;"><a class="nav-link" href="/main/detail?productClass=500&listNum=0">악세사리</a></li>
            </ul>
       	</nav>
	</div>
</div>











