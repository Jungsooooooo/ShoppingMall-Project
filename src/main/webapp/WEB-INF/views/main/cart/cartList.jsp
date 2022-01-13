<%@ page session="true"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="layoutTag" tagdir="/WEB-INF/tags"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<layoutTag:layout>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>장바구니</title>
	<style>
		#aa { display:none; }
	</style>
</head>
<body>

<c:choose>
    <c:when test="${map.count == 0 }">
    	<!-- when은 ~~일때 라는 뜻 그러니까 map의 count가 0일때... -->
    	<!-- xml파일에서 hashmap에 list를 넣어놓았기 때문에 현재 map에 자료가 들어있다.  -->
    	<!-- map에 자료가 아무것도 없다면 -->
       	<p  style= "text-align:center; font-size:20px;" > 장바구니가 비었습니다.</p>

    </c:when>
    
    <c:otherwise>
    	<!-- map.count가 0이 아닐때, 즉 자료가 있을때 -->
    	<!-- form을 실행한다.  -->
    	<!-- form의 id를 form1로 하고, method 방식을 post로 한다. 그리고 update.do페이지로 이동시킨다. -->
        <form id="form1" name="form1" method="post" action="${path}/main/update.do">
            <table border="1" width="1200px" align="center">
                <tr align="center">
                	<th scope="col"><input id="allCheck" type="checkbox" name="allCheck"/></th>
                	<th width="100px">상품</br>이미지</th>
                    <th>상품명</th>
                    <th>판매가</th>
                    <th>할인율</th>
                    <th>재고수량</th>
                    <th>구매수량</th>
                    <th>금액</th>
                    <th>&nbsp;</th>
                </tr>
                <!-- map에 있는 list출력하기 위해 forEach문을 사용해 row라는 변수에 넣는다. -->
                
            <c:forEach var="row" items="${map.list}" varStatus="statusNum">
                <tr align="center">
                	<td class="text_ct"><input name="RowCheck" type="checkbox" value="${row.cartNum}"/></td>
                	<td ><img src="/images/${row.productImage}"width=100px, height=100px></td>
                    <td>${row.productName}</td>
                    <td width="center">
                    	<input type="hidden" class="productPrice" value="${row.productPrice}">
						<strike><fmt:formatNumber value="${row.productPrice}" pattern="###,###,###"/>원</strike>
						<br>			
						<font color="red"><fmt:formatNumber value=" ${ row.productPrice * (100 - row.discount_rate) / 100 }" pattern="###,###,###" /></font>원
					</td>
				        <!-- fmt:formatNumber 태그는 숫자를 양식에 맞춰서 문자열로 변환해주는 태그이다 -->
                        <!-- 여기서는 금액을 표현할 때 사용 -->
                        <!-- ex) 5,000 / 10,000 등등등-->   
                    <td><input type="hidden" class="discount_rate" value="${row.discount_rate}"> ${row.discount_rate}%</td>
                    <td><input type="hidden" name="productCount" value="${map.list2[statusNum.index].productCount }">${map.list2[statusNum.index].productCount }</td>     
                    <td>
                    	<button type="submit" id="btnUpdate"class="btn btn-sm minus">-</button>
	                    <span><input type="text" class="buyCount" id="buyCount" size="4" name="buy_productCount" value="${row.buy_productCount}"></span> 
	                    <button type="submit" id="btnUpdate" class="btn btn-sm plus">+</button>
	                    <br>
	                    <button type="submit" id="btnUpdate">수정</button>
						<input type="hidden" name="cartNum" value="${row.cartNum}">       
                    </td>
                    <td>
                    	<label class="totalAmount" name="totalAmount"><span><fmt:formatNumber value=" ${  row.productPrice * (100 - row.discount_rate) / 100 *row.buy_productCount }" type="number" maxFractionDigits="0"/></span>원</label>
                    </td>
                    <td>
                    	<a href="${path}/main/delete.do?cartNum=${row.cartNum}">[삭제]</a>
                    	<input type="hidden" name="productCode" value="${row.productCode }">
						<!-- 삭제 버튼을 누르면 delete.do로 장바구니 개별 id (삭제하길원하는 장바구니 id)를 보내서 삭제한다. -->
                    </td>
                </tr>
            </c:forEach>
                <tr align=right width="1200px">
                    <td colspan="10"align=right >
                        장바구니 금액 합계 : <fmt:formatNumber pattern="###,###,###" value="${map.sumMoney}"/><br>
                        배송료 :  ${map.fee}<br>
                        총합계 :<fmt:formatNumber pattern="###,###,###" value="${map.allSum}"/>
                    </td>
                </tr>
            </table>
            
            <input type="hidden" name="count" value="${map.count }">
            <div style="padding-left:12%; margin-top:10px;">
            <button type="submit" id="btnUpdate" class="btn btn-outline-info">수정</button>
            <button type="button" id="btnDelete" class="btn btn-outline-info">장바구니 비우기</button>
            <input type="button" value="선택삭제" class="btn btn-outline-info" onclick="deleteValue();">
            <a href="../buy/order"  class="btn btn-outline-info">전체 주문하기</a>
            <input type="button" value="선택주문"  class="btn btn-outline-info goSelectBuy">
            </div>
        </form>
    </c:otherwise>
</c:choose>

<form id="aa" action="/main/buy/order">
	<c:forEach items="${map.list}" var="row">
		<input name="hidecheck" type="checkbox" value="${row.cartNum}"/>
	</c:forEach>
</form>

</body>

<script>
/*-----------------------------------------------------------------------------------------------------------
* 구매 수량
----------------------------------------------------------------------------------------------------------*/
$('.minus').click(function(){
	var i = $(this).next().find('.buyCount').val();
	i--;
	
	var productPrice = $(this).parent().prev().prev().prev().find('.productPrice').val();
	var discount_rate = $(this).parent().prev().prev().find('.discount_rate').val();
	var totalAmount = $(this).parent().parent().next().find('.totalAmount').text();
	
	if(i<1) {
		alert("최소 수량은 1개입니다.");
		// i++;
	} else {
		$(this).next().find('.buyCount').val(i);
		var price = Math.floor(productPrice * (100 - discount_rate) / 100 );
		$(this).parent().parent().find('.totalAmount').text(
			(Number(price) * i).toLocaleString()+"원");
	}
});

$('.plus').click(function(){
	var i = $(this).prev().find('.buyCount').val();
	i++;
	var productPrice = $(this).parent().prev().prev().prev().find('.productPrice').val();
	var j = $(this).parent().parent().children().eq(5).text();
	var discount_rate = $(this).parent().prev().prev().find('.discount_rate').val();
	var totalAmount = $(this).parent().parent().next().find('.totalAmount').text();

	if(i >j ) {
		alert("보유수량보다 더 많이 구매하실 수는 없습니다.");
	} else {
		$(this).prev().find('.buyCount').val(i);
		var price = Math.floor(productPrice * (100 - discount_rate) / 100 );
		$(this).parent().parent().find('.totalAmount').text(
			(Number(price) * i).toLocaleString()+"원");
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

$('#totalAmount span').text(
    (Number(productPrice * (100 - discount_rate) / 100) * Number($('.buyCount').val())).toLocaleString());
});

/*-----------------------------------------------------------------------------------------------------------
* 선택 체크
----------------------------------------------------------------------------------------------------------*/
var chkObj = document.getElementsByName("RowCheck");
var rowCnt = chkObj.length;

$("input[name='allCheck']").click(function(){
	
	var chk_listArr = $("input[name='RowCheck']");
	var hidecheck = $("input[name='hidecheck']");
	
	for (var i=0; i < chk_listArr.length; i++){
		chk_listArr[i].checked = this.checked;
		hidecheck[i].checked = this.checked;
	}
});

$("input[name='RowCheck']").click(function(){
	if($("input[name='RowCheck']:checked").length == rowCnt){
		$("input[name='allCheck']")[0].checked = true;
	}
	else{
		$("input[name='allCheck']")[0].checked = false;
	}
	
	var chk_listArr = $("input[name='RowCheck']");
	var hidecheck = $("input[name='hidecheck']");
	
	for (var i=0; i < chk_listArr.length; i++){
		hidecheck[i].checked = chk_listArr[i].checked;
	}
});

/*-----------------------------------------------------------------------------------------------------------
* 선택 구매
----------------------------------------------------------------------------------------------------------*/
$('.goSelectBuy').click(function(){
//function goSelectBuy(){
	var valueArr = new Array();
	var list = $("input[name='RowCheck']");
	 
	for(var i = 0; i < list.length; i++){
		if(list[i].checked){ //선택되어 있으면 배열에 값을 저장함
		 	valueArr.push(list[i].value);
		}
	}
	
	if (valueArr.length == 0){
	 	alert("선택된 상품이 없습니다.");
	} else{
		var chk = confirm("정말 주문하시겠습니까?");
		
		if(chk){
			//$('#form').action='/main/buy/goSelectBuy';
			//$('#form').submit();
			$('#aa').submit();
		}
	}
});

/*-----------------------------------------------------------------------------------------------------------
* 선택 삭제
----------------------------------------------------------------------------------------------------------*/
function deleteValue(){
	var url = "/main/selectdelete"; // Controller로 보내고자 하는 URL
	var valueArr = new Array();
	var list = $("input[name='RowCheck']");
	 
	for(var i = 0; i < list.length; i++){
		if(list[i].checked){ //선택되어 있으면 배열에 값을 저장함
		 	valueArr.push(list[i].value);
		}
	}
	
	if (valueArr.length == 0){
	 	alert("선택된 글이 없습니다.");
	}
	 
	else{
		var chk = confirm("정말 삭제하시겠습니까?");
		
		$.ajax({
			url : url, // 전송 URL
			type : 'POST', // POST 방식
			traditional : true,
			data : {
			valueArr : valueArr // 보내고자 하는 data 변수 설정
			},
			success: function(jdata){
				if(jdata = 1) {
					alert("삭제 성공");
					location.replace("cartList") //list 로 페이지 새로고침
				}
				else{
					alert("삭제 실패");
				}
			}
		});
	}
}

/*-----------------------------------------------------------------------------------------------------------
* 전체 삭제
----------------------------------------------------------------------------------------------------------*/
$("#btnDelete").click(function(){
    if(confirm("장바구니를 비우시겠습니까?")){
        location.href="${path}/main/deleteAll.do";
    }
});

</script>
</html>
</layoutTag:layout>