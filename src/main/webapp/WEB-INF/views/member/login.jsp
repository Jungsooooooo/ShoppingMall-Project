<%@ page session="true"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="layoutTag" tagdir="/WEB-INF/tags"%>

<layoutTag:layout>
	<!DOCTYPE html>
	<html>
<head>
<meta charset="UTF-8">
<title>로그인</title>
</head>
<body>
	<div class="container">
		<form class="form-horizontal" action="/member/login" method="post" id="loginform">
			<!-- 로그인을 하지 않고 들어온 경우 -->
			<c:if test="${member == null}">

				<div class="form-group">
					<label class="control-label col-sm-2">아이디</label>
					<div class="col-sm-3">
						<input type="text" class="form-control" id="userId" name="userId"
							maxlength="16" placeholder="Enter username" />
					</div>
				</div>
				
				<div class="form-group">
					<label class="control-label col-sm-2">비밀번호</label>
					<div class="col-sm-3">
						<input type="password" class="form-control" id="password"
							placeholder="Enter password" name="userPw">
					</div>
				</div>

				<div class="form-group">
					<div class="col-sm-offset-2 col-sm-6">
						<button type="submit" class="btn btn-primary" id="submit">로그인</button>
						<button class="btn btn-danger" type="button" id="registerBtn">회원가입</button>
					</div>
				</div>
				
				<div class="form-group">
					<div class="col-sm-offset-2 col-sm-6">
						<button class="btn btn-light" type="button" id="findidBtn">아이디찾기</button>
						<button class="btn btn-light" type="button" id="findpwBtn">비밀번호찾기</button>
					</div>
				</div>
			</c:if>

			<!-- 로그인을 하고 들어온 경우 -->
			<!-- 세션을 체크하기 위해서는 상단에 page session값을 true로 설정해야 한다. -->
			<c:if test="${member != null}">
				
				<div class="form-group">
					<div class="col-sm-offset-2 col-sm-6">
						<div class="jumbotron">
							<h2 align="center">${member.userId}${member.userName}님
								환영합니다.</h2>
							<c:if test="${member.userId == 'master'}">
								<div align="center">
								<a href="/manager/managerMain">관리자 페이지로</a>
								</div>
							</c:if>
						</div>
					</div>
				</div>
				
				<div class="form-group">
					<div class="col-sm-offset-3 col-sm-4">
						<input type="hidden" id="userId" name="id"
							value="${member.userId}" />
						<button id="memberUpdateBtn" type="button" class="btn btn-warning">회원정보수정</button>
						<button id="memberDeleteBtn" type="button" class="btn btn-danger">회원탈퇴</button>
						<button id="logoutBtn" type="button" class="btn btn-info">로그아웃</button>
					</div>
				</div>
			</c:if>
			<c:if test="${msg == false}">
				<div class="col-sm-8">
					<div class="jumbotron">
						<h4 align="center">로그인을 실패하였습니다. 아이디와 비밀번호를 확인하신 후에 다시 하십시오.</h4>
					</div>
				</div>
				<div class="form-group">
					<div class="col-sm-8">
						<div style="background-color: #CF0; color: red;">
							<h4>로그인을 실패하였습니다. 아이디와 비밀번호를 확인하신 후에 다시 하십시오.</h4>
						</div>
					</div>
				</div>
			</c:if>
			<c:if test="${result == 'fail'}">
				<p>로그인을 실패하였습니다.</p>
			</c:if>

		</form>
	</div>
	<script>
		$(document).ready(function() {
			// 로그아웃 버튼을 눌렀을 경우
			$("#logoutBtn").on("click", function() {
				location.href = "/member/logout";
			});

			// 로그인 버튼을 눌렀을 경우
			$("#submit").on("click", function() {
				if ($("#userId").val() == "") { // 아이디를 입력하지 않았으면
					alert("아이디를 입력하십시오.");
					$("#userId").focus();
					return false;
				}
				if ($("#password").val() == "") { // 비밀번호를 입력하지 않았으면
					alert("비밀번호를 입력하십시오.");
					$("#password").focus();
					return false;
				}
				document.getElementById("loginForm").submit();
				return false;
			});
			// 회원탈퇴버튼을 눌렀을 경우 회원탈퇴 페이지로 이동한다.
			$("#memberDeleteBtn").on("click", function() {
				location.href = "/member/memberDelete/" + $("#userId").val();
			});
			

			// 회원가입버튼을 눌렀을 경우 회원가입 페이지로 이동한다.
			$("#registerBtn").on("click", function() {
				location.href = "/member/memberInsert";
			});

			// 회원정보수정버튼을 눌렀을 경우 회원정보수정 페이지로 이동한다.
			$("#memberUpdateBtn").on("click", function() {
				location.href = "/member/memberUpdate/" + $("#userId").val();
			});

			// 아이디찾기
			$("#findidBtn").on("click", function() {
				location.href = "/member/findidpage";
			});
			
			// 비밀번호찾기
			$("#findpwBtn").on("click", function() {
				location.href = "/member/findpwpage";
			});

		});
	</script>
</body>
</html>

</layoutTag:layout>