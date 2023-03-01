<%@page import="dto.MemberDto"%>
<%@page import="dto.CalendarDto"%>
<%@page import="dao.CalendarDao"%>
<%@page import="util.CalendarUtil"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<% 
MemberDto login = (MemberDto)session.getAttribute("login");
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
<title>Insert title here</title>
</head>
<body>
<% 
String sseq = request.getParameter("seq");
int seq = Integer.parseInt(sseq);

CalendarDao dao = CalendarDao.getInstance();
CalendarDto dto = dao.getCalDto(seq);
 

String rdate = dto.getRdate();//2023 03 01 15 30
String year = rdate.substring(0,4);
String month = rdate.substring(4,6);
String day = rdate.substring(6,8);


%>

<h2>일정수정</h2>

<div align="center">
		<form action="calUpdateAf.jsp" method="get">
			<table border="1">
				<col width="200">
				<col width="400">

				<tr>
					<th>아이디</th>
					<td><%=login.getId()%>
					<input type="hidden" name ="seq" value="<%=seq%>"> </td>
				</tr>
				<tr>
					<th>제목</th>
					<td><input type="text" name="title" id="title" size="50px" ></td>
				</tr>
				<tr>
					<th>일정</th>
					<td><input type="date" name ="date" value=<%=CalendarUtil.hyphenDate(year, month, day) %> readonly="readonly">
					<input type="time" name="time"></td>
				</tr>
				<tr>
					<th>내용</th>
					<td><textarea rows="20" cols="50px" id="content"
							name="content" placeholder="내용기입"></textarea></td>
				</tr>

				<tr>
					<td colspan="2" align="center"><input type="submit" value="수정"></td>
				</tr>

			</table>
		</form>
	</div>
	
</body>
</html>