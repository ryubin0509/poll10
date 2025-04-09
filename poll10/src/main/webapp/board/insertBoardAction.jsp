<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "dto.*" %>
<%@ page import = "model.*" %>
<%
	 String name = request.getParameter("name");
	 String subject = request.getParameter("subject");
	 String content = request.getParameter("content");
	 String password = request.getParameter("password");
	 
	 String ip = request.getLocalAddr();
	
	 int ref = 0;
	
	 Board board = new Board( );
	 
	 board.setName(name);
	 board.setSubject(subject);
	 board.setContent(content);
	 board.setPass(password);
	 board.setIp(ip);
	 board.setRef(ref);
	 
	 BoardDao boardDao = new BoardDao();
	 
	 boardDao.insertBoard(board);
	 
	 response.sendRedirect("/poll10/board/boardList.jsp");
	 
	 
%>
