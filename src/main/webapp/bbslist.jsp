<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="dto.BbsDto"%>
<%@ page import="dao.BbsDao"%>
<%@page import="dto.MemberDto"%>


<%
//로그인 세션 유지
MemberDto login = (MemberDto) session.getAttribute("login");
if (login == null) { //기본 30분이 만료되면 null이됨
%>
<script type="text/javascript">

	alert("로그인 해주세요");
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

<!-- jQuery CDN -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
<!-- CSS only -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-rbsA2VBKQhggwzxH7pPCaAqO46MgnOM80zW1RWuH61DGLwZJEdK2Kadq2F9CUG65" crossorigin="anonymous"><script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0/dist/js/bootstrap.bundle.min.js" integrity="sha384-A3rJD856KowSb7dwlZdYEkO39Gagi7vIsF0jrRAoQmDKKtQBHUuLZ9AsSv4jD4Xa" crossorigin="anonymous"></script>
<!-- JavaScript Bundle with Popper -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-kenU1KFdBIe4zVF0s0G1M5b4hcpxyD9F7jL+jjXkk+Q2h455rYXK/7HAuoJl+0I4" crossorigin="anonymous"></script>
</head>
<body  bgcolor="#e9e9e9">

	<%
	BbsDao dao = BbsDao.getInstanse();

	//검색
	String choice = request.getParameter("choice");
	String search = request.getParameter("search");

	if (choice == null) {
		choice = "";
	}
	if (search == null) {
		search = "";
	}
//페이지 넘버
	String sPageNumber = request.getParameter("pageNumber");
	int pageNumber = 0;
	if (sPageNumber != null && !sPageNumber.equals("")) {
		pageNumber = Integer.parseInt(sPageNumber);
	}
	//글목록 리스트
	//List <BbsDto> list=dao.getBbsList();
	//List<BbsDto> list = dao.getBbsSearchList(choice, search);
	List<BbsDto> list = dao.getBbsPageList(choice, search, pageNumber);
	
	//게시글 총 수
	int count = dao.getBbsSearchList("", "").size();

	//페이지의 총수
	int pageBbs = count / 10;
	if (pageBbs > 0) {
		pageBbs += 1;
	}

	
	%>

	<%!// 답글의 화살표 함수
	public String arrow(int depth) {
		String img = "<img src='./images/arrow.png' width='20px' height='20px' />";
		String nbsp = "&nbsp;&nbsp;&nbsp;&nbsp;";

		String ts = "";
		for (int i = 0; i < depth; i++) {
			ts += nbsp;
		}

		return depth == 0 ? "" : ts + img;
	}%>


	<!--  Bulletin Board System 게시판 -->

	<h1>게시판</h1>

	<a href="calendar.jsp">일정관리</a>&nbsp;&nbsp;&nbsp;<a href="loginout.jsp">로그아웃</a>
	<hr>
	<div align="center">
		<table  class="table table-striped table-bordered" style="width: 1000px">
			<col>
			<tr>
				<th width="50">번호</th>
				<th width="300">제목</th>
				<th width="50">조회수</th>
				<th width="50">작성자</th>
			</tr>

			<%
			if (list.size() == 0 || list == null) {
			%>
			<tr>
				<td colspan="4">작성된 글이 없습니다</td>
			</tr>
			<%
			} else {
			for (int i = 0; i < list.size(); i++) {
				BbsDto dto = list.get(i);
			%>
			<tr>
				<th><%=i + 1%> <input type="hidden" class="seq" id="seq<%=i%>"
					value="<%=dto.getSeq()%>"></th>


				<%
				if (dto.getDel() == 0) {
				%>
				<td><%=arrow(dto.getDepth())%> <a
					href="bbsdetail.jsp?seq=<%=dto.getSeq()%>"><%=dto.getTitle()%></a>
				</td>
				<%
				} else if (dto.getDel() == 1) {
				%>
				<td><%=arrow(dto.getDepth())%> **삭제된 게시글입니다</td>
				<%
				}
				%>


				<td><%=dto.getReadcount()%></td>
				<td><%=dto.getId()%></td>

			</tr>
			<%
			}
			}
			%>
		</table>


		<%

		for(int i = 0;i < pageBbs; i++){
			if(pageNumber == i){	// 현재 페이지
				%>
				<span style="font-size: 15pt;color: #0000ff;font-weight: bold;">
					<%=i+1 %>
				</span>
				<%
			}else{					// 그밖에 다른 페이지
				%>
				<a href="#none" title="<%=i+1 %>페이지" onclick="goPage(<%=i %>)"
					style="font-size: 15pt; color: #000; font-weight: bold; text-decoration: none;">
					[<%=i+1 %>]
				</a>			
				<%
			}		
		}
		%>

		<br> <select id="choice">
			<option value="">검색</option>
			<option value="title">제목</option>
			<option value="content">내용</option>
			<option value="writer">작성자</option>
		</select> <input type="text" id="search">
		<button id="searchBtn" onclick="searchBtn()">검색</button>
		<br> <br> <a href="bbswrite.jsp">글쓰기</a>
	</div>

	<script type="text/javascript">

function searchBtn() {
	let choice = document.getElementById("choice").value;
	let search = document.getElementById("search").value;
	
	location.href="bbslist.jsp?choice="+choice+"&search="+search;
}

function goPage( pageNumber ) {
	let choice = document.getElementById('choice').value;
	let search = document.getElementById('search').value;
	
	location.href = "bbslist.jsp?choice=" + choice + "&search=" + search + "&pageNumber=" + pageNumber;	
}


</script>

</body>
</html>