<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="dto.CalendarDto"%>
<%@page import="dao.CalendarDao"%>
<%@page import="util.CalendarUtil"%>


<%
request.setCharacterEncoding("utf-8");

String id = request.getParameter("id");
String title = request.getParameter("title");
String content = request.getParameter("content");

String date = request.getParameter("date");
String time = request.getParameter("time");
System.out.println("date" + date);
System.out.println("time:" + time);

String rdate = CalendarUtil.DateTime(date, time);


CalendarDao dao = CalendarDao.getInstance();
CalendarDto dto = new CalendarDto(id, title, content, rdate);

boolean b = dao.addCalendar(dto);

if (b) {
%>
<script type="text/javascript">
alert("일정이 등록되었습니다");
location.href= "calendar.jsp";
</script>
<%
}else{
%>
<script type="text/javascript">
alert("일정이 추가되지 않았습니다);
location.href= "calwrite.jsp?year=" + year + "&month=" + month + "&day=" + day;

</script>
<% 
}
%>