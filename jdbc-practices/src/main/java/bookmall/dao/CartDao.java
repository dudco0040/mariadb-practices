package bookmall.dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import bookmall.vo.CartVo;
import bookmall.vo.UserVo;

public class CartDao {
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

	public void insert(CartVo vo) {
		try (
				Connection conn = getConnection();
				PreparedStatement pstmt = conn.prepareStatement("insert into cart(quantity, user_no, book_no) values(?, ?, ?)");
			) {
				// binding
				pstmt.setLong(1, vo.getQuantity());
				pstmt.setLong(2, vo.getUserNo());  
				pstmt.setLong(3, vo.getBookNo());
				pstmt.executeUpdate();
				
			} catch (SQLException e) {
				System.out.println("error:" + e);
			}
	}

	public void deleteByUserNoAndBookNo(Long userNo, Long no) {
		try(
				Connection conn = getConnection();
				PreparedStatement pstmt = conn.prepareStatement("delete from cart where book_no = ? and user_no = ?");

			) {
				// binding
				pstmt.setLong(1,no);
				pstmt.setLong(2, userNo);
				pstmt.executeUpdate();
			
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

	public List<CartVo> findByUserNo(Long no) {
		List<CartVo> result = new ArrayList<>();
		
		
		try(
				Connection conn = getConnection();
				PreparedStatement pstmt = conn.prepareStatement("select a.user_no, a.book_no, b.title, a.quantity from cart a, book b where a.book_no = b.no and user_no = ?");
				
			) {
				
				pstmt.setLong(1, no);
				ResultSet rs = pstmt.executeQuery();
				
			while(rs.next()) {
				Long user_no = rs.getLong(1);
				Long book_no = rs.getLong(2);
				String book_title = rs.getString(3);
				int quantity = rs.getInt(4);
				
				CartVo vo = new CartVo();
				vo.setUserNo(user_no);
				vo.setBookNo(book_no);
				vo.setBookTitle(book_title);
				vo.setQuantity(quantity);
				
				result.add(vo);
				System.out.println("find success: "+ user_no + book_no + quantity);
			}
			rs.close(); // 자동으로 close가 되지 않으니 닫아줘야한다.
			
			
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		return result;
	}
	
}
