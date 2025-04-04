<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dto.*" %> 
<%@ page import="model.*" %>
<%@ page import="java.util.*" %>

<%
		String title = request.getParameter("title");
		String startDate = request.getParameter("startdate");
		String endDate = request.getParameter("enddate");
		Integer type  = Integer.parseInt(request.getParameter("type"));
		
		String[] content = request.getParameterValues("content");		
	
		ArrayList<String> contentList =  new ArrayList<>();
		for(String s : content){
			if(!content.equals("")){
				contentList.add(s);
			}
		}

		Question question = new Question( );
		question.setTitle(title);
		question.setStartdate(startDate);
		question.setEnddate(endDate);
		question.setType(type);  
		
		// Question이 외래키로 설정되어 있기 때문에 Question model 부터 먼저 구한다. 
		
		QuestionDao  questionDao  = new QuestionDao();
		int qnum = questionDao.insertQuestion(question);  //  question의 정보를 insert 하고 , 생성번호 foreign key 를 받아왔다.
		
		ArrayList <Item> itemList = new ArrayList<>();
		int i = 1;
		for(String c  : contentList){
			Item item = new Item();
			item.setContent(c);
			item.setQnum(qnum);
			item.setInum(i);
			itemList.add(item);
			
			i++;   // 설문 한개의 값을 처리하는거기 때문에 qnum의 값은 고정
		} 
		
		
		
		for(Item item : itemList){
			ItemDao itemDao = new ItemDao();
		    itemDao. insertItem(item);
		}
		
			
		response.sendRedirect("/poll10/pollList.jsp") ;
			
		
		
 		
%>