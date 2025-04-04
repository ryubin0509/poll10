<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="model.*"  %>

<%
 		int qnum =	Integer.parseInt(request.getParameter("qnum"));
		
		ItemDao itemDao = new ItemDao();
		itemDao.deleteItem(qnum); // item 삭제
		QuestionDao questionDao = new QuestionDao();
		questionDao.deleteQuestion(qnum);
		
		response.sendRedirect("/poll10/pollList.jsp");

		
%>
