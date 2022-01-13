<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="layoutTag" tagdir="/WEB-INF/tags" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib prefix="c"	uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%! SimpleDateFormat sdf = new SimpleDateFormat("yyyy년 MM월 dd일 HH시 mm분"); %>
<layoutTag:layout>

<div class="container">
	<h2 align="center">회원목록</h2>
	<table class="table table-bordered table-striped table-hover">
		<thead>
			<tr>
				<td align="center">아이디</td>
				<td align="center">이  름</td>
				<td align="center">가입일자</td>
				<td align="center">전화번호</td>
				<td align="center">주  소</td>
			</tr>
		</thead>
		<tbody>
		<c:forEach var="list" items="${memberList}">
			<tr>
				<td align="center"><a href="/member/memberView?id=${list.userId}">${list.userId}</a></td>
				<td align="center">${list.userName}</td>
				<td align="center"><fmt:formatDate value="${list.regDate}" pattern="yyyy년 MM월 dd일 HH시 mm분"/></td>
				<td align="center">${list.userPhone}</td>
				<td>${list.zipcode}${list.userAddr1}${list.userAddr2}</td>
			</tr>	
		</c:forEach>
		</tbody>
	</table>
</div>	


</layoutTag:layout>








