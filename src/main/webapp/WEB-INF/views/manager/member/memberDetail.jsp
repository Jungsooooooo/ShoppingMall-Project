<%@ page session="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="layoutTag" tagdir="/WEB-INF/tags/managertags" %>

<layoutTag:layout>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>회원 상세 정보</title>
</head>
<body>

<div class="container"style="padding-left:15%; padding-top:5%;">
	<h3>회원 상세 정보</h3>
	
	<form class="form-horizontal" action="/manager/member/update" method="post">
		<div class="form-group">
			<label class="control-label col-sm-2">회원번호</label>
			<div class="col-sm-5">
				<input class="form-control" value="${detail.userNum}" readonly="readonly" name="userNum" />
			</div>		
		</div>
				<div class="form-group">
			<label class="control-label col-sm-2">아이디</label>
			<div class="col-sm-5">
				<input class="form-control" value="${detail.userId}" readonly="readonly" name="userId"/>
			</div>		
		</div>
		<div class="form-group">
			<label class="control-label col-xs-2">비밀번호</label>
			<div class="col-sm-2">
				<input type="text"class="form-control" value="${detail.userPw}" name="userPw" />
			</div>		
		</div>
		<div class="form-group">
			<label class="control-label col-xs-2">이름</label>
			<div class="col-sm-3">
				<input class="form-control" value="${detail.userName}"name="userName" />
			</div>		
		</div>
		<div class="form-group">
			<label class="control-label col-xs-2">휴대폰</label>
			<div class="col-sm-3">
				<input type="text" class="form-control" value="${detail.userPhone}" name="userPhone"/>
			</div>		
		</div>
		<div class="form-group">
			<label class="control-label col-xs-2">이메일</label>
			<div class="col-sm-3">
				<input type="text"class="form-control" value="${detail.userEmail}" name="userEmail"/>
			</div>		
		</div>
		<div class="form-group">
			<label class="control-label col-sm-2">우편번호</label>
			<div class="col-sm-3">
				<input type="text" class="form-control" id="zipcode" name="zipcode" value="${detail.zipcode}"/>
				<input type="button"	class="form-control" onclick="daumZipCode()" value="우편번호검색"/>
			</div>
		</div>
		<div class="form-group">
			<label class="control-label col-sm-2">주    소</label>
			<div class="col-sm-6">
				<input type="text" class="form-control" id="userAddr1" name="userAddr1" value="${detail.userAddr1}"/>
				<input type="text" class="form-control" id="userAddr2" name="userAddr2" value="${detail.userAddr2}"/>
			</div>
		</div>
		<div class="form-group">
			<label class="control-label col-xs-2">생년월일</label>
			<div class="col-sm-3">
				<input type="text"class="form-control" value="${detail.userBirth}" name="userBirth"/>
			</div>		
		</div>
		<div class="form-group">
			<label class="control-label col-sm-2">가입일자</label>
			<div class="col-sm-5">
				<input class="form-control" value="${detail.regDate}" readonly="readonly" name="regDate" />
			</div>		
		</div>
		<div class="form-group">
			<div class="col-xs-offset-4 col-xs-3">
				<button type="button" class="btn btn-primary" onclick="location.href='/manager/member/memberList'">회원목록</button>
				<button type="submit" class="btn btn-primary">수정</button>
				<button type="button" class="btn btn-primary" onclick="location.href='/manager/member/delete/${detail.userNum}'">삭제</button>
				
			</div>
		</div>
	</form>
	
</div>

</body>
<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>

function daumZipCode() {
	new daum.Postcode({
		oncomplete: function(data) {
			// 팝업창에서 검색한 결과 중 항목을 클릭하였을 경우에 실행할 코드를 이곳에 작성한다.
			
			// 각 주소의 노출규칙에 따라서 주소를 조합한다.
			// 내려오는 변수의 값이 업을 경우에는 공백('')값을 가지므로, 이름 참조하여 분기한다.
			var	fullAddress	= '';	// 최종   주소 변수
			var	subAddress  = '';	// 조합형 주소 변수
			
			// 사용자가 선택한 주소의 타입에 따라서 해당 주소값을 가져온다.
			if(data.userSelectedType == 'R') {	// 도로명 주소를 선택한 경우
				fullAddress = data.roadAddress;
			} else {	// 지번 주소를 선택한 경우
				fullAddress = data.jibunAddress;
			}
			
			// 사용자가 선택한 주소가 도로명 타입일 때 주소를 조합한다.
			if(data.userSelectedType == 'R') {
				// 법정동명이 있을 경우 추가한다.
				if(data.bname != '') {
					subAddress += data.bname;
				}
				// 건물명이 있을 경우 추가한다.
				if(data.buildingName != '') {
					subAddress += (subAddress != '' ? ', ' + data.buildingName : data.buildingName);
				}
				
				// 조합형 주소의 유무에 따라 양쪽에 괄호를 추가하여 최종 주소를 만든다.
				fullAddress += (subAddress != '' ? '(' + subAddress + ')' : '');
			}

			// 우편번호와 주소 정보를 해당 필드에 나타낸다.
			document.getElementById('zipcode').value	= data.zonecode; // 우편번호
			document.getElementById('userAddr1').value	= fullAddress;	 // 주소내용
			
			// 커서를 상세주소 입력 필드로 이동시킨다.
			document.getElementById('userAddr2').focus();
		}
	// }).open(); // open()만 기술하면 팝업 창이 여러개 띄울 수 있다.
	}).open({
			// 우편번호 파업 창이 여러개 뜨는 것을 방지하기 위해서 popupName을 사용한다.
			popupName:	'postcodePopup'
	});
}

</script>
</html>
</layoutTag:layout>



































