<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="model.*" %>
<% 
	// 선택받은 item 의 카운트를 올려주어야한다.
	String[] inum1 =  request.getParameterValues("inum");
	int  qnum = Integer.parseInt(request.getParameter("qnum"));

	ItemDao itemDao = new ItemDao();
	
	for (String i :  inum1){
	int inum =  Integer.parseInt(i);
	itemDao.updateItem( qnum, inum);
	}
	
	response.sendRedirect("/poll10/pollList.jsp");

%>
