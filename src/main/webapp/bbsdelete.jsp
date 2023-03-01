
<%@page import="dto.MemberDto"%>
<%@page import="dto.BbsDto"%>
<%@page import="dao.BbsDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
MemberDto login = (MemberDto) session.getAttribute("login");

request.setCharacterEncoding("utf-8");
int seq = Integer.parseInt(request.getParameter("seq"));

BbsDao dao = BbsDao.getInstanse();
BbsDto dto = dao.getBbs(seq);

String id = dto.getId();

if (login.getId().equals(id)) {

	boolean b = dao.delete(seq);

	if (b) {
%>
<script>
	alert("삭제 성공");
	location.href = "bbslist.jsp";
</script>
<%
} else {
%>
<script>
	alert("삭제 실패");
	location.href = "bbslist.jsp";
</script>
<%
}

} else {
%>
<script>
	alert("글작성자만 삭제가능합니다");
	location.href = "bbsdetail.jsp?seq=<%=seq%>";
</script>
<%
}
%>
