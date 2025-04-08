<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import ="dto.*" %>
<%@ page import = "model.*" %>
<%@ page import ="java.sql.*"%>
<%@ page import = "java.util.*" %>
<%
	String title = request.getParameter("title");
	String[] content = request.getParameterValues("content");
	String startdate = request.getParameter("startdate");
	String enddate = request.getParameter("enddate");
	int type =Integer.parseInt(request.getParameter("type")); 
	int qnum = Integer.parseInt(request.getParameter("qnum"));
	
	ArrayList<String>contentList = new ArrayList<>();
	ArrayList<Item>itemList = new ArrayList<>( );  // item을 담을 list 생성 
	 
	for (String s : content){ 
		if(!s.equals(" ")){
			contentList.add(s);
		}
	}
	

	int inum = 1;
	
	for (String s1 :contentList){
		Item i = new Item();
		
		i.setQnum(qnum);
		i.setInum(inum);
		i.setContent(s1);
		i.setCount(0);
		
		itemList.add(i);
		inum++;
	}
	
	ItemDao itemDao = new ItemDao();
	itemDao.deleteItem(qnum);  // qnum 에 맞는 item 삭제
	
	Question question = new Question();
	
	question.setTitle(title);
	question.setStartdate(startdate);
	question.setEnddate(enddate);
	question.setType(type);
	question.setNum(qnum);  // question 클래스의 값 설정 완료
	
	QuestionDao questionDao = new QuestionDao();
	
	questionDao.updateQuestion(question); // question 정보 업데이트 
	
	for(Item item : itemList){
		ItemDao  item1 = new ItemDao();
	    item1.insertItem(item);
	}   // 다시 삽입 정보를 
	
	response.sendRedirect("/poll10/pollList.jsp");
%>