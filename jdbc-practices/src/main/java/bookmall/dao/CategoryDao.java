package bookmall.dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import bookmall.vo.CategoryVo;

public class CategoryDao {
	 
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
	
	public int insert(CategoryVo vo) {
		int result = 0;
		
		try (
				Connection conn = getConnection();
				PreparedStatement pstmt1 = conn.prepareStatement("insert into category(name) values(?)");
				PreparedStatement pstmt2 = conn.prepareStatement("select last_insert_id() from dual");
			) {
				// binding
				pstmt1.setString(1, vo.getName());
				result = pstmt1.executeUpdate();
				
				ResultSet rs = pstmt2.executeQuery();
				vo.setNo(rs.next() ? rs.getLong(1): null);
				rs.close();
			} catch (SQLException e) {
				System.out.println("error:" + e);
			}
			
		return result;
	}

	public List<CategoryVo> findAll() {
		List<CategoryVo> result = new ArrayList<>();
		
		try (
			Connection conn = getConnection();
			PreparedStatement pstmt = conn.prepareStatement("select no, name from category");
			ResultSet rs = pstmt.executeQuery();
		){
			while(rs.next()) {
				Long no = rs.getLong(1);
				String name = rs.getString(2);
				
				CategoryVo vo = new CategoryVo(name);
				vo.setName(name);
				
				result.add(vo);
				
				System.out.println(" find success:" + no + " "+ name );
				
			}
			
		} catch (SQLException e) {
					
			e.printStackTrace();
		}
		
		
		return result;
	}

	public void deleteByNo(Long no) {
		try(
				Connection conn = getConnection();
				PreparedStatement pstmt = conn.prepareStatement("delete from category where no = ?");
		) {
			pstmt.setLong(1,no);
			pstmt.executeUpdate();

		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

}
