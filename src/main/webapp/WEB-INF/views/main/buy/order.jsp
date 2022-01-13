<%@ page session="true"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="layoutTag" tagdir="/WEB-INF/tags"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%!SimpleDateFormat sdf = new SimpleDateFormat("yyyy년 MM월 dd일 HH시 mm분");%>

<layoutTag:layout>
<!DOCTYPE html>
<html>
	<head>
	<meta charset="UTF-8">
	<title>주문</title>

<style>
.table tr .bb { padding-top:70px; }
</style>
	
</head>
<body>
	<div class="container">
		<h3 align="left"><b>주문 상품</b></h3>
		<form method="post" name="orderlist">
			<table class="table table-bordered table-striped table-hover">
				<tr class="info" height="30">
					<td align="center">상품 이미지</td>
					<td align="center">상품이름</td>
					<td align="center">판매가격</td>
					<td align="center">구매수량</td>
				</tr>
				
				<c:set var="sum" value="0" />
				<c:forEach items="${listBuy}" var="listBuy">
				<tr align="center">
					<td><img src="/images/${listBuy.productImage}" width=100 height=150></td>
					<td class="bb">${listBuy.productName}</td>
					<td class="bb">
						<c:if test="${listBuy.discount_rate == 0}">
							<font color="red"><fmt:formatNumber	value=" ${ listBuy.productPrice * (100 - listBuy.discount_rate) / 100 }" pattern="###,###,###" /></font>원
						</c:if>
						
						<c:if test="${listBuy.discount_rate != 0}">
							<strike><fmt:formatNumber value="${listBuy.productPrice}" pattern="###,###,###" /></strike> <br>
							<font color="red"><fmt:formatNumber	value=" ${ listBuy.productPrice * (100 - listBuy.discount_rate) / 100 }" pattern="###,###,###" /></font>원
						</c:if>
					</td>
					<td class="bb">${listBuy.buy_productCount}개</td>
				</tr>
				
				<tr>
					<td colspan="5" align="right">
						<b><font size="+1">합계 
							<fmt:formatNumber value=" ${ (listBuy.productPrice * (100 - listBuy.discount_rate) / 100) * listBuy.buy_productCount }" pattern="###,###,###" />원
						</font></b>
					</td>
				</tr>
				
				<!-- 구매하기 디비에 넣을 정보 -->
				<input type="hidden" name="productCode" value="${listBuy.productCode }" />
				<input type="hidden" name="productName" value="${listBuy.productName }" />
				<input type="hidden" name="productPrice" value="${ listBuy.productPrice}" />
				<input type="hidden" name="discount_rate" value="${ listBuy.discount_rate}" />
				<input type="hidden" name="buy_productCount" value="${listBuy.buy_productCount}" />
				<input type="hidden" name="productImage" value="${listBuy.productImage }" />
				<input type="hidden" name="buyNum" value="${buyNum }"/>
				
				<c:set var="sum" value="${sum + ((listBuy.productPrice * (100 - listBuy.discount_rate) / 100) * listBuy.buy_productCount)}" />
				</c:forEach>
				
				<tr class="danger">
					<td colspan="5" align="right">
						<b><font size="+1">상품 구매 금액 
							+<span class="sum"><fmt:formatNumber value="${sum}" type="number"/></span> 원
							<input type="hidden" name="sum" value=""/>
						</font></b> <br>
						<b><font size="+1">배송비
							+<span class="shippingFee"><fmt:formatNumber value="" type="number"/></span> 원
							<input type="hidden" name="shippingFee" value=""/>
						</font></b> <br>
						<b><font size="+2">최종 상품 구매 금액
							<span class="finalSum"><fmt:formatNumber value="" type="number"/></span> 원
							<input type="hidden" name="finalSum" value=""/>
						</font></b>
					</td>
				</tr>
			</table>
		</form>
		
		<form class="form-horizontal" method="post" name="buyInput" action="/main/buyPro">
			<!-- 주문자 정보 -->
			<div class="form-group">
				<h3 align="center"><b>주문자 정보</b></h3>
			</div>

			<div class="form-group">
				<label class="control-label col-sm-offset-2 col-sm-2" for="userName">이름</label>
				<div class="col-sm-3">
					<input type="text" class="form-control" id="userName" name="userName" value="${view.userName}" readonly="readonly" required />
				</div>
			</div>

			<div class="form-group">
				<label class="control-label col-sm-offset-2 col-sm-2">전화번호</label>
				<div class="col-sm-3">
					<input type="text" class="form-control" id="userPhone" name="userPhone" value="${view.userPhone}" readonly="readonly" required />
				</div>
			</div>

			<div class="form-group">
				<label class="control-label col-sm-offset-2 col-sm-2">주 소</label>
				<div class="col-sm-5">
					<input type="text" class="form-control" id="userAddr1" name="userAddr1" placeholder="Enter Address" value="${view.userAddr1}" readonly="readonly" required />
					<input type="text" class="form-control" id="userAddr2" name="userAddr1" placeholder="Enter Address" value="${view.userAddr2}" readonly="readonly" required />
				</div>
			</div>

			<!-- 배송지 정보 -->
			<div class="form-group">
				<h3 align="center"><b>배송 정보</b></h3>
			</div>

			<div class="form-group">
				<label class="control-label col-sm-offset-2 col-sm-2">이 름</label>
				<div class="col-sm-3">
					<input type="text" class="form-control" id="deliveryName" name="deliveryName" value="${view.userName}" />
				</div>
			</div>

			<div class="form-group">
				<label class="control-label col-sm-offset-2 col-sm-2">전화번호</label>
				<div class="col-sm-3">
					<input type="text" class="form-control" id="deliveryTel" name="deliveryTel" value="${view.userPhone}" />
				</div>
			</div>

			<div class="form-group">
				<label class="control-label col-sm-offset-2 col-sm-2">우편번호</label>
				<div class="col-sm-5">
					<input type="text" class="form-control" id="zipcode" name="zipcode" placeholder="${view.zipcode}" />
					<input type="button" class="form-control" onclick="daumZipCode()" value="우편번호검색" />
				</div>
			</div>

			<div class="form-group">
				<label class="control-label col-sm-offset-2 col-sm-2">주 소</label>
				<div class="col-sm-5">
					<input type="text" class="form-control" id="deliveryAddress1" name="deliveryAddress1" value="${view.userAddr1}" />
					<input type="text" class="form-control" id="deliveryAddress2" name="deliveryAddress2" value="${view.userAddr2}" />
				</div>
			</div>

			<!-- 계좌 선택 -->
			<div class="form-group">
				<h3 align="center"><b>무통장 입금 계좌 선택</b></h3>
			</div>

			<div class="form-group">
				<label class="control-label col-sm-offset-2 col-sm-2"></label>
				<div class="col-sm-5">
					<select class="form-control" id="account" name="account">
						<c:forEach items="${selectBank}" var="account">
							<option type="hidden" name="payment_method" value="${account.bank} ${account.account} ${account.name}">
									${account.bank}&nbsp;&nbsp;${account.account}&nbsp;&nbsp;${account.name}
							</option>	
						</c:forEach>
					</select>
				</div>
			</div>

			<!-- 구매 확정 / 취소 -->
			<div class="form-group">
				<div class="col-sm-offset-4 col-sm-3" align="center">
					<button id="prebuyBtn" type="button" class="btn btn-success goCompleteBuy">결제하기</button>
				</div>
			</div>
		</form>
	</div>
	
<form id="aa" action="/main/buy/deleteCart">
	<c:forEach items="${hidecheck}" var="hidecheck">
		<input name="hidecheck" type="hidden" value="${hidecheck }">
	</c:forEach>
</form>
</body>

<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>

$(document).ready(function() {
	
	var sum = ${sum};
	$(".sum").next().val(sum);
	
	var shippingFee = ${sum} >= 100000 ? 0 : 2500;
	var shippingFeeString = (shippingFee).toLocaleString();
	//alert(shippingFee);
	$(".shippingFee").text(shippingFeeString);
	$(".shippingFee").next().val(shippingFee);
	//alert($(".shippingFee").text());
	
	var finalSum = shippingFee +${sum};
	var finalSumString = (finalSum).toLocaleString();
	//alert(finalSum);
	$(".finalSum").text(finalSumString);
	$(".finalSum").next().val(finalSum);
});


$('.goCompleteBuy').click(function(){
	var buyNum	= $("[name=buyNum]").val();
	var userName = $("[name=userName]").val();
	var productCodel = $("input[name=productCode]").length;
	var selectOption= document.getElementById("account");
	selectOption=selectOption.options[selectOption.selectedIndex].value;
	
	//배열 생성
	var productCode = new Array(productCodel);
	var productName = new Array(productCodel);
	var productPrice =new Array(productCodel);
	var discount_rate=new Array(productCodel);
	var buy_productCount =new Array(productCodel);
	var productImage =new Array(productCodel);
	var check = confirm("구매 하시겠습니까?");
	
	if(check) {
	   
	    var hidecheck = $("input[name='hidecheck']");
	    if(hidecheck != "no") {
		  	$('#aa').submit();
		     
		  	//배열에 값 주입
		 	for(var i=0; i<productCodel; i++) {                          
			    productCode[i] = $("input[name=productCode]").eq(i).val()       
			    productName[i] = $("input[name=productName]").eq(i).val()
			    productPrice[i] = $("input[name=productPrice]").eq(i).val()
			    discount_rate[i] = $("input[name=discount_rate]").eq(i).val()
			    buy_productCount[i] = $("input[name=buy_productCount]").eq(i).val()
			    productImage[i] = $("input[name=productImage]").eq(i).val();
			       
			    var reg_date = $("[name=reg_date]").val();
			    var deliveryName = $("[name=deliveryName]").val();
			    var deliveryTel = $("[name=deliveryTel]").val();
			    var deliveryAddress1 = $("[name=deliveryAddress1]").val();
			    var deliveryAddress2 = $("[name=deliveryAddress2]").val();   
			    var sum = $("[name=sum]").val();
			    var shippingFee = $("[name=shippingFee]").val();
			    var finalSum = $("[name=finalSum]").val();
			      
			    $.ajax({
			        url:   '/main/buy/goCompleteBuy',
			        type:   'post',
			        data:   { 'buyNum':buyNum,'userName' : userName, 'productCode' : productCode[i], 'productName' : productName[i], 'productPrice' :productPrice[i], 'discount_rate' : discount_rate[i], 
			                'buy_productCount' :buy_productCount[i], 'productImage' : productImage[i], 'reg_date' : reg_date, 'payment_method' : selectOption, 'deliveryName' : deliveryName, 
			                'deliveryTel' : deliveryTel, 'deliveryAddress1' : deliveryAddress1, 'deliveryAddress2' : deliveryAddress2,
			                'sum' : sum, 'shippingFee' : shippingFee, 'finalSum' : finalSum},
			        success: function(data) {
			            location.href='/main/buy/buyList/${member.userId}';
			        }
		        });            
		    } 
		}
	}
});    

function daumZipCode() {
	new daum.Postcode({
		oncomplete: function(data) {
			// 팝업창에서 검색한 결과 중 항목을 클릭하였을 경우에 실행할 코드를 이곳에 작성한다.
			
			// 각 주소의 노출규칙에 따라서 주소를 조합한다.
			// 내려오는 변수의 값이 업을 경우에는 공백('')값을 가지므로, 이름 참조하여 분기한다.
			var	fullAddress	= '';	// 최종   주소 변수
			var	subAddress  = '';	// 조합형 주소 변수
			
			// 사용자가 선택한 주소의 타입에 따라서 해당 주소값을 가져온다.
			if(data.userSelectedType == 'R') {	// 도로명 주소를 선택한 경우
				fullAddress = data.roadAddress;
			} else {	// 지번 주소를 선택한 경우
				fullAddress = data.jibunAddress;
			}
			
			// 사용자가 선택한 주소가 도로명 타입일 때 주소를 조합한다.
			if(data.userSelectedType == 'R') {
				// 법정동명이 있을 경우 추가한다.
				if(data.bname != '') {
					subAddress += data.bname;
				}
				// 건물명이 있을 경우 추가한다.
				if(data.buildingName != '') {
					subAddress += (subAddress != '' ? ', ' + data.buildingName : data.buildingName);
				}
				
				// 조합형 주소의 유무에 따라 양쪽에 괄호를 추가하여 최종 주소를 만든다.
				fullAddress += (subAddress != '' ? '(' + subAddress + ')' : '');
			}

			// 우편번호와 주소 정보를 해당 필드에 나타낸다.
			document.getElementById('zipcode').value	= data.zonecode; // 우편번호
			document.getElementById('deliveryAddress1').value	= fullAddress;	 // 주소내용
			
			// 커서를 상세주소 입력 필드로 이동시킨다.
			document.getElementById('deliveryAddress2').focus();
		}
	// }).open(); // open()만 기술하면 팝업 창이 여러개 띄울 수 있다.
	}).open({
			// 우편번호 파업 창이 여러개 뜨는 것을 방지하기 위해서 popupName을 사용한다.
			popupName:	'postcodePopup'
	});
}
</script>
</html>
</layoutTag:layout>