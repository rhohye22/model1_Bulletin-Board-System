<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="dao.MemberDao" %>

<% 
String id = request.getParameter("new_id");

System.out.println("new_id:" + id); 

MemberDao dao = MemberDao.getInstance();
boolean b = dao.serchId(id);

if(b == true){	// id 있음
	out.println("NO");
}else{
	out.println("YES");
}

%>