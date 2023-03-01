<%@page import="dao.MemberDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원 가입</title>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>

<style type="text/css">
.center {
	margin: auto;
}
</style>
</head>
<body>
	<h2>회원가입</h2>

	<div class="center">
		<form>
			<table border="1" style="width: 400px;">

				<tr>
					<th rowspan="3">아이디</th>
					<td style="border: none;"><input type="text" id="new_id"
						name="new_id" placeholder="사용할 아이디를 입력하세요"></td>
				</tr>
				<tr>
					<td style="border: none;">
						<p id="idcheck" style="font-size: 8px;"></p>
					</td>
				</tr>
				<tr>
					<td style="border: none;"><input type="button"
						id="id_checkBtn" value="id확인"></td>
				</tr>
				<tr>
					<th>패스워드</th>
					<td><input type="password" id="new_pw" name="new_pw"></td>
				</tr>
				<tr>
					<th rowspan="2">패스워드 확인</th>
					<td style="border: none;"><input type="password"
						id="check_new_pw"> <input type="button" id="pw_checkBtn"
						value="확인"></td>

				</tr>
				<tr>
					<td style="border: none;">
						<p id="pw_correct" style="font-size: 8px;"></p>
					</td>
				</tr>
				<tr>
					<th>이름</th>
					<td><input type="text" id="sign_name" name="sign_name"></td>
				</tr>
				<tr>
					<th>이메일</th>
					<td><input type="email" id="sign_mail" name="sign_mail"></td>
				</tr>
				<tr>
					<td colspan="2"><input type="button" value="회원가입" id="signBtn"></td>
				</tr>

			</table>

		</form>
			<a href="login.jsp">로그인페이지</a>
	</div>

	<script type="text/javascript">

//등록되어 있는 아이디와 중복 확인

$("#id_checkBtn").click(function() {

	if ($("#new_id").val().trim()=="") {
		$("#idcheck").css("color", "#ff0000");
		$("#idcheck").text("공백은 불가합니다");
	}
	else if ($("#new_id").val().trim()!="") {
			
	$.ajax({
		type:"post",
		url:"idCheck.jsp",
		data:{ "new_id":$("#new_id").val() },
		success:function(msg){
	
			if(msg.trim() == "YES"){
				$("#idcheck").css("color", "#0000ff");
				$("#idcheck").text("사용할 수 있는 아이디입니다");
			}else{
				$("#idcheck").css("color", "#ff0000");
				$("#idcheck").text("사용중인 아이디입니다");
				$("#new_id").val("");
			}
		},
		error:function(){
			alert('error');
		}
	});

	}

});

//패스워드 확인
$("#pw_checkBtn").click(function() {
	$(function() {			
		if ($("#new_pw").val().trim() == $("#check_new_pw").val().trim()) {		
			$("#pw_correct").css("color", "#0000ff");
			$("#pw_correct").text("패스워드가 일치합니다");
		}else{
			$("#pw_correct").css("color", "#ff0000");
			$("#pw_correct").text("패스워드가 불일치합니다");
		}
	});
});



// 항목에 빈칸이 있다면 알럿창
$("#signBtn").click(function() {
	$(function(){
		
		if ($("#new_id").val().trim() =="") {
			alert("칸을 모두 입력하세요");
		}
		else if ($("#new_pw").val().trim() =="") {
			alert("칸을 모두 입력하세요");
		}
		else if ($("#check_new_pw").val().trim() =="") {
			alert("칸을 모두 입력하세요");
		}
		else if ($("#sign_name").val().trim() =="") {
			alert("칸을 모두 입력하세요");
		}
		else if ($("#sign_mail").val().trim() =="") {
			alert("칸을 모두 입력하세요");
		}
		else {
			$.ajax({
				type:"post",
				url:"sign_upAf.jsp",
				data:{ "new_id":$("#new_id").val(),
					"new_pw":$("#new_pw").val(),
					"sign_name":$("#sign_name").val(),
					"sign_mail":$("#sign_mail").val()							
				},
				
				success:function(msg){
				
					if(msg.trim()=="true" ){
						
						alert('가입되었습니다');
						location.href = "login.jsp";						
					}
					else{
						alert('회원가입 실패');
					}
				},
				error:function(){
					alert('error');
				}
			});
			
			
		}
		
	});
	
	
});




</script>
</body>
</html>