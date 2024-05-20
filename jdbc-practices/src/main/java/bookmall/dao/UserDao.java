package bookmall.dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import bookmall.vo.UserVo;
import bookshop.vo.AuthorVo;

public class UserDao {
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

	public int insert(UserVo vo) {
		int result = 0;
		
		try (
				Connection conn = getConnection();
				PreparedStatement pstmt1 = conn.prepareStatement("insert into user values(null, ?, ?, ?, ?)");
				PreparedStatement pstmt2 = conn.prepareStatement("select last_insert_id() from dual");
			) {
				// binding
				pstmt1.setString(1, vo.getName());
				pstmt1.setString(2, vo.getPhoneNumber());  
				pstmt1.setString(3, vo.getEmail()); 
				pstmt1.setString(4, vo.getPassword());
				result = pstmt1.executeUpdate();
				
				ResultSet rs = pstmt2.executeQuery();
				vo.setNo(rs.next() ? rs.getLong(1): null);
				rs.close();
			} catch (SQLException e) {
				System.out.println("error:" + e);
			}
			
		return result;
	}
		
		

//		public List<AuthorVo> findAll() {
//			List<AuthorVo> result = new ArrayList<>();
//		
//			try (
//				Connection conn = getConnection();
//				PreparedStatement pstmt = conn.prepareStatement("select no, name, phone_number, email, password from user order by no desc");
//				ResultSet rs = pstmt.executeQuery();
//			) {
//				while(rs.next()) {
//					Long no = rs.getLong(1);
//					String name = rs.getString(2);
//					
//					AuthorVo vo = new AuthorVo();
//					vo.setNo(no);
//					vo.setName(name);
//					
//					result.add(vo);
//				}
//				
//			} catch (SQLException e) {
//				System.out.println("error:" + e);
//			}
//			
//			
//			return result;
//		}
//	
	
	

	
//	public void insert(UserVo vo) {
//		Connection conn = null;
//		PreparedStatement pstmt = null;
//		
//		try {
//			//1. JDBC Driver 로딩
//			Class.forName("org.mariadb.jdbc.Driver");
//			
//			//2. 연결하기
//			String url = "jdbc:mariadb://192.168.0.202:3306/bookmall?charset=utf8";
//			conn = DriverManager.getConnection(url, "bookmall", "bookmall");
//
//			//3. Statement 준비
//			String sql = "insert into user values(null, ?, ?, ?, ?)";   
//			pstmt = conn.prepareStatement(sql);
//			
//			//4. binding
//			pstmt.setString(1, vo.getName());
//			pstmt.setString(2, vo.getPhoneNumber());  
//			pstmt.setString(3, vo.getEmail()); 
//			pstmt.setString(4, vo.getPassword());
//			
//			//5. SQL 실행
//			pstmt.executeUpdate();
//			
//		} catch (ClassNotFoundException e) {
//			System.out.println("드라이버 로딩 실패:" + e);
//		} catch (SQLException e) {
//			System.out.println("error:" + e);
//		} finally {
//			try {
//				if(pstmt != null) {
//					pstmt.close();
//				}
//				
//				if(conn != null) {
//					conn.close();
//				}
//			} catch (SQLException e) {
//				e.printStackTrace();
//			}
//		}
//	}
//
//	public List<UserVo> findAll() {
//		List<UserVo> result = new ArrayList<>();
//		
//		Connection conn = null;
//		PreparedStatement pstmt = null;
//		ResultSet rs = null;
//		
//		try {
//			//1. JDBC Driver 로딩
//			Class.forName("org.mariadb.jdbc.Driver");
//			
//			//2. 연결하기
//			String url = "jdbc:mariadb://192.168.0.202:3306/bookmall?charset=utf8";
//			conn = DriverManager.getConnection(url, "bookmall", "bookmall");
//
//			//3. Statement 준비
//			String sql =
//					"select no, name, phone_number, email, password from user order by no desc";
//			pstmt = conn.prepareStatement(sql);
//			
//			//5. SQL 실행
//			rs = pstmt.executeQuery();
//			
//			//6. 결과 처리
//			while(rs.next()) {
//				Long no = rs.getLong(1);
//				String name = rs.getString(2);
//				String phone_number = rs.getString(3);
//				String email = rs.getString(4);
//				String password = rs.getString(5);
//				
//				// vo를 생성 
//				UserVo vo = new UserVo(name, email, password, phone_number);
//				vo.setNo(no);
//				vo.setName(name);
//				vo.setPhoneNumber(phone_number);
//				vo.setEmail(email);
//				vo.setPassword(password);
//				System.out.println(no + name + ":" + phone_number + email + password);
//				// result add - DB에는 들어있는데 list는 없음
//				result.add(vo);
//				
//			}
//		} catch (ClassNotFoundException e) {
//			System.out.println("드라이버 로딩 실패:" + e);
//		} catch (SQLException e) {
//			System.out.println("error:" + e);
//		} finally {
//			try {
//				if(rs != null) {
//					rs.close();
//				}
//				
//				if(pstmt != null) {
//					pstmt.close();
//				}
//				
//				if(conn != null) {
//					conn.close();
//				}
//			} catch (SQLException e) {
//				e.printStackTrace();
//			}
//		}
//		return result;
//	}
	
	
}
