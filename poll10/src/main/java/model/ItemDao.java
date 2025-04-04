package model;

import java.util.ArrayList;
import dto.Item;
import java.sql.*;

public class ItemDao {
		public  void  insertItem(Item item) throws  ClassNotFoundException  ,SQLException {  // 아이템 개수만큼 삽입 
			 
		Class.forName("com.mysql.cj.jdbc.Driver");
		Connection conn = null;
		PreparedStatement stmt = null;	
		conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/pool", "root", "java1234");
		String sql = "insert into item(qnum, inum, content) values(?,?,?)";	
		stmt = conn.prepareStatement(sql);
		stmt.setInt(1,item.getQnum());
		stmt.setInt(2,item.getInum());
		stmt.setString(3,item.getContent());
		
		int row = stmt.executeUpdate();
		
		if(row ==1) {
			System.out.println("입력성공");
		} else {
			System.out.println("입력실패 또는 오류");
		}
		conn.close();
	}
		
	  public int  checkCount(int qnum) throws ClassNotFoundException, SQLException {  //  item 에 총 투표 갯수를 호출하는 함수
		  int count = 0;
		  Class.forName("com.mysql.cj.jdbc.Driver");
		  Connection conn = null;
		  PreparedStatement stmt = null;	
		  ResultSet rs = null;
		  conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/pool", "root", "java1234");
		  String sql = " SELECT t.qnum , t.totalcount FROM question q  INNER JOIN "  
				  		+ " (SELECT i.qnum , SUM(COUNT) totalcount  FROM item i GROUP BY i.qnum)t " 
				  		+ " ON  q.num = t.qnum " 
				  		+ " WHERE qnum = ? " ; 
		  stmt = conn.prepareStatement(sql);
		  stmt.setInt(1, qnum);
		  rs = stmt.executeQuery();
		  if(rs.next()) {
			  count = rs.getInt("totalcount");
		  }
		  
		  conn.close();
		  return count; 
	  }
	  
	  
	  public void  deleteItem(int qnum) throws ClassNotFoundException, SQLException{  // question Number에 해당하는 item 삭제
		  
		  Class.forName("com.mysql.cj.jdbc.Driver");
		  Connection conn = null;
		  PreparedStatement stmt = null;
		  conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/pool", "root", "java1234");
		  String sql = "delete from item where qnum = ? ";
		  stmt= conn.prepareStatement(sql);
		  stmt.setInt(1,qnum);
		  
		  stmt.executeUpdate();
	  }
	  
	  public ArrayList<Item> selectItem(int qnum) throws ClassNotFoundException, SQLException{ // question Number에 해당하는 item 출력 
		  ArrayList<Item> itemList = new ArrayList<Item>();
		  Class.forName("com.mysql.cj.jdbc.Driver");
		  Connection conn = null;
		  conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/pool", "root", "java1234");
		  PreparedStatement stmt = null;
		  ResultSet rs = null;
		  String sql 	= " SELECT "
				  		+ " qnum, "
				  		+ " inum, "
				  		+ " content, "
				  		+ " count "
				  		+ " FROM item "
				  		+ " where qnum = ? ";
		  stmt = conn.prepareStatement(sql);
		  stmt.setInt(1, qnum);
		  rs = stmt.executeQuery();
		  
		  while(rs.next()) {
			  Item item = new Item();
			  item.setQnum(rs.getInt("qnum"));
			  item.setInum(rs.getInt("inum"));
			  item.setContent(rs.getString("content"));
			  item.setCount(rs.getInt("count"));
			  
			  itemList.add(item);
			  
		  }
		  
		  return itemList;
		  
	  }
	  
	  public void updateItem(int qnum, int  inum) throws ClassNotFoundException, SQLException  {
		  Class.forName("com.mysql.cj.jdbc.Driver");
		  Connection conn = null;
		  PreparedStatement stmt = null;
		  conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/pool", "root", "java1234");
		  String sql = " UPDATE item "
		  				+ " SET `count` = `count`+1 "
		  				+ "WHERE qnum = ? AND inum = ? " ;
		  stmt = conn.prepareStatement(sql);
		  stmt.setInt(1 , qnum);
		  stmt.setInt(2 , inum);
		  
		  stmt.executeUpdate();
	  }
	  
	  
}
