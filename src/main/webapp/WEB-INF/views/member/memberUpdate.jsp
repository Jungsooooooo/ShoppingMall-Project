<%@ page session="true"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="layoutTag" tagdir="/WEB-INF/tags"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%!SimpleDateFormat sdf = new SimpleDateFormat("yyyy년 MM월 dd일 HH시 mm분");%>
<layoutTag:layout>



	<div class="container">
		<form class="form-horizontal" action="/member/memberUpdate" method="post">
			<div class="form-group">
				<div class="col-sm-2"></div>
				<div class="col-sm-6">
					<h2 align="center">회원 정보 수정</h2>
				</div>
			</div>

			<!-- 아이디 -->
			<div class="form-group">
				<label class="control-label col-sm-2" for="userId">아이디</label>
				<div class="col-sm-3">
				 <input type="text" class="form-control" name="userId" value="${view.userId}" readonly="readonly" required>
			</div>
			</div>
			<!-- 비밀번호 -->
			<div class="form-group">
				<label class="control-label col-sm-2" for="userPw">비밀번호</label>
				<div class="col-sm-3">
				 <input type="password" class="form-control" id="userPw" name="userPw" value="${view.userPw}"placeholder="PASSWORD" >*비밀번호 변경가능(4~12자의 영문 대소문자와 숫자만)
			</div>
			</div>
			
			<!-- 이름 -->
			<div class="form-group">
				<label class="control-label col-sm-2" for="userName">이름</label> 
				<div class="col-sm-3">
				<input type="text" class="form-control" id="userName" name="userName" maxlength="20" value="${view.userName}">
			</div>
			</div>
			<!-- 생년월일 -->
			<div class="form-group required">
				<label class="control-label col-sm-2" for="userBirth">생년월일</label>
				<div class="col-sm-3">
				 <input type="text" class="form-control" id="userBirth" name="userBirth" placeholder="ex) 19990415" value="${view.userBirth}">*생년월일 6자 입력
			</div>
			</div>
			
			<!-- 휴대전화 -->
			<div class="form-group">
				<label class="control-label col-sm-2" for="user_phone">전화번호</label> 
				<div class="col-sm-3">
				<input type="text" class="form-control" id="userPhone" name="userPhone" placeholder="휴대전화 ('-' 없이 번호만 입력해주세요)" value="${view.userPhone}" >*('-' 없이 번호만 입력해주세요)
			</div>
			</div>
			
			<!-- 본인확인 이메일 -->
			<div class="form-group">
				<label class="control-label col-sm-2" for="userEmail">이메일</label> 
				<div class="col-sm-3">
				<input type="text" class="form-control" name="userEmail" id="userEmail" placeholder="E-mail" value="${view.userEmail}" readonly="readonly">
			</div>
			</div>
			<!-- 우편번호 -->
				<div class="form-group">
					<label class="control-label col-sm-2">우편번호</label>
					<div class="col-sm-3">
						<input type="text" class="form-control" id="zipcode" name="zipcode" placeholder="우편번호" value="${view.zipcode}" /> 
						<input type="button" class="form-control" onclick="daumZipCode()" value="우편번호검색" />
					</div>
				</div>
			<!-- 기본주소 및 상세주소-->
				<div class="form-group">
					<label class="control-label col-sm-2">주 소</label>
					<div class="col-sm-6">
						<input type="text" class="form-control" id="userAddr1" name="userAddr1" placeholder="Enter Address" value="${view.userAddr1}" /> 
						<input type="text" class="form-control" id="userAddr2" name="userAddr2" placeholder="나머지주소 입력" value="${view.userAddr2}" />
					</div>
				</div>
				
			<div class="form-group">
				<div class="col-sm-offset-3 col-sm-2 center">
					<button class="btn btn-success" type="submit" id="submit">수정</button>
					<input class="btn btn-primary" type="button" value="뒤로가기" onclick="history.go(-1);" /> 
				</div>
			</div>
		</form>
	</div>
	
<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>
$(document).ready(function() {
	//전송
	$("#submit").on("click", function() {
		// 정규 표현식
		var idd= RegExp(/^[a-zA-Z0-9]{4,12}$/)
		var pww= RegExp(/^[a-zA-Z0-9]{4,12}$/)
		var named= RegExp(/^[가-힣a-zA-Z]{2,20}$/)
		var email = RegExp(/^[A-Za-z0-9_\.\-]+@[A-Za-z0-9\-]+\.[A-Za-z0-9\-]+/)
	    var birth= RegExp(/^[0-9]{6}$/)
	    var phone= RegExp(/^0?[0-9]{11}$/)
	    
	    if($("#userPw").val() == "") {
			alert("비밀번호를 입력하십시오.");
			$("#userPw").focus();
			return false;
		}
	      //비밀번호 유효성검사
	      if(!pww.test($("#userPw").val())){
	          alert("비밀번호는 4~12자의 영문 대소문자와 숫자로만 입력하십시오.");
	          $("#userPw").val("");
	          $("#userPw").focus();
	           return false;
	     }
	      if($("#userPw").val() == "${view.userPw}") {
				alert("기존과 다른 비밀번호를 입력해주세요.");
				$("#userPw").focus();
				return false;
			}
		if($("#userName").val() == "") {
			alert("이름를 입력하십시오.");
			$("#userName").focus();
			return false;
		}
		//이름 유효성 검사
        if(!named.test($("#userName").val())){
             alert("이름형식에 맞게 입력해주세요")
             $("#userName").val("");
             $("#userName").focus();
             return false;
        }
		
		if($("#userBirth").val() == "") {
			alert("생년월일을 입력하십시오.");
			$("#userBirth").focus();
			return false;
		}
		//생년월일 유효성 검사
        if(!birth.test($("#userBirth").val())){
             alert("생년월일 6자리를 입력해주세요.")
             $("#userBirth").val("");
             $("#userBirth").focus();
             return false;
        }
		
		if($("#userPhone").val() == "") {
			alert("전화번호를 입력하십시오.");
			$("#userPhone").focus();
			return false;
		}
		//전화번호 유효성 검사
        if(!phone.test($("#userPhone").val())){
             alert("핸드폰 번호를 입력해주세요.")
             $("#userPhone").val("");
             $("#userPhone").focus();
             return false;
        }
		
		if($("#userEmail").val() == "") {
			alert("이메일를 입력하십시오.");
			$("#userEmail").focus();
			return false;
		}
		//이메일 유효성 검사
        if(!email.test($("#userEmail").val())){
             alert("이메일형식에 맞게 입력해주세요")
             $("#userEmail").val("");
             $("#userEmail").focus();
             return false;
        }
		
		if($("#zipcode").val() == "") {
			alert("우편번호를 입력하십시오.");
			$("#zipcode").focus();
			return false;
		}
		if($("#userAddr1").val() == "") {
			alert("주소를 입력하십시오.");
			$("#userAddr1").focus();
			return false;
		}
		if($("#userAddr2").val() == "") {
			alert("상세주소를 입력하십시오.");
			$("#userAddr2").focus();
			return false;
		}
		
		alert("회원수정 되었습니다.");
		
	});
});


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

			// 우편번호와 ㅏ주소 정보를 해당 필드에 나타낸다.
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
</layoutTag:layout>