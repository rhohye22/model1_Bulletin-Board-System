<%@page import="dao.CalendarDao"%>
<%@page import="dto.CalendarDto"%>
<%@page import="util.CalendarUtil"%>
<%@page import="java.util.Calendar"%>
<%@page import="dto.MemberDto"%>
<%@page import ="java.util.ArrayList"%>
<%@page import ="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	MemberDto login = (MemberDto)session.getAttribute("login");
	if(login == null){
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
	<h1>일정관리</h1>
	<a href="bbslist.jsp">게시판가기</a>&nbsp;&nbsp;&nbsp;<a href="loginout.jsp">로그아웃</a>
	<hr>
	<%
	Calendar cal = Calendar.getInstance();
	cal.set(Calendar.DATE, 1);
	

	//넘어온 파라미터
	String syear = request.getParameter("year");
	String smonth = request.getParameter("month");

	int year = cal.get(Calendar.YEAR);
	//넘어온 파라미터가 있을때
	if (syear != null && !syear.trim().equals("")) {
		year = Integer.parseInt(syear);

	}

	int month = cal.get(Calendar.MONTH)+1;// 0 ~ 11까지 이므로 +1을 해 줘야한다
	if (smonth != null && !smonth.trim().equals("")) {
		month = Integer.parseInt(smonth);
		if (month < 1) {
			month = 12 - month;
			year--;
		} else if (month > 12) {
			month = month - 12;
			year++;
		}
	}
	cal.set(year, month - 1, 1);//month 1월=0 ~ 12월=11

	String pp = String.format("<a href='calendar.jsp?year=%d&month=%d'>전년</a>", year - 1, month);
	String p = String.format("<a href='calendar.jsp?year=%d&month=%d'>전달</a>", year, month - 1);
	String n = String.format("<a href='calendar.jsp?year=%d&month=%d'>다음달</a>", year, month + 1);
	String nn = String.format("<a href='calendar.jsp?year=%d&month=%d'>다음해</a>", year + 1, month);

	//현재요일, 위에서1일로 설정해놓음
	//일요일 1 ~토요일 7
	int dayOfweek = cal.get(Calendar.DAY_OF_WEEK);
	%>





	<div align="center">
		<table border="1">
			<col width="120">
			<col width="120">
			<col width="120">
			<col width="120">
			<col width="120">
			<col width="120">
			<col width="120">

			<tr height="80">
				<td colspan="7" align="center"><%=pp%>&nbsp; <%=p%>&nbsp;&nbsp;
					<span><%=String.format("%d년&nbsp;%d월", year, month)%></span>&nbsp;&nbsp;
					<%=n%>&nbsp;&nbsp; <%=nn%>&nbsp;</td>
			</tr>

			<tr>
				<th>sun</th>
				<th>mon</th>
				<th>tus</th>
				<th>wed</th>
				<th>thu</th>
				<th>fri</th>
				<th>sat</th>
			</tr>

			<tr height="100" align="left" valign="top">
				<%
				for (int i = 1; i < dayOfweek; i++) {
				%>
				<td style="background-color: #eeeeee"></td>

				<%
				}
				//말일
				int lastday = cal.getActualMaximum(Calendar.DAY_OF_MONTH);
				for (int i = 1; i <= lastday; i++) {
				%>
				<td><%=i%>
				<a href="calwrite.jsp?year=<%= year %>&month=<%=month%>&day=<%=i%>">일정 등록</a>
				<div style="font-size: 10px;">
				
				<%
				//yyyymmdd
				String yyyymmdd = CalendarUtil.yyyymmdd(year, month, i);
				CalendarDao dao=CalendarDao.getInstance();
				List<CalendarDto> list = dao.getCalendarList(login.getId(), yyyymmdd);
				int len = list.size();
				for(int j =0;j<len;j++){
				%>
				<li><a href="caldetail.jsp?seq=<%=list.get(j).getSeq()%>"> <%=list.get(j).getTitle() %> </a></li>
				<%	
				}
				%>
							
				</div>
							
				</td>
				<%
				if ((i + dayOfweek - 1) % 7 == 0 && i != lastday) {
				%>
			</tr>
			<tr height="100" align="left" valign="top">
				<%
				}
				}

				// 아래쪽 빈칸
				cal.set(Calendar.DATE, lastday);
				int weekday = cal.get(Calendar.DAY_OF_WEEK);//일요일 1 ~토요일 7
				for (int i = 0; i < 7 - weekday; i++) {
				%>
				<td style="background-color: #eeeeee"></td>
				<%
				}
				%>
			</tr>
		</table>
	</div>


	<script type="text/javascript">
		
	</script>



</body>
</html>