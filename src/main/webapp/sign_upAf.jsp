<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="dao.MemberDao" %>
<%@ page import="dto.MemberDto" %>


<%
String id = request.getParameter("new_id");
String password = request.getParameter("new_pw");
String name = request.getParameter("sign_name");
String mail = request.getParameter("sign_mail");
int auth = 3;

MemberDto dto = new MemberDto();
MemberDao dao = MemberDao.getInstance();

dto.setId(id);
dto.setPwd(password);
dto.setName(name);
dto.setEmail(mail);
dto.setAuth(auth);

boolean b = dao.addMember(dto);
out.print(b);
%>
