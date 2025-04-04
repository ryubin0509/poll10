package model;


import java.sql.*;



import java.util.*;
import dto.Question;
import dto.Paging;
public class QuestionDao {
	
	public int questionTotalList() throws ClassNotFoundException, SQLException {	// 전체 출력 메소드
																											
		int total = 0;   
		String sql = "select count(*) from question";
		Class.forName("com.mysql.cj.jdbc.Driver");
		Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/pool", "root", "java1234"); 
		PreparedStatement stmt = conn.prepareStatement(sql);
		ResultSet rs = stmt.executeQuery();
		if(rs.next()) {
			total =   rs.getInt("count(*)"); 
		}
		
		
		return  total;
		
	}
	
	
	// 쿼리 생성과 추출을 한번에 한다.

	
	public  int  insertQuestion(Question question) throws ClassNotFoundException, SQLException {
		String sql = "insert into question(title, startdate, enddate, type) values(?,?,?,?)";
		int pk= 0;
		Class.forName("com.mysql.cj.jdbc.Driver");
		Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/pool", "root", "java1234"); 
		PreparedStatement stmt  = conn.prepareStatement(sql , Statement.RETURN_GENERATED_KEYS);
		stmt.setString(1,question.getTitle());
		stmt.setString(2,question.getStartdate());
		stmt.setString(3,question.getEnddate());
		stmt.setInt(4,question.getType());
		
		stmt.executeUpdate();
		
		ResultSet rs = 	stmt.getGeneratedKeys(); //  번호 키의 맥스 값을 받기 위해 Resultset 사용 
		if(rs.next()) {
			 pk = rs.getInt(1);
			
		}
		conn.close();	// 쿼리의 number 를 가져와야 한다. 
		return pk;
		
	}
	
	public  ArrayList<HashMap<String,Object>>selectQuestion(Paging p) throws ClassNotFoundException ,SQLException{
		ArrayList<HashMap<String,Object>> map = new ArrayList<HashMap<String,Object>>( );
		Class.forName("com.mysql.cj.jdbc.Driver");
		Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/pool", "root", "java1234"); 
		String sql =  "SELECT"
					  + " num,"
					  + " title,"
					  + " startdate AS startDate,"
					  + " enddate AS endDate,"
					  + " createdate AS createDate,"
					  + " type"
					  + " FROM question"
					  + " ORDER BY num DESC"
					  + " LIMIT ?,?";
		PreparedStatement stmt = conn.prepareStatement(sql); 
		stmt.setInt(1, p.getBeginRow());
		stmt.setInt(2, p.getRowPerPage());
	
		ResultSet rs = stmt.executeQuery();
		
		while(rs.next()) {
			HashMap<String,Object> m = new HashMap<>();
			m.put("num", rs.getInt("num"));
			m.put("title",  rs.getString("title"));
			m.put("startdate", rs.getString("startdate"));
			m.put("enddate", rs.getString("enddate"));
			m.put("createdate", rs.getString("createDate"));
			m.put("type",rs.getInt("type"));
			
			map.add(m);
		}
		
		return map; 
	}
		


	
	
	
	
	

	
}