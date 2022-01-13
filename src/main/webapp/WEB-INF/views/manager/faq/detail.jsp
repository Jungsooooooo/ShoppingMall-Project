<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="layoutTag" tagdir="/WEB-INF/tags/managertags" %>

<layoutTag:layout>

<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Faq상세 정보</title>
</head>
<body>

<div class="container"style="padding-left:15%; padding-top:5%;">
	<h3>Faq 상세 정보</h3>
	<div class="btn-group btn-group-sm col-sm-6" role="group" style="float:right;">
		
		<h4><a class="col-sm-3 btn btn-info" 	href="/manager/faq/list">목록</a></h4>
		<h4><a class="col-sm-3 btn btn-success" href="/product/update/${detail.bno}">수정</a></h4>
		<h4><a class="col-sm-3 btn btn-danger"	href="/manager/faq/delete/${detail.bno}">삭제</a></h4>
	</div>
	<br><br><br>
		
	<form class="form-horizontal" action="/manager/faq/faqRegister" method="post">
		<div class="form-group">
			<label class="control-label col-xs-2">질문 종류</label>
			<div class="col-xs-5">
				<input class="form-control" value="${detail.faqClass}" readonly="readonly" />
			</div>		
		</div>
		<div class="form-group">
			<label class="control-label col-xs-2">질문</label>
			<div class="col-xs-2">
				<input class="form-control" value="${detail.title}" readonly="readonly" />
			</div>		
		</div>
		<div class="form-group">
			<label class="control-label col-xs-2">질문내용</label>
			<div class="col-xs-3">
				<input class="form-control" value="${detail.content}" readonly="readonly" />
			</div>		
		</div>
	</form>
	
</div>
</body>
</html>

</layoutTag:layout>



































