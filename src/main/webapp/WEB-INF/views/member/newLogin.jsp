<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<title>로그인</title>
</head>
<body>
	<div class="container">
		<form class="form-horizontal" action="/member/login" method="post" id="loginform">
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
			
			<div class="int-area">
            	<p class="error">로그인이 필요합니다.</p>
         	</div>
         	
			<div class="form-group">
				<div class="col-sm-offset-2 col-sm-6">
					<button type="submit" class="btn btn-primary" id="submit">로그인</button>
				</div>
			</div>
			
		</form>
	</div>
</body>
<script>
	window.onunload = function () { 
	    window.opener.location.reload(); 
	    self.close();
	}
</script>
</html>