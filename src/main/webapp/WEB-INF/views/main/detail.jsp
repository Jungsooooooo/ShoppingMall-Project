<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page session="true"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="layoutTag" tagdir="/WEB-INF/tags"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<layoutTag:layout>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>상세 정보</title>
	<style type="text/css">
		#STATICMENU { margin: 0pt; padding: 0pt;  position: absolute; right: 0px; top: 0px; z-index:5;}
		p { text-align: right; }
		.hi { position:relative; }
		.num { border:1px solid red; font-size:20px; position:absolute; left:0px; top:0px; background:red;  }
		p > a { color:#333; text-decoration:none; }
	</style>
</head>
 
<body onload="InitializeStaticMenu();">
    <div id="STATICMENU">
		<div>
			<button type="button" class="btn btn-warning btn-lg" style="cursor:pointer;" onclick="window.scrollTo(0,0);">▲</button>
		</div>
		<div>
			<button type="button" class="btn btn-warning btn-lg" style="cursor:pointer;" onclick="window.scrollTo(0,99999999);">▼</button>
		</div>
	</div>
		
	<c:if test="${map.productClass != null }">
	    <div id="product_order_list" style="margin-right:15%; ">
			<c:forEach var="detail" items="${detail}" begin="0" end="0">
				<p>
					<a href="${path}/main/detail?productClass=${detail.productClass}&listNum=0">구매순</a>&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;
					<a href="${path}/main/detail?productClass=${detail.productClass}&listNum=1">최신순</a>&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;
					<a href="${path}/main/detail?productClass=${detail.productClass}&listNum=2">낮은가격</a>&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;
					<a href="${path}/main/detail?productClass=${detail.productClass}&listNum=3">높은가격</a>
				</p>
			</c:forEach>
		</div>
	</c:if>
<section class="py-5">
        <div class="container px-4 px-lg-5 mt-5">
            <div class="row gx-4 gx-lg-5 row-cols-2 row-cols-md-3 row-cols-xl-4 justify-content-left">
            <c:forEach var="detail" items="${detail}" varStatus="status">
                <div class="col mb-1">
                    <div class="col-h-100 hi">
                        <!-- Product image-->
                        
						<c:if test="${map.productClass == null }">
							<c:if test="${map.listNum == 0 }">
                        		<p class="num">${status.count}</p>
                        	</c:if>
                        </c:if>
                        <a onclick="location.href='/main/productDetail/${detail.productName}'" height="5" width="10" target="_blank">
                        	<img class="card-img-top" src="/images/${detail.productImage}" width=600, height=400 />
                        	<!-- <img class="card-img-top" src="/images/${detail.productImage}"width=400px, height=400px /> -->
                        </a>
                        <!-- Product details-->
                        <div class="card-body p-4">
                            <div class="text">
                                <!-- Product name-->
                                <div>
                                	<span>${detail.productName}</span>
                                </div>
                                <!-- Product price-->
                                <div>
                                	<fmt:formatNumber value="${detail.productPrice}" type="number" pattern="#,###원" />
                                </div>
                                	<span>${detail.productContent}</span>
                            </div>
                        </div>
                        <!-- Product actions-->
                    </div>
                </div>
          </c:forEach>
          </div>
      </div>
</section>
</body>
<script>
//-------------------------------------------------------------------------------------------
//스크롤
//-------------------------------------------------------------------------------------------
var stmnLEFT = 45; // 오른쪽 여백 
var stmnGAP1 = 200; // 위쪽 여백 
var stmnGAP2 = 150; // 스크롤시 브라우저 위쪽과 떨어지는 거리 
var stmnBASE = 500; // 스크롤 시작위치 
var stmnActivateSpeed = 15; //스크롤을 인식하는 딜레이 (숫자가 클수록 느리게 인식)
var stmnScrollSpeed = 5000000; //스크롤 속도 (클수록 느림)
var stmnTimer; 

function RefreshStaticMenu() { 
	var stmnStartPoint, stmnEndPoint; 
	stmnStartPoint = parseInt(document.getElementById('STATICMENU').style.top, 10); 
	stmnEndPoint = Math.max(document.documentElement.scrollTop, document.body.scrollTop) + stmnGAP2; 
	if (stmnEndPoint < stmnGAP1) stmnEndPoint = stmnGAP1; 
	if (stmnStartPoint != stmnEndPoint) { 
		stmnScrollAmount = Math.ceil( Math.abs( stmnEndPoint - stmnStartPoint ) / 13 ); 
	  	document.getElementById('STATICMENU').style.top = parseInt(document.getElementById('STATICMENU').style.top, 10) + ( ( stmnEndPoint<stmnStartPoint ) ? -stmnScrollAmount : stmnScrollAmount ) + 'px'; 
	  	stmnRefreshTimer = stmnScrollSpeed; 
	}
	stmnTimer = setTimeout("RefreshStaticMenu();", stmnActivateSpeed); 
 } 

function InitializeStaticMenu() {
 	document.getElementById('STATICMENU').style.right = stmnLEFT + 'px';  //처음에 오른쪽에 위치. left로 바꿔도.
 	document.getElementById('STATICMENU').style.top = document.body.scrollTop + stmnBASE + 'px'; 
 	RefreshStaticMenu();
}
</script>
</html>
</layoutTag:layout>





































