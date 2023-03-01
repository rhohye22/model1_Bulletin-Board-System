<%@page import="dto.CalendarDto"%>
<%@page import="dao.CalendarDao"%>
<%@page import="dto.MemberDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

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
	String time = rdate.substring(8,10);
	String min = rdate.substring(10,12);
	%>


	<h2>일정보기</h2>
	<a href="bbslist.jsp">게시판가기</a>&nbsp;&nbsp;&nbsp;<a href="calendar.jsp">달력보기</a>
<div align="center">

	<table border="1">
		<col width="200">
		<col width="400">

		<tr>
			<th>제목</th>
			<td><%=dto.getTitle()%></td>
		</tr>
		<tr>
			<th>일시</th>
			<td><%=year %>년 <%= month%>월 <%= day%>일 <%= time%>시 <%= min%>분</td>
		</tr>
		<tr>
			<th>내용</th>
			<td><%=dto.getContent()%></td>
		</tr>

	</table>
	
	<input type="button" value="수정" onclick="update()">
	<input type="button" value="삭제">

</div>

<script type="text/javascript">

function update() {
	location.href = "calUpdate.jsp?seq="+<%= dto.getSeq()%>;
}

</script>


</body>
</html>