package model;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import dto.Board;
import dto.Paging;

public class BoardDao {

	public void  insertBoard(Board board ) throws ClassNotFoundException , SQLException{
		
		Class.forName("com.mysql.cj.jdbc.Driver");
		Connection conn = null;
		PreparedStatement stmt = null;	
		conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/pool", "root", "java1234");
		conn.setAutoCommit(false);
		ResultSet rs = null;
		String sql = "insert into board(name, subject, content, ref , pass, ip) values(?,?,?,?,?,?) ";	
		stmt = conn.prepareStatement(sql , stmt.RETURN_GENERATED_KEYS);
		stmt.setString(1, board.getName());
		stmt.setString(2, board.getSubject());
		stmt.setString(3, board.getContent());
		stmt.setInt(4, board.getRef());
		stmt.setString(5, board.getPass());
		stmt.setString(6, board.getIp());
		
		
		stmt.executeUpdate();
		int pk = 0 ;
		rs =  stmt.getGeneratedKeys();
		if (rs.next()) {
			pk= rs.getInt(1);
		}
		
		PreparedStatement stmt2 = null;	
		String sql2 = "update board set ref = ? where num = ?" ;
		stmt2 = conn.prepareStatement(sql2);
		stmt2.setInt(1, pk);
		stmt2.setInt(2, pk);
		
		stmt2.executeUpdate();
		
		conn.commit();
		conn.close();
	}
	
	public ArrayList<Board>selectBoardList (Paging p ) throws ClassNotFoundException , SQLException {  //  전체 BoardList 출력문 
		Class.forName("com.mysql.cj.jdbc.Driver");
		Connection conn = null;
		PreparedStatement stmt = null;	
		conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/pool", "root", "java1234");
		ResultSet rs = null;
		String sql = "select * from board order by ref desc  , pos   limit ? , ?";
		
		stmt = conn.prepareStatement(sql);
		
		stmt.setInt(1, p.getBeginRow());
		stmt.setInt(2, p.getRowPerPage());
		
		rs  = stmt.executeQuery();
		
		ArrayList<Board> list = new ArrayList<>();
		while(rs.next( )) {
		Board board = new Board ();
		board.setNum(rs.getInt("num"));
		board.setName(rs.getString("name"));
		board.setSubject(rs.getString("subject"));
		board.setPos(rs.getInt("pos"));	
		board.setRef(rs.getInt("ref"));	
		board.setDepth(rs.getInt("depth"));	
		board.setCount(rs.getInt("count"));	
		
		list.add(board);
		}
		conn.close();
		return list;
	}
	
	public Board  selectBoardOne( int num) throws ClassNotFoundException , SQLException  {
		Board b = new Board ( );
		
		Class.forName("com.mysql.cj.jdbc.Driver");
		Connection conn = null;
		PreparedStatement stmt = null;	
		conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/pool", "root", "java1234");
		ResultSet rs = null;
		String sql = "select * from board where num = ?" ;
		
		stmt = conn.prepareStatement(sql);
		stmt.setInt(1, num);
		
		rs = stmt.executeQuery();
		
		while(rs.next()) {
			
			b.setNum(rs.getInt("num"));
			b.setName(rs.getString("name"));
			b.setSubject(rs.getString("subject"));
			b.setContent(rs.getString("content"));
			b.setPos(rs.getInt("pos"));
			b.setRef(rs.getInt("ref"));
			b.setDepth(rs.getInt("depth"));
			
		 
		}
		conn.close();
		return b;
	}
	
	public void insertBoardReplay(Board b) throws ClassNotFoundException, SQLException{
		Class.forName("com.mysql.cj.jdbc.Driver");
		Connection conn = null;
		conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/pool", "root", "java1234");
		conn.setAutoCommit(false);
		PreparedStatement stmt = null;	
		
		String sql = "update Board set pos = pos +1 where ref = ? and pos >= ? " ;
		stmt = conn.prepareStatement(sql);
		stmt.setInt(1, b.getRef());
		stmt.setInt(2, b.getPos());
		
		stmt.executeUpdate(); 
		
		String sql2 = "insert into  board( name, subject, content, ref, pos, depth, pass, ip) values ( ? , ? , ? , ? , ? , ? , ? , ? ) " ; 
				
		PreparedStatement stmt2 = conn.prepareStatement(sql2);
		stmt2.setString(1, b.getName());
		stmt2.setString(2, b.getSubject());
		stmt2.setString(3, b.getContent());
		stmt2.setInt(4, b.getRef());
		stmt2.setInt(5, b.getPos());
		stmt2.setInt(6, b.getDepth());
		stmt2.setString(7, b.getPass());
		stmt2.setString(8, b.getIp());
		
		stmt2.executeUpdate();
		
		conn.commit();
		conn.close();
		
	}
	
	public void deleteboard(Board b )  throws ClassNotFoundException, SQLException {
		Class.forName("com.mysql.cj.jdbc.Driver");
		Connection conn = null;
		conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/pool", "root", "java1234");
		PreparedStatement stmt = null;	
		
		String sql = "delete from board where num = ? and pass = ? "; 
	}
}