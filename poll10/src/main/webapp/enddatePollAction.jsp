<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dto.*" %>
<%@ page import="model.*" %>
<%
	int qnum = Integer.parseInt(request.getParameter("qnum")); 
	String enddate = request.getParameter("enddate");
	
	Question question  = new Question();
	question.setEnddate(enddate); 
	question.setNum(qnum);
	
	QuestionDao questionDao = new QuestionDao( );
	questionDao. updateEnddateQuestion(question);
	
	response.sendRedirect("/poll10/pollList.jsp");
	
%>
