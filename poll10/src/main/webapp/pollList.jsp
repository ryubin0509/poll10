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
<!-- Latest compiled and minified CSS -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">

<!-- Latest compiled JavaScript -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

<title>pollList</title>
</head>
<body>
<h1> 투표리스트</h1>
<table class="table table-dark table-striped ">
<tr>
	<th>투표번호</th>
	<th>주제</th>
	<th>시작날짜</th>
	<th>마감날짜</th>
	<th>유형</th>
	<th>투표하기 </th>
	<th>삭제하기	</th>
	<th>	수정	</th>
	<th>마감날짜수정</th>
	<th>결과보기 </th>
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
		 
		 Item item = new Item();
		 ItemDao itemdao = new ItemDao();
		 
		 int qnum = (Integer) question.get("num");
		
		 System.out.println("qnum :"+ qnum);  // 정상출력
		 int count = itemdao.checkCount(qnum);
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
			<a href="/poll10/updateItemForm.jsp?qnum=<%=qnum%>">투표하기</a>
			<% }%>	  
		 </td>
	 <td>
	 <% 
	 		if(count == 0){		   //  투표한 카운트 수가 없다면 삭제가 가능하다.
	 %> 							
	  	  <a href="/poll10/deleteAction.jsp?qnum=<%=qnum%>">삭제</a>
	 <%
	 		}
	 %>			
	 </td>
	 <td>
 	 <% 
	 		if(count == 0){		   //  투표한 카운트 수가 없다면 설문지 수정이 가능하다.
	 %> 							
	  	  <a href="/poll10/updatePollForm.jsp?qnum=<%=qnum%>">수정</a>
	 <%
	 		}
	 %>	
	 </td>
	 <td> 
	 	<%if(now.isBefore(enddate1) || now.isEqual(enddate1)){%>
	 		<a href="/poll10/enddatePollForm.jsp?qnum=<%=qnum%>">마감날짜수정</a>
	 	<%  }%>
	 </td>
	 <td>
	 	<%if(now.isAfter(enddate1)){%>
	 		<a href="/poll10/resultItem.jsp?qnum=<%=qnum%>">결과보기</a>
	 	<% } %>
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