<%@ page session="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"   		uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" 		uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib  prefix="spring" 	uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="layoutTag" 	tagdir="/WEB-INF/tags" %>

<layoutTag:layout>

<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>FAQ</title>
</head>
<body>

<div class="container" >

	<div align="left">
		<h2>자주하는 질문</h2>
							
		<!-- <div class="form-group">
			<label class="control-label col-sm-2">질문</label> -->
			<%-- <div class="btn-group">
					<button type="button" class="btn btn-default btn-warning dropdown=toggle" data-toggle="dropdown" aria-expanded="false">
						질문종류 <span class="caret"></span>
					</button>
					<ul class="dropdown-menu">
						<c:forEach items="${selectFaqType}" var="list">
							<option value="${list.faqClass}">${list.name}</option>						
						</c:forEach>
						<li><a href="/main/faq/${faqClass}=${list.faqClass}">${list.name}</a></li>
					</ul>
				</div>
											
					
			</div> --%>
	</div>
	
	<div class="col-sm-12">
	<table class="table table-bordered">
		<thead>
			<tr align="center">
				<th>자주 하는 질문</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach var="faq" items="${list}" varStatus="status">
			<tr>
   			 <td>
		      <span class="glyphicon glyphicon-plus plusIcon"></span>
		      <span class="glyphicon glyphicon-minus plusIcon" style="display:none"></span>
		      ${faq.title}
		    </td>  
 			 </tr>
		  <tr style="display:none">
		    <td>
		      <table class="table table-bordered">
		        <tr>
		          <td>
		      	${faq.content}
		      	 </td>
		        </tr>
		      </table>    
		    </td>
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
		        <a href='<c:url value="/main/faq?page=${pageMaker.startPage-1}"/>'><span class="glyphicon glyphicon-chevron-left"></span></a>
		    </li>
		    </c:if>
		    
		    <c:forEach begin="${pageMaker.startPage}" end="${pageMaker.endPage}" var="pageNum">
		    <li>
		        <a href='<c:url value="/main/faq?page=${pageNum}"/>'><i>${pageNum}</i></a>
		    </li>
		    </c:forEach>
		    
		    <c:if test="${pageMaker.next && pageMaker.endPage >0}">
		    <li>
		        <a href='<c:url value="/main/faq?page=${pageMaker.endPage+1}"/>'><span class="glyphicon glyphicon-chevron-right"></span></a>
		    </li>
		    </c:if>
		</ul>
	</div>
	
	<form id="formList" action="/main/faq" method="get">
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

$(function () {
    
    // 왼쪽메뉴 드롭다운
    $("#answer").hide();
    $("#fa").click(function () {
        $("#answer").slideToggle(300);
    });
    // 외부 클릭 시 좌측 사이드 메뉴 숨기기
    
});

$(".plusIcon").on("click",function(){
	  var obj = $(this);
	  if( obj.hasClass("glyphicon-plus") ){
	    obj.hide();
	    obj.next().show();            
	    obj.parent().parent().next().show();
	  }else{
	     obj.hide();
	     obj.prev().show();
	     obj.parent().parent().next().hide();
	  }
	});




</script>

</body>

</html>

</layoutTag:layout>
