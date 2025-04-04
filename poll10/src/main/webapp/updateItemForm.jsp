<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dto.*" %>
<%@ page import="model.*" %>
<%@ page import="java.util.*" %>
<%
	// ?번 문제와 item 들을 출력한다.
	//  type = 1 은  checkbox 
	// type = 0 은  radio
	
	int  qnum = Integer.parseInt(request.getParameter("qnum"));
	QuestionDao questionDao = new QuestionDao();
	ArrayList<HashMap<String,Object>>list  =  questionDao.selectQuestionOne(qnum); // question 출력
	ItemDao itemDao = new ItemDao();
	ArrayList<Item>itemList = itemDao.selectItem(qnum); // questionnum 에 맞는 item 출력
	
%>


<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>updateItemForm</title>
</head>
<body>
<form action="/poll10/updateItemAction.jsp?qnum=<%=qnum%>" method="post">
	<table border = "1"> 
	<%
	for(HashMap<String,Object> map : list){
	   int  type = (Integer)map.get("type"); 
	%>
	 <tr>		
	 	<th><%=map.get("title")%></th>
	 </tr>
<tr>
	<%
	for(Item item: itemList){
	%>
	
	
	
		<td>
		<%
		if(type==0){
		%>
		<input type="radio"  name ="inum"  value="<%=item.getInum()%>">
		<%
		} else if(type ==1){
		%>
		<input type= "checkbox" name="inum" value="<%=item.getInum()%>">
		<%
		}
		%>
		<%=item.getContent()%>
		</td>
	<%
		}
	%>
	</tr>
		<%
	}
	%>
	</table>
	<button type="submit">투표하기</button>
</form>
</body>
</html>