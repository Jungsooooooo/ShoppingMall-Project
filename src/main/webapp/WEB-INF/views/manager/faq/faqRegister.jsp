<%@ page session="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="layoutTag" tagdir="/WEB-INF/tags/managertags" %>

<layoutTag:layout>

<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>FAQ 등록</title>
</head>
<body>

<div align="center"class="container"style="margin-top: 4.7%;padding-left:130px;">
	<div class="row">
	<form class="form-horizontal" action="/manager/faq/faqRegister" method="post" enctype="multipart/form-data">
			<h2 align="center">FAQ 등록</h2>
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
		
		<div class="form-group">
			<label class="control-label col-sm-2">자주 받는 질문</label>
			<div class="col-sm-8">
				<input type="text" class="form-control" maxlength="100" id="title" name="title" onkeydown="nextFocus(content)" placeholder="자주 받는 질문"/>
			</div>
		</div>

		
		
		
		<div class="form-group">
			<label class="control-label col-sm-2">답변</label>
			<div class="col-sm-7">
				<textarea class="form-control" rows="10" cols="100" id="content" name="content" placeholder="답변"></textarea>
			</div>
		</div>
		
		
		<div class="form-group">
			<div class="col-sm-offset-5 col-sm-2" >
				<input type="reset" class="btn btn-warning" value="다시작성"/>
				<input type="button" class="btn btn-primary" name="btn_OK" onclick="checkRegisterForm(this.form)" value="등록"/>
			</div>
		</div>
	</form>
	</div>
</div>

<script>
//포커스를 이동시키는 함수
function nextFocus(where) {
	//alert("포커스를 이동시키는 함수");
	if(event.keyCode == 13) {//Enter Key를 눌렀으면
		where.focus();
	}
}
</script>

<script>
function checkRegisterForm(faqRegister) {
		
	if(!faqRegister.faqClass.value) {
		alert("질문종류를 선택하십시오.");
		faqRegister.faqClass.focus();
		return false;
	}
	if(!faqRegister.title.value) {
		alert("질문 제목을 입력하십시오.");
		faqRegister.title.focus();
		return false;
	}
	if(!faqRegister.content.value) {
		alert("답변을 입력하십시오.");
		faqRegister.content.focus();
		return false;
	}
	
	
	faqRegister.submit();
	
}
</script>
</body>
</html>

</layoutTag:layout>