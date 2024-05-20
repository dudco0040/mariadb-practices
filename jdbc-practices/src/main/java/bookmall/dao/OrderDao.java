package bookmall.dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import bookmall.vo.OrderBookVo;
import bookmall.vo.OrderVo;

public class OrderDao {
	private static Connection getConnection() throws SQLException{
		Connection conn = null;
		
		try {
			Class.forName("org.mariadb.jdbc.Driver");
			
			String url = "jdbc:mariadb://192.168.0.202:3306/bookmall?charset=utf8";
			conn = DriverManager.getConnection(url, "bookmall", "bookmall");
			
		} catch (ClassNotFoundException e) {
			System.out.println("드라이버 로딩 실패: " + e);
		}
		
		return conn;
		
	}
	
	public int insert(OrderVo vo) {
		int result = 0;
		
		try (
				Connection conn = getConnection();
				PreparedStatement pstmt1 = conn.prepareStatement("insert into orders(number, status, payment, shipping, user_no) values(?, ?, ?, ?, ?)");
				PreparedStatement pstmt2 = conn.prepareStatement("select last_insert_id() from dual");
			) {
				// binding
				pstmt1.setString(1, vo.getNumber());
				pstmt1.setString(2, vo.getStatus());  
				pstmt1.setInt(3, vo.getPayment()); 
				pstmt1.setString(4, vo.getShipping());
				pstmt1.setLong(5, vo.getUserNo());
				result = pstmt1.executeUpdate();
				
				ResultSet rs = pstmt2.executeQuery();
				vo.setNo(rs.next() ? rs.getLong(1): null);
				rs.close();
			} catch (SQLException e) {
				System.out.println("error:" + e);
			}
			
		return result;
		
	}

	public void insertBook(OrderBookVo vo) {
		
		try (
				Connection conn = getConnection();
				PreparedStatement pstmt = conn.prepareStatement("insert into order_book(order_no, book_no, quantity, price) values(?, ?, ?, ?)");
			) {
				// binding
				pstmt.setString(1, vo.getOrderNo());
				pstmt.setLong(2, vo.getBookNo());  
				pstmt.setInt(3, vo.getQuantity()); 
				pstmt.setInt(4, vo.getPrice());
				pstmt.executeUpdate();
				
			} catch (SQLException e) {
				System.out.println("error:" + e);
			}	
	}
		
}
