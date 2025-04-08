<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "dto.*" %>
<%@ page import = "model.*" %>
<%@ page import = "java.util.*" %>
<%
	 int qnum = Integer.parseInt(request.getParameter("qnum"));

	ArrayList<HashMap<String,Object>> selectQuestionOne = new ArrayList<HashMap<String,Object>>( );
	
	// 1) questionOne
	QuestionDao questionDao = new QuestionDao();
	selectQuestionOne =  questionDao.selectQuestionOne(qnum); // 선택된 question 행 실행
	


	
	// 2) 1의 itemList
	ItemDao itemDao = new ItemDao();
	ArrayList<Item> itemList = itemDao.selectItem(qnum);
	
	// 총 카운트 갯수
	int totalCount = itemDao.checkCount(qnum);
	
	 
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%	for( HashMap<String,Object> i : selectQuestionOne ){ %>
	<h1>총 <%=qnum %>번 설문 투표결과</h1>
	<table border = "1" width ="80%">
		<tr>
			<td colspan ="4">
				Q : <%=i.get("title")%>
			</td>
		</tr>
<%} %>
		<tr>
			<td colspan ="4">
				총투표수: <%=totalCount%>
			</td>
		</tr>
	
		<tr>
			<td>번호</td><td>내용</td><td>카운트(차트)</td><td>카운트</td>
		</tr>
		
		<% for(Item i : itemList){ %>
			<tr> 
				<td><%=i.getInum()%></td>
				<td><%=i.getContent()%></td>
				<td>						
						<%
							int percentage = (int)(Math.round((double)i.getCount() / (double)totalCount * 100));
							
							for(int n=1; n<=percentage; n=n+1) {
						%>
								*
						<%
							}
						%>
				</td>

				<td><%=i.getCount() %>	</td>
			</tr>
	
	
	
	
		<%} %>
	
	</table>
</body>
</html>