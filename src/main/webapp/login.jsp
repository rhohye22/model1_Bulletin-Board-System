<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="dao.MemberDao" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>login page</title>
<!-- jQuery CDN -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
<!--jQuery-$.cookie 플러그인 -->
<script src="http://lab.alexcican.com/set_cookies/cookie.js" type="text/javascript" ></script>

</head>
<body>
	<h2>login page</h2>

	<div>
		<form action="loginAf.jsp" method="post">
			<table id=login_box border="1">
				<tr>
					<th rowspan="2">아이디</th>
					<td><input type="text" id="id" name="id"></td>
				</tr>
				<tr>
					<td style="border: none;">
					<input type="checkbox" id="chk_save_id" >id 저장</td>
				</tr>
				<tr>
					<th>패스워드</th>
					<td><input type="password" id="pwd" name="pwd"></td>
				</tr>
			</table>
			<br>
			<input type="submit" value="log-in" id="loginBtn">
			<a href="sign_up.jsp">회원가입</a>
		</form>
	</div>

<script type="text/javascript">
// id저장 체크


//쿠키 키값 생성
let user_id = $.cookie("user_id"); //키가 user_id인 쿠키 객체 생성,생성 직후는 null



	//만약 이브라우저에 (체크에서 만들었던) 쿠키가 있었다면 
	if (user_id != null) {
		$("#id").val(user_id); //id 입력란에 user_id 넣어라
		$("#chk_save_id").prop("checked", true);
	}
	$("#chk_save_id").click(function() { //아이디 저장 체크박스를 클릭했을때

		//체크했는데 
		if ($("#chk_save_id").prop("checked") == true) {

			if ($("#id").val().trim() == "") {//아이디가 입력된 상태가 아니라면
				//입력하라고 알럿창띄우고 체크 해제함
				alert("아이디를 입력하세요");
				$("#chk_save_id").prop("checked", false);
			} else {//아이디가 입력되어 있다면 쿠키저장
				$.cookie("user_id", $("#id").val().trim(), {
					expires : 7,
					path : './'
				})
			}

		} else {
			$.removeCookie("user_id", {
				path : './'
			});
		}

	});
</script>


</body>
</html>