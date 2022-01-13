<%@ page session="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"   		uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" 		uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib  prefix="spring" 	uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="layoutTag" 	tagdir="/WEB-INF/tags/managertags" %>

<layoutTag:layout>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>상품 목록 보기</title>
</head>
<body>

<div class="container" style="padding-left:15%;">

	<div align="center">
		<h2>상품 목록</h2>
	</div>
	<div class="col-sm-12">
	<table class="table table-striped table-bordered table-hover">
		<thead>
			<tr>
				<th>등록 번호</th>
				<th>상품 분류</th>
				<th>상품 이름</th>
				<th>상품 가격</th>
				<th>상품 재고수량</th>
				<th>상세 설명</th>
				<th>상품 등록일자</th>
			
			</tr>
		</thead>
		<tbody>
			<c:forEach var="product" items="${list}">
			<tr>
				<td class="info" onclick="location.href='/manager/product/detail/${product.productCode}'">${product.productCode}</td>
				<td>${product.productClass}</td>
				<td>${product.productName}</td>
				<td><fmt:formatNumber value="${product.productPrice}" pattern="###,###,###"/></td>
				<td>${product.productCount}</td>
				<td>${product.productContent}</td>
				<td><fmt:formatDate value="${product.reg_date}" pattern="yyyy년 MM월 dd일 HH시 mm분 ss초"/></td>
				
			</tr>
			</c:forEach>
		</tbody>
	</table>
	</div>
	
	<div class="col-sm-offset-3 col-sm-4">
		<h3><a class="label label-info">검색조건</a></h3>
		
		<select id='searchType'>
			<option>검색종류</option>
				<option value="class" <c:if test="${pageVO.type} == 'class'">selected</c:if>>분류</option>
				<option value="name" <c:if test="${pageVO.type} == 'name'">selected</c:if>>이름</option>
		</select>
	  <input type='text' id='searchKeyword' value="${pageVO.keyword}">
	  <button id='searchBtn'>Search</button> 
	</div>
	
	<div class="col-sm-offset-3 col-sm-4">
		<ul class="btn-group pagination">
		    <c:if test="${pageMaker.prev }">
		    <li>
		        <a href='<c:url value="/manager/product/list?page=${pageMaker.startPage-1}"/>'><span class="glyphicon glyphicon-chevron-left"></span></a>
		    </li>
		    </c:if>
		    
		    <c:forEach begin="${pageMaker.startPage}" end="${pageMaker.endPage}" var="pageNum">
		    <li>
		        <a href='<c:url value="/manager/product/list?page=${pageNum}"/>'><i>${pageNum}</i></a>
		    </li>
		    </c:forEach>
		    
		    <c:if test="${pageMaker.next && pageMaker.endPage >0}">
		    <li>
		        <a href='<c:url value="/manager/product/list?page=${pageMaker.endPage+1}"/>'><span class="glyphicon glyphicon-chevron-right"></span></a>
		    </li>
		    </c:if>
		</ul>
	</div>
	
	<form id="formList" action="/manager/product/list" method="get">
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
