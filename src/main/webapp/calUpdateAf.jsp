<%@page import="dao.CalendarDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="util.CalendarUtil"%>

<%
String sseq = request.getParameter("seq");
int seq = Integer.parseInt(sseq);

String id = request.getParameter("id");
String title = request.getParameter("title");
String content = request.getParameter("content");
String date = request.getParameter("date");
String time = request.getParameter("time");

String rdate = CalendarUtil.DateTime(date, time);

CalendarDao dao = CalendarDao.getInstance();
boolean b = dao.updateDto(title, content, rdate, seq);

if (b) {
%>
<script type="text/javascript">
alert("일정이 수정되었습니다.");
location.href ="caldetail.jsp?seq=<%=seq%>";
</script>
<%
} else {
%>
<script type="text/javascript">
alert("변경에 실패하였습니다.");
location.href ="calUpdate.jsp?seq=<%=seq%>";
</script>sct
<%
}
%>