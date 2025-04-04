<%@page import="java.time.LocalDate"%>
<%@page import="java.time.format.DateTimeFormatter"%>
<%@page import="java.time.LocalDateTime"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import =  "dto.* " %>
<%@ page import = "model.* " %>
<%@ page import = "java.util.* "%>
<% 
	int currentPage = 1;
	int rowPerPage = 5;
	
	if(request.getParameter("currentPage")!=null ){
	  currentPage = Integer.parseInt(request.getParameter("currentPage"));
	}
	
	Paging pg =  new Paging();
	pg.setCurrentPage(currentPage);
	pg.setRowPerPage(rowPerPage);
	
	QuestionDao  questionDao = new QuestionDao();

	int total = questionDao.questionTotalList(); 
	int lastPage = pg.getLastPage(total);
	int beginRow = pg.getBeginRow();

	ArrayList<HashMap<String, Object>> questionList =  questionDao.selectQuestion(pg);  // question 모음집
	LocalDate now = LocalDate.now();
	DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
	
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>pollList</title>
</head>
<body>
<h1> 투표리스트</h1>
<table border="1">
<tr>
	<th>투표번호</th>
	<th>주제</th>
	<th>시작날짜</th>
	<th>마감날짜</th>
	<th>유형</th>
	<th>투표하기 </th>
	<th>삭제하기	</th>
</tr>

<%
for( HashMap<String, Object> question : questionList) { 
%>
	<%
		  String startdate = (String) question.get("startdate");
		  String enddate = (String)  question.get("enddate");
		  
		  System.out.println("시작날짜"+startdate);
		  
		 LocalDate startdate1 = LocalDate.parse(startdate,formatter); 
		 LocalDate enddate1 =  LocalDate.parse(enddate,formatter);	
	%>
<tr> 
	<td><%=question.get("num")%></td>
	<td><%=question.get("title")%></td>
	<td><%=question.get("startdate")%>	</td>
	<td><%=question.get("enddate")%>	</td>
	<td><%=question.get("type")%>	</td>
	<td><%if(now.isBefore(startdate1)){ %>
			<a href="">투표시작전</a>
			<%}else if (now.isAfter(enddate1)){ %>
			<a href="">투표종료</a>
		   <%	}else { %>
			<a href="">투표중</a>
			<% }%>	  
		 </td>
</tr>
<%
} 
%>
</table>
<%if(currentPage > 1 ){ %>

<a href="/poll10/pollList.jsp?currentPage=<%=currentPage-1%>">이전</a>

<% } %>


<%
if(currentPage < lastPage){
%>
<a href="/poll10/pollList.jsp?currentPage=<%=currentPage+1%>">다음</a>

<%
}
%>
</body>
</html>