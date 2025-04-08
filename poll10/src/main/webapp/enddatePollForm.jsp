<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import ="java.time.LocalDate" %>
<%
	int qnum = Integer.parseInt(request.getParameter("qnum")); 
	LocalDate now  =  LocalDate.now();
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>마감날짜 수정하기</title>
</head>
<body>
<form action="/poll10/enddatePollAction.jsp?qnum=<%=qnum%>" method="post">
<table border = "1">

<tr>	
<th>마감날짜 </th>
</tr>

<tr>
<td><input type ="date" name ="enddate" min =<%=now%>></td>
</tr>



</table>
<button type="submit">마감날짜 변경하기</button>
</form>
</body>
</html>