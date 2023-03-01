<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="dto.MemberDto"%>
<%@page import="util.CalendarUtil"%>

<%
MemberDto login = (MemberDto) session.getAttribute("login");
if (login == null) {
%>
<script>
	alert('로그인 해 주십시오');
	location.href = "login.jsp";
</script>
<%
}
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>일정등록</title>
</head>
<body>

	<%
 	String year = request.getParameter("year");
	String month = request.getParameter("month");
	String day = request.getParameter("day");
	

	%>


	<h2>일정등록</h2>
	<div align="center">
		<form action="calwriteAf.jsp" method="get">
			<table border="1">
				<col width="200">
				<col width="400">

				<tr>
					<th>아이디</th>
					<td><%=login.getId()%>
					<input type="hidden" name ="id" value="<%=login.getId()%>"> </td>
				</tr>
				<tr>
					<th>제목</th>
					<td><input type="text" name="title" id="title" size="50px" ></td>
				</tr>
				<tr>
					<th>일정</th>
					<td><input type="date" name ="date" value=<%= CalendarUtil.hyphenDate(year, month, day) %> readonly="readonly">
					<input type="time" name="time"></td>
				</tr>
				<tr>
					<th>내용</th>
					<td><textarea rows="20" cols="50px" id="content"
							name="content" placeholder="내용기입"></textarea></td>
				</tr>

				<tr>
					<td colspan="2" align="center"><input type="submit" value="등록"></td>
				</tr>

			</table>
		</form>
	</div>


</body>
</html>