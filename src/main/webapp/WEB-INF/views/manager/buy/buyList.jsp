<%@ page session="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"   		uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" 		uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib  prefix="spring" 	uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="layoutTag" 	tagdir="/WEB-INF/tags/managertags" %>
<style>
.deliveryChange { text-align:right; }
.delivery1_btn,
.delivery2_btn { font-size:16px; background:#fff; border:1px solid #999; margin-left:10px; }
</style>
<layoutTag:layout>

	<!DOCTYPE html>
	<html>
<head>
<meta charset="UTF-8">
<title>배송목록</title>
</head>
<body>

<div class="container">

	<div align="center">
		<h2>배송목록</h2>
	</div>
	<div class="col-sm-offset col-sm-12">
	<table class="table table-striped table-bordered table-hover">
		<thead>
			<tr align="center">
				<th>순차</th>
				<th>고객아이디</th>
				<th>고객이름</th>
				<th>상품</th>
				<th>상품이름</th>
				<th>판매가격</th>
				<th>구매수량</th>
				<th>합계</th>
				<th>구매일자</th>
				<th>배송현황</th>
				<th>주문처리</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach items="${list}" var="buyList" varStatus="status">
				<tr align="center">
					<td>${buyList.buyNum}</td>
					<td>${buyList.userId}</td>
					<td>${buyList.userName}</td>
					<td><img src="/images/${buyList.productImage }" width=100 height=150></td>
					<td>${buyList.productName}</td>
					<td><strike><fmt:formatNumber value="${buyList.productPrice}" pattern="###,###,###" />원</strike> <br>
						<font color="red"><fmt:formatNumber value=" ${ buyList.productPrice * (100 - buyList.discount_rate) / 100 }" pattern="###,###,###" /></font>원</td>
					<td>${buyList.buy_productCount}</td>
					<td>
						<b>						 
							<fmt:formatNumber value=" ${ (buyList.productPrice * (100 - buyList.discount_rate) / 100) * buyList.buy_productCount }" pattern="###,###,###" />원
						</b>
					</td>
					<td>${buyList.reg_date}</td>
					<td>${buyList.shipping}</td>
					<td>
						<div class="deliveryChange">
						<form role="form" method="post" class="deliveryForm">
						 
						  <input type="hidden" name="buyNum" class="buyNum" value="${buyList.buyNum}" />
						  <input type="hidden" name="shipping" class="shipping" value="" />
						  <input type="hidden" name="productName" class="productName" value="${buyList.productName}" />
						  <input type="hidden" name="buy_productCount" class="buy_productCount" value="${buyList.buy_productCount}" />
						  <button type="button" class="delivery0_btn">상품준비중</button><br>
						  <button type="button" class="delivery1_btn">배송중</button>
						  <button type="button" class="delivery2_btn">배송완료</button>
						  
						  <script>
						  $(".delivery0_btn").click(function(){
							  var buyNum=$(this).parent().parent().parent().parent().children().eq(0).text();
							    $(".buyNum").val(buyNum);
							    $(".shipping").val("상품준비중");
							    run();
							   });
							   
						   $(".delivery1_btn").click(function(){
							   var buyNum=$(this).parent().parent().parent().parent().children().eq(0).text();
							    $(".buyNum").val(buyNum);
						    $(".shipping").val("배송중");
						    run();
						   });
						   
						   $(".delivery2_btn").click(function(){
							  var buyNum=$(this).parent().parent().parent().parent().children().eq(0).text();
							  var productName=$(this).parent().parent().parent().parent().children().eq(4).text();
							  var buy_productCount=$(this).parent().parent().parent().parent().children().eq(6).text();
						    $(".buyNum").val(buyNum);
						   	$(".productName").val(productName);
						    $(".buy_productCount").val(buy_productCount);
						    $(".shipping").val("배송완료");
						    run();
						    
						   });
						   
						   function run(){
						    $(".deliveryForm").submit();
						   }
						  
						  </script>
						 </form>
						</div>
					</td>
				</tr>
			</c:forEach>
		</tbody>
	</table>
	</div>

<div class="col-sm-offset col-sm-4">
		<h3><a class="label label-info">검색조건</a></h3>
		
		<select id='searchType'>
			<option>검색종류</option>
				<option value="id" <c:if test="${pageVO.type} == 'id'">selected</c:if>>아이디</option>
				<option value="name" <c:if test="${pageVO.type} == 'name'">selected</c:if>>이  름</option>
		</select>
	  <input type='text' id='searchKeyword' value="${pageVO.keyword}">
	  <button id='searchBtn'>Search</button> 
	</div>
	
	<div class="col-sm-offset col-sm-4">
		<ul class="btn-group pagination">
		    <c:if test="${pageMaker.prev }">
		    <li>
		        <a href='<c:url value="/manager/buy/buyList?page=${pageMaker.startPage-1}"/>'><span class="glyphicon glyphicon-chevron-left"></span></a>
		    </li>
		    </c:if>
		    
		    <c:forEach begin="${pageMaker.startPage}" end="${pageMaker.endPage}" var="pageNum">
		    <li>
		        <a href='<c:url value="/manager/buy/buyList?page=${pageNum}"/>'><i>${pageNum}</i></a>
		    </li>
		    </c:forEach>
		    
		    <c:if test="${pageMaker.next && pageMaker.endPage >0}">
		    <li>
		        <a href='<c:url value="/manager/buy/buyList?page=${pageMaker.endPage+1}"/>'><span class="glyphicon glyphicon-chevron-right"></span></a>
		    </li>
		    </c:if>
		</ul>
	</div>
	
	<form id="formList" action="/manager/buy/buyList" method="get">
		<input type='hidden' name='page'		value="${result.currentPageNum}">
		<input type='hidden' name='size'		value="${result.currentPage.pageSize}">
		<input type='hidden' name='searchType' 	value="${pageVO.type}">
		<input type='hidden' name='keyword' 	value="${pageVO.keyword}">
	</form>
	
	
</div>

<script>

$(document).ready(function() {
	
	var formObj = $("#formList");
	
	// 검색 버튼을 눌렀을 경우
	$("#searchBtn").click(function(e){
		
		var typeStr = $("#searchType").find(":selected").val();
		var keywordStr = $("#searchKeyword").val();
		
		console.log(typeStr, "" , keywordStr);
		
		//alert("검색 타입" + typeStr);
		//alert("검색 키워드" + keywordStr);
		
		//formObj.find("[name='type']").val(typeStr);
		formObj.find("[name='searchType']").val(typeStr);
		formObj.find("[name='keyword']").val(keywordStr);
		formObj.find("[name='page']").val("1");
		formObj.submit();
	});

});

</script>

</body>

</html>

</layoutTag:layout>	