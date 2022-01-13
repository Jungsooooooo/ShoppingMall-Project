<%@ page session="true"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="layoutTag" tagdir="/WEB-INF/tags"%>

<layoutTag:layout>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>구매목록</title>

<style>
.aa span { float:right; }
.table tr .bb { padding-top:70px; }
.table tr .ab { padding-top:46px; }

</style>

</head>
<body>
<c:choose>
    <c:when test="${map.count == 0 }">    
	    <div class="form-group">
	   		<div class="jumbotron">	
	       		<h2 align="center">구매상품이 없습니다</h2>
			</div>
		</div>
    </c:when>
    <c:otherwise>
		<div class="container">
			<h3	 align="left">
				<b>구매 목록</b>
			</h3>
			<form method="post">
				<c:forEach items="${map.list}" var="list">
					<c:set var="date"><fmt:formatDate value="${list.reg_date}" pattern="yyyy-MM-dd" /></c:set>
					<c:if test="${checkDate ne date }">
						<div align="center">
							<h4>${date}</h4>
						</div>
					</c:if>
					
					<c:if test="${check ne list.buyNum }">
						<!-- ne : not equal -->
						<table class="table table-border">
							<tr class="info">
								<td class="aa" colspan="8">
									No. ${list.buyNum }
									<span>구매일자 : <fmt:formatDate value="${list.reg_date}" pattern="yy-MM-dd"/></span>
								</td>
							</tr>
							<tr class="info table-hover" height="30">				
								<td align="center">상품 이미지</td>
								<td align="center">상품이름</td>
								<td align="center">구매가격</td>
								<td align="center">구매수량</td>		
								<td align="center">배송현황</td>				
							</tr>
									
							<c:forEach items="${map.list}" var="list2" >
								<c:if test="${list.buyNum eq list2.buyNum}">
									<tr align="center">				
										<td><img src="/images/${list2.productImage }" width=100 height=150></td>
										<td class="bb">${list2.productName}</td>
										<td class="bb"><fmt:formatNumber	value=" ${ list2.productPrice * (100 - list2.discount_rate) / 100 }" pattern="###,###,###" /></td>
										<td class="bb">${list2.buy_productCount}</td>				
										<td class="ab">
											<c:if test="${list2.shipping =='상품준비중'}"> 상품준비중 <br><br> <span class="glyphicon glyphicon-gift gi-2x"></span></c:if>					
											<c:if test="${list2.shipping =='배송중'}">배송중<br><br><span class="glyphicon glyphicon-send gi-2x"></span></c:if>			
											<c:if test="${list2.shipping =='배송완료'}">	배송완료	<br><br><span class="glyphicon glyphicon-home gi-2x"></span></c:if>
										</td>
									</tr>
								</c:if>
							</c:forEach>
							
							<tr>
								<td colspan="8" align="right">
									${list.sum} + 배송비 ${list.shippingFee} = ${list.finalSum}원
								</td>
							</tr>
							<c:set var="check" value="${list.buyNum}"/>
							<c:set var="checkDate"><fmt:formatDate value="${list.reg_date}" pattern="yyyy-MM-dd" /></c:set>
						</table>
					</c:if>			
				</c:forEach>
			</form>
		</div>
	</c:otherwise>
</c:choose>
</body>
</html>
</layoutTag:layout>