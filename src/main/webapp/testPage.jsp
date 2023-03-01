<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="dto.BbsDto" %>	
<%@ page import="dao.BbsDao" %>	
	
 
 <% 
 
 BbsDao dao = BbsDao.getInstanse();
 
 BbsDto dto = new BbsDto();
 
 //out.print(dao.getFromSeq(1).getTitle());
 out.print(dao.maxSeq());
 %>
 
 