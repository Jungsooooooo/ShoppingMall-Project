<%@ page session="true"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="layoutTag" tagdir="/WEB-INF/tags"%>
<layoutTag:layout>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>제품 상세 페이지</title>
	<style>
		
	</style>
</head>
<body>

<div class="container">
<form name="Form" id="Form" action="/main/buy/order">
	<table class="table bordered">
              		
		<tr>
			<td rowspan="9" width="150" align="center"><img src="/images/${productInDetail.productImage}" width=300 height=400></td>
			
			<td width="100"><b>상품 이름</b></td>
			<td width="400">${productInDetail.productName}</td>
		</tr>
		
		<tr>				
			<td width="100"><b>상품 설명</b></td>
			<td width="400">${productInDetail.productContent}</td>
		</tr>
		
		<tr>            
			<td width="100"><b>상품 가격</b></td>
            <td width="400"><fmt:formatNumber value="${productInDetail.productPrice}" pattern="###,###,###"/>원</td>
		</tr>
           
        <tr>         
            <td width="100"><b>할인율</b></td>
            <td width="400"><font color="red">${productInDetail.discount_rate}%</font></td>
		</tr>
           
        <tr>         
            <td width="100"><b>판매가</b></td>
            <td width="400"><fmt:formatNumber value=" ${ productInDetail.productPrice * (100 - productInDetail.discount_rate) / 100 }" pattern="###,###,###"/>원</td>
        </tr>
        
        <tr>         
            <td width="100"><b>재고수량</b></td>
            <td width="400">${productInDetail.productCount}개</td>
        </tr>
           
        <tr class="buy_productCount">         
            <td width="100"><b>구매수량</b></td>
            <td width="400">
            	<button type="button" class="btn btn-sm minus">-</button> 
            	<span><input type="text" id="buyCount" class="buyCount" size="4" name="buy_productCount" value="1"></span>
            	<button type="button" class="btn btn-sm plus">+</button>
            	
        	</td>
        </tr>
           
        <tr>         
            <td width="100"><b>총 상품 금액</b></td>
            <td width="400"><label id="totalAmount" ><span><fmt:formatNumber value=" ${ productInDetail.productPrice * (100 - productInDetail.discount_rate) / 100 }" type="number" maxFractionDigits="0"/></span>원</label></td>
        </tr>
     
	</table>
			
	<!-- 카트에 담을 데이터를 숨겨놓는다. --> 
	<input type="hidden" name="productCode" value="${productInDetail.productCode}"/>
	<input type="hidden" name="productName" value="${productInDetail.productName}"/>
	<input type="hidden" name="productPrice" value="${productInDetail.productPrice}"/>
	<input type="hidden" name="discount_rate" value="${productInDetail.discount_rate}"/>
	<input type="hidden" name="productImage" value="${productInDetail.productImage}"/>
	<input type="hidden" name="productCount" value="${productInDetail.productCount }"/>
	<input type="hidden" name="login" value="${login}"/>
	
	<div class="container" align="right" >
		<input type="button" class="btn btn-warning btn-sm goCart" value="장바구니 담기" />
		<input type="button" class="btn btn-success btn-sm goBuy" value="바로 구매하기"/>
	</div>
</form>
</div>
    
<c:forEach var="row" items="${map.list}" >    
   	<tr>
   		<td><input type="hidden" class= "productCount" value="${row.buy_productCount }" readonly/></td>
   	</tr>         
</c:forEach>
   
<!-- 댓글을 입력하는 영역 -->
<div class="container"><!-- 구매자 테이블 생기면 if문으로 input type="hidden" name="writer" value="" value에 구매자 아이디-->
	<label for="comment">상품평</label>
	<form name="commentInsertForm">
		<div class="input-group">
			<input type="hidden" class="productCode" name="productCode" value="${productInDetail.productCode}"/>
			<input type="hidden" name="writer" value="${userId}"/>
			<input type="hidden" name="checkBuy" value="${checkBuy}">
			<input type="hidden" name="checkComment" value="${checkComment}">
			<input type="text" class="form-control" id="content" name="content" placeholder="상품평을 입력해주세요"/>
			<span class="input-group-btn">
				<button class="btn btn-warning" type="button" name="commentInsertBtn">등록</button>
			</span>
		</div>
	</form>
</div>


<!-- 저장된 댓글을 보여주는 영역 -->
<div class="container">
	<div class="commentList"></div>
</div>

<form id="aa" action="/main/buy/order">
	<input name="prebuyNum" type="hidden" value="${list1.prebuyNum}"/>
</form>

</body>
<script>
var i=1;

$('.minus').click(function(){
	i--;
	var productPrice = $("[name=productPrice]").val();
	var discount_rate = $("[name=discount_rate]").val();
	if(i<1) {
		alert("최소 수량은 1개입니다.");
		i++;
	} else {
		$('.buyCount').val(i);
		var price = Math.floor(productPrice * (100 - discount_rate) / 100);
		$('#totalAmount span').text(
			(Number(price) * i).toLocaleString());
	}
});

$('.plus').click(function(){
	i++;
	var j = $('.productCount').val();
	j=parseInt(j);
	var productCount = $("[name=productCount]").val();
	var productPrice = $("[name=productPrice]").val();
	var discount_rate = $("[name=discount_rate]").val();
	var totalAmount = $("[name=totalAmount]").val();
	if(j+i >productCount ){
		alert("장바구니와 희망구매수량의 합이 재고를 초과하였습니다.");
		i--;
	}
	else if(i>productCount ){
		alert("보유수량보다 더 많이 구매하실 수는 없습니다.")
		i--;
	}
	else {
		$('.buyCount').val(i);
		var price = Math.floor(productPrice * (100 - discount_rate) / 100);
		$('#totalAmount span').text(
			(Number(price) * i).toLocaleString());
	}	
});
var $input = $(".buyCount");
$(".buyCount").on('input', function() {
	var productCount = $("[name=productCount]").val();
	if(Number($(".buyCount").val()) >productCount ) {
		alert("보유수량보다 더 많이 구매하실 수는 없습니다.\n\n구매수량을 다시 입력해주십시오.");
		//$(".buyCount").val(1);
		document.getElementById("buyCount").value = "1";

}
	var productPrice = $("[name=productPrice]").val();
	var discount_rate = $("[name=discount_rate]").val();
	var price = Math.floor(productPrice * (100 - discount_rate) / 100);
$('#totalAmount span').text(
		(Number(price* Number($('.buyCount').val())).toLocaleString()));
});

$('.goCart').click(function(){
	var j = $('.productCount').val();
	j=parseInt(j);
	var productCount = $("[name=productCount]").val();
	var login = $("[name=login]").val();
	if (login == "need") {
		var ww=400;    //띄울 창의 넓이
		var wh=250;    //띄울 창의 높이
		
		// 새창의 중앙 좌표
		var top=(screen.availHeight-wh)/2;
		var left=(screen.availWidth-ww)/2;
		
		// 새창 띄움
		window.open("/member/newLogin", "window", "width="+ww+", height="+wh+", top="+top+", left="+left+", toolbar=no, menubar=no, scrollbars=no, resizable=no");
	
	} else {if( j == productCount){
		alert("최대 구매 수량입니다");
	}
	else{
		var productCode = $("[name=productCode]").val();
		var productName = $("[name=productName]").val();
		var productPrice = $("[name=productPrice]").val();
		var discount_rate = $("[name=discount_rate]").val();
		var productImage = $("[name=productImage]").val();
		var buy_productCount = $("[name=buy_productCount]").val();
		
	 	$.ajax({
			url:	'/main/cart/goCart',
			type:	'post',
			data:	{'productCode' : productCode, 'productName' : productName, 'productPrice' : productPrice, 'discount_rate' : discount_rate, 'productImage' : productImage, 'buy_productCount' : buy_productCount},
			success: function(data) {
				var check = confirm("상품이 장바구니에 담겼습니다. 확인하시겠습니까?");
				if(check) {
					location.href='/main/cart/cartList';
				} else {
					location.href='/main/productDetail/' +productName;
				}
			}
		});
	}
	}
});

$('.goBuy').click(function(){
	
	var login = $("[name=login]").val();
	if (login == "need") {
		
		var ww=400;    //띄울 창의 넓이
		var wh=250;    //띄울 창의 높이
		
		// 새창의 중앙 좌표
		var top=(screen.availHeight-wh)/2;
		var left=(screen.availWidth-ww)/2;
		
		// 새창 띄움
		window.open("/member/newLogin", "window", "width="+ww+", height="+wh+", top="+top+", left="+left+", toolbar=no, menubar=no, scrollbars=no, resizable=no");
		
	} else {
		var check = confirm("바로구매하러 가시겠습니까?");
		if(check) {
			$('#Form').submit();
		} 
	}
	
	
});

</script>

<!-- 댓글 목록 -->
<%@ include file="commentAction.jsp" %>
</html>
</layoutTag:layout>