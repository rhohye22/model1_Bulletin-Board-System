<%@page import="dao.BbsDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
request.setCharacterEncoding("utf-8");

String id = request.getParameter("ansId");
int ref = Integer.parseInt(request.getParameter("ansRef"));
String title = request.getParameter("ansTitle");
String content = request.getParameter("ansContent");

BbsDao dao = BbsDao.getInstanse();
boolean b = dao.insertAns(id, ref, content, title);

if(b){
	%>      
    <script>
	alert("답글입력 성공!");
	location.href = "bbslist.jsp";
	</script>
	<%
}else{	
	%>
	<script>
	alert("답글입력 실패");
	location.href = "bbslist.jsp";
	</script>
	<%
}
%>