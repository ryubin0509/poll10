<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import ="model.*" %>
<%@ page import ="dto.*" %>
<%
  	int num = 	Integer.parseInt(request.getParameter("num"));
	BoardDao boardDao = new BoardDao( );
	
 	Board board = boardDao.selectBoardOne(num);
	
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>
</head>
<body>
<form action="/poll10/board/deleteBoardAction.jsp?num=<%=num%>" method = "post">
 <ul>   
 		<li>글번호:  <%=board.getNum()%> </li>
 		<li>제목:  <%=board.getContent()%> </li>
 		<li>작성자: <%=board.getName()%> </li>
 </ul>
<input type="password" name ="pass"> 비밀번호 입력

<button type="submit">삭제하기</button>
</form>
</body>
</html>