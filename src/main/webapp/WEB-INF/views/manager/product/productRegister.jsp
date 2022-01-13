<%@ page session="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="layoutTag" tagdir="/WEB-INF/tags/managertags" %>

<layoutTag:layout>

<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>상품 등록</title>
</head>
<body>

<div align="center"class="container"style="margin-top: 4.7%;padding-left:130px;">
	<div class="row">
	<form class="form-horizontal" action="/manager/product/productRegister" method="post" enctype="multipart/form-data">
			<h2 align="center">상품 등록</h2>
		<div class="form-group">
			<label class="control-label col-sm-2">상품 종류</label>
			<div class="col-sm-2">					
				 				
				<select class="form-control" name="productClass" id="productClass">
					<c:forEach items="${selectProductType}" var="list">
						<option value="${list.productClass}">${list.name}</option>						
					</c:forEach>				
				</select>					
					
			</div>
		</div>
		
		<div class="form-group">
			<label class="control-label col-sm-2">상품 이름</label>
			<div class="col-sm-8">
				<input type="text" class="form-control" maxlength="100" name="productName" onkeydown="nextFocus(productPrice)" placeholder="제목"/>
			</div>
		</div>
		
		<div class="form-group">
			<label class="control-label col-sm-2">가 격</label>
			<div class="col-sm-3">
				<div class="input-group">
					<input type="text" class="form-control" maxlength="6" name="productPrice" onkeydown="nextFocus(productCount)" placeholder="가격"/>
					<span class="input-group-addon">원</span>
				</div>
			</div>
		</div>
		
		<div class="form-group">
			<label class="control-label col-sm-2">수 량</label>
			<div class="col-sm-2">
				<input type="text" class="form-control" maxlength="6" name="productCount"	onkeydown="nextFocus(productImage)" placeholder="수량"/>
			</div>
		</div>
		
		<div class="form-group">
			<label class="control-label col-sm-2">이미지</label>
			<div class="col-sm-4">
				<input type="file" class="form-control" name="productImage" onkeydown="nextFocus(productContent)"/>
			</div>
		</div>
		
		<div class="form-group">
			<label class="control-label col-sm-2">상세 설명</label>
			<div class="col-sm-7">
				<textarea class="form-control" rows="10" cols="100" name="productContent" placeholder="상세 설명"></textarea>
			</div>
		</div>
		
		<div class="form-group">
			<label class="control-label col-sm-2">할인율</label>
			<div class="col-sm-2">
				<div class="input-group">
					<input type="text" class="form-control" size="4" maxlength="4" value="0" name="discount_rate" onkeydown="nextFocus(btn_OK)" placeholder="할인율"/>
					<span class="input-group-addon">%</span>
				</div>
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
function checkRegisterForm(productRegister) {
		
	if(!productRegister.productClass.value) {
		alert("상품분류를 선택하십시오.");
		productRegister.productClass.focus();
		return false;
	}
	if(!productRegister.productName.value) {
		alert("상품 이름을 입력하십시오.");
		productRegister.productName.focus();
		return false;
	}
	if(!productRegister.productPrice.value) {
		alert("가격을 입력하십시오.");
		productRegister.productPrice.focus();
		return false;
	}
	if(!productRegister.productCount.value) {
		alert("수량을 입력하십시오.");
		productRegister.productCount.focus();
		return false;
	}
	if(!productRegister.productContent.value) {
		alert("상품 설명 입력하십시오.");
		productRegister.productContent.focus();
		return false;
	}
	
	productRegister.submit();
	
}
</script>
</body>
</html>

</layoutTag:layout>