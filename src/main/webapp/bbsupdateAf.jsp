<%@page import="dao.BbsDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% 
String sseq = request.getParameter("seq");
int seq = Integer.parseInt(sseq);

String title = request.getParameter("title");
String content = request.getParameter("content");

BbsDao dao = BbsDao.getInstanse();
boolean b = dao.updateDto(seq, title, content);

if (b) {
%>
<script>
alert("수정 성공");
location.href = "bbsdetail.jsp?seq=<%=seq%>";
</script>
<%
} else {
%>
<script>
alert("수정 실패");
location.href = "bbsdetail.jsp?seq=<%=seq%>";
</script>
<%
}

%>