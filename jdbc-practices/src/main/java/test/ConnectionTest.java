package test;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class ConnectionTest {

	public static void main(String[] args) {
		Connection connection = null;
		
		try {
			// 1. JBDC Driver 로딩
			Class.forName("org.mariadb.jbdc.Driver");
			
			// 2. 연결하기 
			String url = "jdbc:mariadb://192.168.0.202:3306/webdb?charget=utf8";   // 서버 주소, 포트, 스키마
			connection = DriverManager.getConnection(url, "webdb", "webdb");
			
			System.out.println("success!!");
		} catch (ClassNotFoundException e) {
			System.out.println("드라이버 로딩 실패:"+e);
			
		} catch (SQLException e) {
			System.out.println("error! "+e);
		} finally {
			
			try {
				if(connection != null) {
					connection.close();
				}
			} catch (SQLException e) {
				e.printStackTrace();
		
			}
			
		}

	}

}
