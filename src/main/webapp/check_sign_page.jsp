<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원가입 완료</title>
</head>
<body>

	<%

	String id = request.getParameter("new_id");
	%>

	<h2>회원가입이 완료 되었습니다</h2>
	<p>
		가입한 아이디는 <span style="color: blue; border-bottom: 1px solid blue;">
			<%= id %></span>입니다
	</p>
	<a href="login.jsp">로그인화면으로 이동</a>


</body>
</html>