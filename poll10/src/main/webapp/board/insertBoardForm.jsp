<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
	<!-- Latest compiled and minified CSS -->
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
	
	<!-- Latest compiled JavaScript -->
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<title>insertBoardForm.jsp</title>
</head>
<body>
<form action="/poll10/board/insertBoardAction.jsp"  method="post">
<table class="table table-striped" >

  <h1>  게시판 입력 </h1>
 
	<tr>	
		<th>	이름	</th>
		<td> <input type="text" name="name" >	</td>
	</tr>
	
	<tr>
		<th>	주제 </th>
		<td>	<input type="text"  name ="subject"> </td>
	</tr>
	
	<tr>
		<th>	콘텐츠</th>
		<td><textarea rows="5" cols="20" name="content">   </textarea></td>
	</tr>
	
	<tr>
		<th>	비밀번호</th>
		<td> <input type="password" name="password"> </td>
	</tr>
	
	
</table>
<button type="submit">작성하기</button>
</form>
</body>
</html>