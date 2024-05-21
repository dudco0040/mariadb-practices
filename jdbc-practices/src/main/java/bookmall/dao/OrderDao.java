package bookmall.dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

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
				pstmt.setLong(1, vo.getOrderNo());
				pstmt.setLong(2, vo.getBookNo());  
				pstmt.setInt(3, vo.getQuantity()); 
				pstmt.setInt(4, vo.getPrice());
				pstmt.executeUpdate();
				
			} catch (SQLException e) {
				System.out.println("error:" + e);
			}	
	}

	public void deleteBooksByNo(Long no) {
		try(
				Connection conn = getConnection();
				PreparedStatement pstmt = conn.prepareStatement("delete from order_book where order_no = ?");
		) {
			pstmt.setLong(1,no);
			pstmt.executeUpdate();

		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

	public void deleteByNo(Long no) {
		try(
				Connection conn = getConnection();
				PreparedStatement pstmt = conn.prepareStatement("delete from orders where no = ?");
		) {
			pstmt.setLong(1,no);
			pstmt.executeUpdate();

		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
	
	
	public OrderVo findByNoAndUserNo(Long get_no, Long get_userNo) {
	    OrderVo result = null;
	    Connection conn = null;
	    PreparedStatement pstmt = null;
	    ResultSet rs = null;

	    try {
	        conn = getConnection();
	        pstmt = conn.prepareStatement("SELECT no, number, status, payment, shipping, user_no FROM orders WHERE no = ? AND user_no = ?");
	        
	        // binding
	        pstmt.setLong(1, get_no);
	        pstmt.setLong(2, get_userNo);
	        
	        rs = pstmt.executeQuery();
	        
	        // Check if any result is returned
	        if (rs.next()) {
	            result = new OrderVo();
	            result.setNo(rs.getLong("no"));
	            result.setNumber(rs.getString("number"));
	            result.setStatus(rs.getString("status"));
	            result.setPayment(rs.getInt("payment"));
	            result.setShipping(rs.getString("shipping"));
	            result.setUserNo(rs.getLong("user_no"));
	        }
	    
	    } catch (SQLException e) {
	        e.printStackTrace();
	    } finally {
	        try {
	            if (rs != null) rs.close();
	            if (pstmt != null) pstmt.close();
	            if (conn != null) conn.close();
	        } catch (SQLException e) {
	            e.printStackTrace();
	        }
	    }

	    return result;
	}

	public List<OrderBookVo> findBooksByNoAndUserNo(Long get_no, Long get_userNo) {
		List<OrderBookVo> result = new ArrayList<>();
		
		try (
				Connection conn = getConnection();
				PreparedStatement pstmt = conn.prepareStatement("select b.book_no, a.user_no, b.order_no, b.quantity, b.price from orders a, order_book b where a.no = b.order_no and a.no = ? and a.user_no =? " );
				
				// title 값을 가져오려면 book no 값을 가지고 와야 함 -> book 테이블과도 조인이 필요
				// 조인했을때, sql 문에 오류가 있는 것으로 보임
				// 우선, OrderBookVo에 BookTitle 변수는 추가했고, sql 문이랑 이 코드의 ResultSet에 저장하는 부분만 변경하면 됨 
			){
				//binding
				pstmt.setLong(1, get_no);
				pstmt.setLong(2, get_userNo);
				ResultSet rs = pstmt.executeQuery();
				
				while(rs.next()) {
					Long book_no = rs.getLong(1);
					Long user_no = rs.getLong(2);
					Long order_no = rs.getLong(3); 
					int quantity = rs.getInt(4);
					int price  = rs.getInt(5);
					
					OrderBookVo vo = new OrderBookVo();
					vo.setBookNo(book_no);
					vo.setUserNo(user_no);
					vo.setOrderNo(order_no);
					vo.setQuantity(quantity);
					vo.setPrice(price);
					
					result.add(vo);
			
				}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		
		return result;
		
	}

	

	

	
	
	
//	public OrderVo findByNoAndUserNo(Long get_no, Long get_userNo) {
////		List<OrderVo> result = new ArrayList<>();
//		OrderVo vo = new OrderVo();
////		int result = 0;
//		
//		try(
//				Connection conn = getConnection();
//				PreparedStatement pstmt = conn.prepareStatement("select no, number, status, payment, shpping, user_no from oreders where no =? and user_no = ?");
//				
//			) {
//				pstmt.setLong(1, get_no);
//				pstmt.setLong(2, get_userNo);
//				ResultSet rs = pstmt.executeQuery();
//				
//				vo.setNo(rs.next() ? rs.getLong(1) : null);
//				vo.setNumber(rs.next() ? rs.getString(2) : null);
//				vo.setStatus(rs.next() ? rs.getString(3) : null);
//				vo.setPayment(rs.next() ? rs.getInt(4) : null);
//				vo.setShipping(rs.next() ? rs.getString(5) : null);
//			
//				
////				while(rs.next()) {
////					Long no = rs.getLong(1);
////					String number = rs.getString(2);
////					String status = rs.getString(3);
////					int payment = rs.getInt(4);
////					String shipping = rs.getString(5);
////					Long userNo = rs.getLong(6);
////					
////					OrderVo vo = new OrderVo();
////					vo.setNo(no);
////					vo.setNumber(number);
////					vo.setStatus(status);
////					vo.setPayment(payment);
////					vo.setShipping(shipping);
////					vo.setUserNo(userNo);
//				
////				result.add(vo);
//				System.out.println("find success: "); //+ user_no + book_no + quantity);
//			} catch (SQLException e) {
//				e.printStackTrace();
//			} 
//	
//		return vo;
//		
//	}
//		
}
