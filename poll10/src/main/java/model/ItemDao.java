package model;

import java.util.ArrayList;
import dto.Item;
import java.sql.*;

public class ItemDao {
		public  void  insertItem(Item item) throws  ClassNotFoundException  ,SQLException {
			 
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
}
