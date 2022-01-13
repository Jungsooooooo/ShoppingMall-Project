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
	<title>FAQ</title>
</head>
<body>

<div class="container" style="padding-left:-15%;">

	<div align="center">
		<h2>자주하는 질문</h2>
		<div class="form-group">
			<label class="control-label col-sm-2">질문 종류</label>
			<div class="col-sm-2">					
				 				
				<select class="form-control" name="faqClass" id="faqClass">
					<c:forEach items="${selectFaqType}" var="list">
						<option value="${list.faqClass}">${list.name}</option>						
					</c:forEach>				
				</select>					
					
			</div>
		</div>
	</div>
	<div class="col-sm-12">
	<table class="table table-striped table-bordered table-hover">
		<thead>
			<tr>
				<th>번호		</th>
				<th>질문 분류	</th>
				<th>질문		</th>
				<th>질문답변	</th>
			
			</tr>
		</thead>
		<tbody>
			<c:forEach var="faq" items="${list}">
			<tr>
				<td class="info" onclick="location.href='/manager/faq/detail/${faq.bno}'">${faq.bno}</td>
				<td>${faq.faqClass}</td>
				<td>${faq.title}</td>
				<td>${faq.content}</td>
			</tr>
			</c:forEach>
		</tbody>
	</table>
	</div>
	
	<div class="col-sm-offset-3 col-sm-4">
		<h3><a class="label label-info">검색조건</a></h3>
		
		<select id='searchType'>
			<option>검색종류</option>
				<option value="title"   <c:if test="${pageVO.type} == 'title'">selected</c:if>>질문</option>
				<option value="content" <c:if test="${pageVO.type} == 'content'">selected</c:if>>답변</option>
		</select>
	  <input type='text' id='searchKeyword' value="${pageVO.keyword}">
	  <button id='searchBtn'>Search</button> 
	</div>
	
	<div class="col-sm-offset-3 col-sm-4">
		<ul class="btn-group pagination">
		    <c:if test="${pageMaker.prev }">
		    <li>
		        <a href='<c:url value="/manager/faq/list?page=${pageMaker.startPage-1}"/>'><span class="glyphicon glyphicon-chevron-left"></span></a>
		    </li>
		    </c:if>
		    
		    <c:forEach begin="${pageMaker.startPage}" end="${pageMaker.endPage}" var="pageNum">
		    <li>
		        <a href='<c:url value="/manager/faq/list?page=${pageNum}"/>'><i>${pageNum}</i></a>
		    </li>
		    </c:forEach>
		    
		    <c:if test="${pageMaker.next && pageMaker.endPage >0}">
		    <li>
		        <a href='<c:url value="/manager/faq/list?page=${pageMaker.endPage+1}"/>'><span class="glyphicon glyphicon-chevron-right"></span></a>
		    </li>
		    </c:if>
		</ul>
	</div>
	
	<form id="formList" action="/manager/faq/list" method="get">
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
