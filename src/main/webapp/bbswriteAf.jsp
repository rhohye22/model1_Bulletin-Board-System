<%@page import="dao.BbsDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% 
request.setCharacterEncoding("utf-8");

String id  = request.getParameter("id");
String title  = request.getParameter("title");
String content  = request.getParameter("content");


BbsDao dao = BbsDao.getInstanse();
boolean b = dao.insertWrite(id, title, content);

%>

<script type="text/javascript">
alert("글 등록 성공");
location.href="bbslist.jsp";
</script> -->