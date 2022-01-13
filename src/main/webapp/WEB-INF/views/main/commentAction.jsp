<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<script>

var productCode = $("[name=productCode]").val();	//게시글 번호
var writer = $("[name=writer]").val();
var checkBuy =$("[name=checkBuy]").val();
var checkComment =$("[name=checkComment]").val();

/*-----------------------------------------------------------------------------------------------------------
* 댓글 등록 버튼을 눌렀을 경우
-----------------------------------------------------------------------------------------------------------*/
$('[name=commentInsertBtn]').click(function() {
	if(checkBuy == 0) {
		alert("구매 완료 후 작성 가능합니다.");
	} else if(checkBuy <= checkComment) {
		alert("상품 구매 개수보다 많이 작성할 수 없습니다.");
	} else {
		var insertData = $('[name=commentInsertForm]').serialize();	//commentInsertForm의 내용을 가져온다.
		commentInsert(insertData);	
	}
});

//jQuery Serialize()
//jQUery Ajax로 호출하기 전에 serialize를 해주면 form안에 값들을
//한 번에 전송가능한 data로 만들 수 있어서, 많은 data를 보낼 때 유용하다. (Ajax가 아닐 때도 사용가능)
//Format : $("form id" 또는 "form name").serialize();

/*-----------------------------------------------------------------------------------------------------------
* 댓글 등록
-----------------------------------------------------------------------------------------------------------*/
function commentInsert(insertData){
    $.ajax({
        url : '/comment/insert',
        type : 'post',
        data : insertData,
        success : function(data){
            if(data == 1) {
                commentList(); //댓글 작성 후 댓글 목록 reload
                $('[name=content]').val('');
            }
        }
    });
}

/*-----------------------------------------------------------------------------------------------------------
* 페이지 로딩시 게시글에 연결된 댓글이 있으면 무조건 댓글을 보여준다.
-----------------------------------------------------------------------------------------------------------*/
$(document).ready(function() {
	/* alert("commentList Called.....");
	alert(checkBuy);
	alert(checkComment);
 */	commentList();
});

/*-----------------------------------------------------------------------------------------------------------
* 댓글 목록 보기
-----------------------------------------------------------------------------------------------------------*/
function commentList() {
	// alert("commentList Start.....");

	$.ajax({
		url:	'/comment/list/' + productCode,
		type:	'get',
		data:	{'productCode': productCode},
		success: function(data) {
			// alert("commentList data ==> " + data);
			var str = '';
			$.each(data, function(key, value){ 
				var wri = value.writer;
				var showWri = wri.substr(0,3);
				//alert(showWri);
				var hideWri = wri.substr(3,wri.length);
				var starWri = hideWri.replace(/^[a-zA-Z0-9]*$/, '*')
				
				str += '<div class="commentArea" style="border-bottom:1px solid darkgray; margin-bottom: 15px;">';
				str += '<div class="commentInfo'+value.cno+'">'+'작성자 : '+showWri+starWri +'(' +value.reg_date +')';
				if(writer == value.writer ) {
					str += '<a onclick="commentUpdate('+value.cno+',\''+value.content+'\');"> 수정 </a>';
					str += '<a onclick="commentDelete('+value.cno+');"> 삭제 </a>';
				}
				str += ' </div> <div class="commentContent'+value.cno+'"> <p> 내용 : '+value.content +'</p>';
				str += '</div>';
				str += '</div>';
			});
			$(".commentList").html(str);
		},
		complete: function(data) {
			console.log(data);
		}
	})
	//<fmt:formatDate value="${detail.reg_date}" pattern="yyyy/MM/dd HH:mm:ss" />
	// 콜백함수 : 요청 성공 시에 호출되는 함수
	// ajax 콜백 함수는 ajax 함수에 연결 연산자를 붙여서 사용한다.
	.done(function(data) {
		//alert(data);
		console.log(data);
	});
}


/*-----------------------------------------------------------------------------------------------------------
* 댓글 수정 - 댓글 내용 출력을 input 폼으로 변경한다.
-----------------------------------------------------------------------------------------------------------*/
function commentUpdate(cno, content) {
	var str = '';
	
	str += '<div class="input-group">';
	str += '<input type="text" class="form-control" name="content_' + cno + '" value="' +content + '"/>';
	str += '<span class="input-group-btn"><button class="btn btn-warning" type="button" onclick="commentUpdateProc('+cno+');">수정</button> </span>';
	str += '</div>';
	
	$('.commentContent' + cno).html(str);
}

/*-----------------------------------------------------------------------------------------------------------
* 댓글 수정 - 수정한 댓글 내용을 테이블에 업데이트한다.
-----------------------------------------------------------------------------------------------------------*/
function commentUpdateProc(cno) {
	//alert("commentUpdateProc");
	//댓글 번호에 해당하는 수정된 내용을 가져온다.
	var updateContent = $('[name=content_' + cno + ']').val();
	
	$.ajax({
		url:	'/comment/update',
		type:	'post',
		data:	{'content' : updateContent, 'cno' : cno},
		success: function(data) {
			if(data == 1) commentList(productCode); //댓글을 수정한 후 목록을 출력한다.
		}
	});
}

/*-----------------------------------------------------------------------------------------------------------
* 댓글 삭제
-----------------------------------------------------------------------------------------------------------*/
function commentDelete(cno) {
	alert("삭제됐습니다.");
	$.ajax({
		url:	'/comment/delete/' + cno,
		type:	'post',
		success: function(data) {
			if(data == 1) commentList(productCode);	//댓글 삭제 후에 목록을 출력한다.
		}
	});
}

</script>




























