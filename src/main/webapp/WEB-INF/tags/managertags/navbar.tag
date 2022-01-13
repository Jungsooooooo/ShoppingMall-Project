<%@ tag language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"	uri="http://java.sun.com/jsp/jstl/core" %>

	<!-- 왼쪽 사이드 메뉴 스크립트 -->
<script>
    $(function () {
        
        // 왼쪽메뉴 드롭다운
        $(".sub_menu ul.small_menu").hide();
        $(".sub_menu ul.big_menu").click(function () {
            $("ul", this).slideToggle(300);
        });
        // 외부 클릭 시 좌측 사이드 메뉴 숨기기
        
    });
</script>
	
    <div id="wrapper">
        <div class="topbar" style="position: absolute; top:0;">
            <!-- 왼쪽 메뉴 -->
            <div class="left side-menu">
                <div class="sidebar-inner">
                    <div id="sidebar-menu">
                        <ul>
                          
                        </ul>
                    </div>
                </div>
            </div>
            <!-- 왼쪽 서브 메뉴 -->
            <div class="left_sub_menu">
                <div class="sub_menu">
                    <h2>관리자 페이지</h2>
                    <ul class="big_menu">
                        <li>상품 관리 <i class="arrow fas fa-angle-right"></i></li>
                        <ul class="small_menu">
                            <li><a href="/manager/product/productRegister">상품등록</a></li>
                            <li><a href="/manager/product/list">상품목록(수정/삭제)</a></li>
                        </ul>
                    </ul>
                    <ul class="big_menu">
                        <li>배송관리 <i class="arrow fas fa-angle-right"></i></li>
                        <ul class="small_menu">
                            <li><a href="/manager/buy/buyList">배송 목록</a></li>
                        </ul>
                    </ul>
                    <ul class="big_menu">
                        <li>회원관리 <i class="arrow fas fa-angle-right"></i></li>
                        <ul class="small_menu">
                            <li><a href="/manager/member/memberList">회원 목록</a></li>
                        </ul>
                    </ul>
                    <ul class="big_menu">
                        <li>게시판관리 <i class="arrow fas fa-angle-right"></i></li>
                        <ul class="small_menu">
                            <li><a href="/manager/faq/faqRegister">게시판 등록</a></li>
                            <li><a href="/manager/faq/list">게시판 목록</a></li>
                        </ul>
                    </ul>
                    <ul class="big_menu">
                        <li><a href="/">메인 페이지</a></li>
                    </ul>
                </div>
            </div>
            <div class="overlay"></div>
        </div>
        
</div>
<style>
#a {text-decoration: none;}
.side-menu {
            top: 0px;
            width: 45px;
            z-index: 10;
            background: #000000;
            border-right: 1px solid rgba(0, 0, 0, 0.07);
            bottom: 50px;
            height: 100%;
            margin-bottom: -70px;
            margin-top: 0px;
            padding-bottom: 70px;
            position: fixed;
            box-shadow: 0 0px 24px 0 rgb(0 0 0 / 6%), 0 1px 0px 0 rgb(0 0 0 / 2%);
        }

        .sidebar-inner {
            height: 100%;
            padding-top: 30px;
        }
		
        #sidebar-menu,
        #sidebar-menu ul,
        #sidebar-menu li,
        #sidebar-menu a {
            border: 0;
            font-weight: normal;
            line-height: 1;
            list-style: none;
            margin: 0;
            padding: 0;
            position: relative;
            text-decoration: none;
        }

        #sidebar-menu>ul>li a {
            color: #fff;
            font-size: 20px;
            display: block;
            padding: 14px 0px;
            margin: 0px 0px 0px 8px;
            border-top: 1px solid rgba(0, 0, 0, 0.1);
            border-bottom: 1px solid rgba(255, 255, 255, 0.05);
            width: 28px;
            cursor: pointer;
        }

        #sidebar-menu .fas {
            padding-left: 6px;
        }

        /* 사이드 메뉴 */
        input[type="search"] {
            width: 180px;
            margin: 0 auto;
            margin-left: 9px;
            border: 2px solid #797979;
            font-size: 14px;
            
            padding: 4px 0 4px 14px;
            border-radius: 50px;
        }

        .left_sub_menu {
            position: fixed;
            top: 0px;
            width: 200px;
            z-index: 10;
            left: 45px;
            background: white;
            border-right: 1px solid rgba(0, 0, 0, 0.07);
            bottom: 0px;
            height: 100%;
            margin-bottom: 0px;
            margin-top: 0px;
            padding-bottom: 0px;
            box-shadow: 0 0px 24px 0 rgb(0 0 0 / 6%), 0 1px 0px 0 rgb(0 0 0 / 2%);
            color: black;
        }

        .sub_menu {
            margin-top: 0px;
        }

        .left_sub_menu>.sub_menu li:hover {
            color: ff5858;
            background-color: #e1e1e1;
        }

        .left_sub_menu>.sub_menu li {
            color: #333;
            font-size: 17px;
            font-weight: 600;
            padding: 20px 0px 8px 14px;
            border-bottom: 1px solid #e1e1e1;
        }

        .sub_menu>h2 {
            padding-bottom: 4px;
            border-bottom: 3px solid #797979;
            margin-top: 30px;
            font-size: 21px;
            font-weight: 600;
            color: #333;
            margin-left: 10px;
            margin-right: 10px;
            font-family: 'NotoKrB';
            line-height: 35px;
        }

        .sub_menu .fas {
            color: #ff5858;
            font-size: 20px;
            line-height: 20px;
            float: right;
            margin-right: 20px;
        }

        .sub_menu>.big_menu>.small_menu li {
            color: #333;
            font-size: 14px;
            font-weight: 600;
            border-bottom: 0px solid #e1e1e1;
            margin-left: 14px;
            padding-top: 8px;
        }

        .big_menu {
            cursor: pointer;
        }

        ul {
            padding-inline-start: 0px;
        }

        a {
            color: #333333;
            text-decoration: none;
            background-color: transparent;
        }
        a2 {
            color: #333333;
            text-decoration: none;
            background-color: transparent;
        }

        ul {
            list-style: none;
        }

        ol,
        ul {
            margin-top: 0;
            margin-bottom: 10px;
        }

        .has_sub {
            width: 100%;
        }

        .overlay {
            position: fixed;
            width: 100%;
            height: 100%;
            background: rgba(0, 0, 0, 0);
        }

        .hide_sidemenu {
            display: none;
        }
</style>