<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="dto.MemberDto"%>

<%
MemberDto login = (MemberDto) session.getAttribute("login");
if (login == null) {
%>
<script>
	alert('로그인 해 주십시오');
	location.href = "login.jsp";
</script>
<%
}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<% 
String sseq = request.getParameter("seq");
int seq = Integer.parseInt(sseq);

%>
	<h1>글 수정하기</h1>

	<div align="center">

		<form action="bbsupdateAf.jsp"  method="get">

			<table border="1">
				<col width="200">
				<col width="400">

				<tr>
					<th>아이디</th>
					<td>
						<%-- <input type="text" name="id" size="50px" value="<%=login.getId() %>" readonly="readonly"> --%>

						<%=login.getId()%> 
						<input type="hidden" name="seq" value="<%=seq%>">
					</td>
				</tr>
				<tr>
					<th>제목</th>
					<td><input type="text" id="title" name="title" size="50px"
						placeholder="제목기입"></td>
				</tr>
				<tr>
					<th>내용</th>
					<td><textarea rows="20" cols="50px" id="content"
							name="content" placeholder="내용기입"></textarea></td>
				</tr>
				<tr>
					<td colspan="2">
						<!-- <input type="submit" value="글쓰기"> -->
						<input type="submit" value="수정완료">
					</td>
				</tr>

			</table>
		</form>
	</div>

</body>
</html>