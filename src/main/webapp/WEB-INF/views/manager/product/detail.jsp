<%@ page session="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="layoutTag" tagdir="/WEB-INF/tags/managertags" %>

<layoutTag:layout>

<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>게시글 상세 정보</title>
</head>
<body>

<div class="container"style="padding-left:15%; padding-top:5%;">
	<h3>게시글 상세 정보</h3>
	<div class="btn-group btn-group-sm col-sm-6" role="group" style="float:right;">
		
		<h4><a class="col-sm-3 btn btn-info" 	href="/manager/product/list">목록</a></h4>
		<h4><a class="col-sm-3 btn btn-success" href="/manager/product/detail/${detail.productCode}">수정</a></h4>
		<h4><a class="col-sm-3 btn btn-danger"	href="/manager/delete/${detail.productCode}">삭제</a></h4>
	</div>
	<br><br><br>
		
	<form class="form-horizontal" action="/manager/updateProc" method="post">
		<div class="form-group">
			<label class="control-label col-sm-2">상품 종류</label>
			<div class="col-sm-5">
				<input class="form-control" value="${detail.productClass}" readonly="readonly"name="class" />
			</div>		
		</div>
				<div class="form-group">
			<label class="control-label col-sm-2">상품 번호</label>
			<div class="col-sm-5">
				<input class="form-control" value="${detail.productCode}" readonly="readonly" name="productCode"/>
			</div>		
		</div>
		<div class="form-group">
			<label class="control-label col-xs-2">상품 이름</label>
			<div class="col-sm-2">
				<input type="text"class="form-control" value="${detail.productName}" name="name" />
			</div>		
		</div>
		<div class="form-group">
			<label class="control-label col-xs-2">가격</label>
			<div class="col-sm-3">
				<input class="form-control" value="${detail.productPrice}"name="productPrice" />
				<span class="input-group-addon">원</span>
			</div>		
		</div>
		<div class="form-group">
			<label class="control-label col-xs-2">할인율</label>
			<div class="col-sm-3">
				<input type="text" class="form-control" value="${detail.discount_rate}" name="discount_rate"/><span class="input-group-addon">%</span>
				
			</div>		
		</div>
		<div class="form-group">
			<label class="control-label col-xs-2">재고수량</label>
			<div class="col-sm-3">
				<input type="text"class="form-control" value="${detail.productCount}" name="productCount"/>
				
			</div>		
		</div>
			<div class="form-group">
			<label class="control-label col-xs-2">이미지</label>
			<div class="col-sm-3">
				<img src="/images/${detail.productImage}" >
			</div>		
		</div>
		<div class="form-group">
			<label class="control-label col-xs-2">내  용</label>
			<div class="col-sm-8">
				<textarea rows="4" cols="100" class="form-control" name="content" >${detail.productContent} </textarea>
			</div>		
		</div>
		<div class="form-group">
			<div class="col-xs-offset-4 col-xs-3">
				<button type="submit" class="btn btn-primary">확인</button>
			</div>
		</div>
	</form>
	
</div>

</body>
</html>
</layoutTag:layout>



































