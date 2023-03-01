<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="dto.MemberDto"%>
<%
MemberDto login = (MemberDto) session.getAttribute("login");

session.removeAttribute("login");

response.sendRedirect("./index.jsp");

%>