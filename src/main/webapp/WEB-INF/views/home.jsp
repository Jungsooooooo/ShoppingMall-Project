<%@ page session="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="layoutTag" tagdir="/WEB-INF/tags" %>
<layoutTag:layout>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/Swiper/4.5.1/css/swiper.min.css">
<script src="https://cdnjs.cloudflare.com/ajax/libs/Swiper/4.5.1/js/swiper.min.js"></script>
<html>
<head>
    <meta charset="utf-8" />
    <meta name="description" content="" />
    <meta name="author" content="" />
    <title>Shop Homepage - 쇼핑몰</title>
    
            <script type="text/javascript">
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

<style type="text/css">
#STATICMENU { margin: 0pt; padding: 0pt;  position: absolute; right: 0px; top: 0px; z-index:5;}

.swiper-container {
   width:100%;
   height:400px;
   padding:30px 0;
   /*border:5px solid silver;*/
   border-radius:7px;
   /*box-shadow:0 0 20px #ccc inset;*/
}
.swiper-slide {
   text-align:center;
   display:flex; /* 내용을 중앙정렬 하기위해 flex 사용 */
   align-items:center; /* 위아래 기준 중앙정렬 */
   justify-content:center; /* 좌우 기준 중앙정렬 */
}

figure.snip0015 * {
  -webkit-box-sizing: border-box;
  box-sizing: border-box;
}

figure.snip0015 h2,
figure.snip0015 p {
  margin: 0 0 5px;
  opacity: 0.2;
  -webkit-transition: opacity 0.35s, -webkit-transform 0.35s;
  transition: opacity 0.35s,-webkit-transform 0.35s,-moz-transform 0.35s,-o-transform 0.35s,transform 0.35s;
}

figure.snip0015 a {
  left: 0;
  right: 0;
  top: 0;
  bottom: 0;
  position: absolute;
  color: #800080;
}
figure.snip0015:hover img {
  opacity: 0.2;
}
figure.snip0015:hover figcaption span  {
  opacity: 0.2;
  -webkit-transform: translate3d(100%, 100%, 100);
  transform: translate3d(100%, 100%, 100);
  -webkit-transition-delay: 0.1s;
  transition-delay: 0.1s;
}
figure.snip0015:hover figcaption::before {
  background: rgba(255, 255, 255, 0);
  top: 300px;
  bottom: 300px;
  opacity: 1;
  -webkit-transition-delay: 0s;
  transition-delay: 0s;
}
.jb-x-large { font-size: x-large; }
</style>
 
    </head>

    <body id="본래 설정" onload="InitializeStaticMenu();">
        <div id="STATICMENU">
		<div>
		<button type="button" class="btn btn-warning btn-lg" style="cursor:pointer;" onclick="window.scrollTo(0,0);">▲</button>
		</div>
		<div>
		<button type="button" class="btn btn-warning btn-lg" style="cursor:pointer;" onclick="window.scrollTo(0,99999999);">▼</button>
		</div>
	</div>
    
</head>
<body>
    <!-- 화면 중앙에 움직이는 이미지를 보여준다. -->
	<div class="container"style="left: 100%; margin: auto;">
	<div id="myCarousel" class="carousel slide" data-ride="carousel">
	<!-- Indicators -->
	<ol class="carousel-indicators">
		<li data-target="#myCarousel" data-slide-to="0" class="active"></li>
		<li data-target="#myCarousel" data-slide-to="1"></li>
		<li data-target="#myCarousel" data-slide-to="2"></li>
	</ol>
	<!-- Wrapper for slides : 실제로 화면에 보여줄 사진에 대한 설정 -->
	<div class="carousel-inner">
		<div class="item active">
			<!-- class="img-responsive center-block" 반응형 이미지를 가운데 정렬한다. -->
	<img class="img-responsive center-block" src="/resources/images/fashion01.jpg"/>
	<!-- 그림에 대한 설명을 달아준다. -->
			<div class="carousel-caption">
			</div>
		</div>
		<div class="item">
			<img class="img-responsive center-block" src="/resources/images/fashion02.jpg"/>
			<div class="carousel-caption">
			</div>
		</div>
		<div class="item">
			<img class="img-responsive center-block" src="/resources/images/fashion03.jpg"/>
			<div class="carousel-caption">
			</div>
		</div>
	</div>

	<!-- 좌측, 우측으로 그림을 움직일 수 있게 좌, 우버튼을 설정한다. -->
	<a class="left carousel-control" href="#myCarousel" data-slide="prev">
		<span class="glyphicon glyphicon-chevron-left"></span>
	</a>
	<a class="right carousel-control" href="#myCarousel" data-slide="next">
		<span class="glyphicon glyphicon-chevron-right"></span>
	</a>
		
	</div>
</div>


		<style>
		    p{
		        text-align: right;
		    }
		</style>	
	<!-- 클래스명은 변경하면 안 됨 -->
<div class="container px-4 px-lg-5 mt-5">
<span><h2>신 상 품</h2></span><br>
<div class="swiper-container" >
	<div class="swiper-wrapper">
			<c:forEach var="detail" items="${detail}" >
			
                <div class="swiper-slide">
		<figure class="snip0015">
                    <div class="col-h-100">
                        <!-- Product image-->
                        <a onclick="location.href='/main/productDetail/${detail.productName}'" height="5" width="10" target="_blank">
                        	<img class="card-img-top" src="/images/${detail.productImage}" width=600, height=300 />
                        	<!-- <img class="card-img-top" src="/images/${detail.productImage}"width=400px, height=400px /> -->
                        </a>
                        <!-- Product details-->
                        <div class="card-body p-6">
                            <div class="text" s>
                                <!-- Product name-->
                                <div>
                                	<span class="jb-x-large">${detail.productName}</span>
                                </div>
                                <!-- Product price-->
                                <div>
                                	<span class="jb-x-large"><fmt:formatNumber value="${detail.productPrice}" type="number" pattern="#,###원" /></span>
                                </div>
                            </div>
                        </div>
                    </div>
				 </figure>
                </div>
            </c:forEach>
	</div>
			<!-- 네비게이션 -->
		<div class="swiper-button-next"></div><!-- 다음 버튼 (오른쪽에 있는 버튼) -->
		<div class="swiper-button-prev"></div><!-- 이전 버튼 -->
	
		<!-- 페이징 -->
		<div class="swiper-pagination"></div>
	</div>
</div>	
    
    
</body>
</html>
<script>

new Swiper('.swiper-container', {

	slidesPerView : 4, // 동시에 보여줄 슬라이드 갯수
	spaceBetween : 5, // 슬라이드간 간격
	slidesPerGroup : 4, // 그룹으로 묶을 수, slidesPerView 와 같은 값을 지정하는게 좋음

	// 그룹수가 맞지 않을 경우 빈칸으로 메우기
	// 3개가 나와야 되는데 1개만 있다면 2개는 빈칸으로 채워서 3개를 만듬
	loopFillGroupWithBlank : true,

	loop : true, // 무한 반복

	pagination : { // 페이징
		el : '.swiper-pagination',
		clickable : true, // 페이징을 클릭하면 해당 영역으로 이동, 필요시 지정해 줘야 기능 작동
	},
	navigation : { // 네비게이션
		nextEl : '.swiper-button-next', // 다음 버튼 클래스명
		prevEl : '.swiper-button-prev', // 이번 버튼 클래스명
	},
});

</script>
</layoutTag:layout>