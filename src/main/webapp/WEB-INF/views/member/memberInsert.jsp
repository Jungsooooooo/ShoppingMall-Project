<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="layoutTag" tagdir="/WEB-INF/tags" %>
<layoutTag:layout>


<div class="container">
	<form class="form-horizontal" action="/member/memberInsert" method="post">
		<div class="form-group">
			<div class="col-sm-2"></div>
			<div class="col-sm-6">
				<h2 align="center">회원 가입</h2>
			</div>
		</div>
		
		<div class="form-group">
			<label class="control-label col-sm-2">아 이 디</label>
			<div class="col-sm-3">
				<input type="text" class="form-control" id="userId" name="userId" maxlength="16" placeholder="Enter ID"/>*4~12자의 영문 대소문자와 숫자로만 입력
			</div>
			<div class="col-sm-2">
				<button class="idCheck btn btn-warning" type="button" id="idCheck" onclick="fn_idCheck();" value="N">중복확인</button>
			</div>
		</div> 
		
		<div class="form-group">
			<label class="control-label col-sm-2">비밀번호</label>
			<div class="col-sm-3">
				<input type="password" class="form-control" id="userPw" name="userPw" maxlength="16" placeholder="Enter Password"/>*4~12자의 영문 대소문자와 숫자로만 입력
			</div>
		</div>
		
		<div class="form-group">
			<label class="control-label col-sm-2">비밀번호 확인</label>
			<div class="col-sm-3">
				<input type="password" class="form-control" id="reuserPw" name="reuserPw" maxlength="16" placeholder="Enter Password"/>
				<font id="chkNotice" size="2"></font>
			</div>
		</div>
		
		<div class="form-group">
			<label class="control-label col-sm-2">이름</label>
			<div class="col-sm-3">
				<input type="text" class="form-control" id="userName" name="userName" maxlength="20" placeholder="Enter Name"/>*2~20글자 이상 입력
			</div>
		</div>
		
		<div class="form-group">
			<label class="control-label col-sm-2">생년월일</label>
			<div class="col-sm-3">
				<input type="text" class="form-control" id="userBirth" name="userBirth" placeholder="Enter Birth"/>*생년월일 6자 입력
			</div>
		</div>
		
		<div class="form-group">
			<label class="control-label col-sm-2">전화번호</label>
			<div class="col-sm-3">
				<input type="text" class="form-control" id="userPhone" name="userPhone" placeholder="Enter Telephone"/>*('-' 없이 번호만 입력해주세요)
			</div>
		</div>
		
		<div class="form-group">
			<label class="control-label col-sm-2">이메일</label>
			<div class="col-sm-3">
				<input type="text" class="form-control" id="userEmail" name="userEmail" placeholder="Enter Email"/>
			</div>
			<div class="col-sm-2">
				<button class="eCheck btn btn-warning" type="button" id="eCheck" onclick="fn_eCheck();" value="N">중복확인</button>
			</div>
		</div>
		
		<div class="form-group">
			<label class="control-label col-sm-2">우편번호</label>
			<div class="col-sm-3">
				<input type="text" class="form-control" id="zipcode" name="zipcode" placeholder="우편번호"/>
				<input type="button"	class="form-control" onclick="daumZipCode()" value="우편번호검색"/>
			</div>
		</div>
		
		<div class="form-group">
			<label class="control-label col-sm-2">주 소</label>
			<div class="col-sm-6">
				<input type="text" class="form-control" id="userAddr1" name="userAddr1" placeholder="Enter Address"/>
				<input type="text" class="form-control" id="userAddr2" name="userAddr2" placeholder="나머지주소 입력"/>
			</div>
		</div>
			
		<div class="form-group">
			<div class="col-sm-offset-3 col-sm-3 center">
				<button class="btn btn-success" type="submit" id="submit">회원가입</button>
				<button class="btn btn-danger cancel" type="button">가입취소</button>
			</div>
		</div>
	</form>
</div>

<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>
$(document).ready(function() {
	//취소
	$(".cancel").on("click", function() {
		location.href = "/";
	});
	//전송
	$("#submit").on("click", function() {
		// 정규 표현식
		var idd= RegExp(/^[a-zA-Z0-9]{4,12}$/)
		var pww= RegExp(/^[a-zA-Z0-9]{4,12}$/)
		var named= RegExp(/^[가-힣a-zA-Z]{2,20}$/)
		var email = RegExp(/^[A-Za-z0-9_\.\-]+@[A-Za-z0-9\-]+\.[A-Za-z0-9\-]+/)
	    var birth= RegExp(/^[0-9]{6}$/)
	    var phone= RegExp(/^0?[0-9]{11}$/)
		if($("#userId").val() == "") {
			alert("아이디를 입력하십시오.");
			$("#userId").focus();
			return false;
		}
		if(!idd.test($("#userId").val())){
			alert("아이디는 4~12자의 영문 대소문자와 숫자로만 입력하십시오.");
			$("#userId").val("");
            // idCheck.value = "";
            $("#userId").focus();
            return false;
		}
			
		if($("#userPw").val() == "") {
			alert("비밀번호를 입력하십시오.");
			$("#userPw").focus();
			return false;
		}
		//아이디 비밀번호 같음 확인
        if($("#userId").val() == $("#userPw").val()){
          alert("아이디와 비밀번호가 같습니다.\n다르게 입력해주십시오.");
          $("#userPw").val("");
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
		if($("#reuserPw").val() == "") {
			alert("비밀번호확인을 입력하십시오.");
			$("#reuserPw").focus();
			return false;
		}
		//비밀번호 서로확인
        if($("#userPw").val() != $("#reuserPw").val()){
            alert("비밀번호가 일치하지 않습니다.");
            $("#reuserPw").val("");
            $("#reuserPw").focus();
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
		if($('#userPw').val() != $('#reuserPw').val()){
			alert("비밀번호를 다시한번 입력해주세요.")
			$("#userPw").focus();
			return false;
		}	
			
		alert("회원가입 되었습니다.");
		
	});
});


	
function fn_idCheck() {
	$.ajax({
		url :		"/member/idCheck",
		type:		"post",
		dataType:	"json",
		data:		{"userId" : $("#userId").val() },
		success:	function(data) {
			
			var idd= RegExp(/^[a-zA-Z0-9]{4,12}$/)
			//alert("Return : " + data);
			if(data == 1) {
				alert("이미 사용중인 아이디입니다.\n다른 아이디를 입력하십시요.");
			} else if(data == 0) {

				if(!idd.test($("#userId").val())){
					alert("아이디는 4~12자의 영문 대소문자와 숫자로만 입력하십시오.");
					$("#userId").val("");
		            // idCheck.value = "";
		            $("#userId").focus();
		            return false;
				}
					
				$("#idCheck").attr("value", "Y");
				alert("사용가능한 아이디입니다.");
			}
		}
	});
}



$(function(){
    $('#userPw').keyup(function(){
      $('#chkNotice').html('');
    });

    $('#reuserPw').keyup(function(){

        if($('#userPw').val() != $('#reuserPw').val()){
          $('#chkNotice').html('비밀번호 일치하지 않음<br><br>');
          $('#chkNotice').attr('color', '#f82a2aa3');
        } else{
          $('#chkNotice').html('비밀번호 일치함<br><br>');
          $('#chkNotice').attr('color', '#199894b3');
        }

    });
});

function fn_eCheck() {
	$.ajax({
		url :		"/member/eCheck",
		type:		"post",
		dataType:	"json",
		data:		{"userEmail" : $("#userEmail").val() },
		success:	function(data) {
			var email = RegExp(/^[A-Za-z0-9_\.\-]+@[A-Za-z0-9\-]+\.[A-Za-z0-9\-]+/)
			//alert("Return : " + data);
			if(data == 1) {
				alert("이미 사용중인 이메일입니다.\n다른 이메일을 입력하십시요.");
			} else if(data == 0) {
				
				if(!email.test($("#userEmail").val())){
		             alert("이메일형식에 맞게 입력해주세요")
		             $("#userEmail").val("");
		             $("#userEmail").focus();
		             return false;
		        }
				$("#eCheck").attr("value", "Y");
				alert("사용가능한 이메일입니다.");
			}
		}
	});
}



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