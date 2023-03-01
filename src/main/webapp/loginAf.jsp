<%@ page import="dao.MemberDao"%>
<%@page import="dto.MemberDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>



<%
String id = request.getParameter("id");
String pwd = request.getParameter("pwd");

MemberDao dao = MemberDao.getInstance();

MemberDto mem = dao.login(id, pwd);

if (mem != null) {//로그인이 되어 mee객체가 생성되었을때

			session.setAttribute("login", mem);//로그인에 사용된 정보로 세션을 만들어라
			//session.setMaxInactiveInterval(10);시간 정할 수 있음, 기본이 30분0
	
			%>
			<script type="text/javascript">
			alert("환영합니다. <%=mem.getId()%>님");
			location.href = "./bbslist.jsp";
			</script>
			<%
	} else {
			%>
			<script type="text/javascript">
			alert("아이디나 패스워드를 확인하십시오");
			location.href = "login.jsp";
			</script>
			<%
	}
	%>


