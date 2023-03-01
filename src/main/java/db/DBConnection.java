package db;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBConnection {

	// 드라이버 로드
	public static void loadDBDriver() {
		
		try {// 이 이름의 드라이버 클래스가 있다면 로딩성공
			Class.forName("com.mysql.jdbc.Driver");
			System.out.println("Driver Loading Success ");

		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		}

	}

	//드라이버 연결
	public static Connection getConnection() {
		
		Connection conn = null;
		
		try {//
			conn = DriverManager.getConnection( "jdbc:mysql://localhost:3306/mydb", "root", "1234");
			System.out.println("DB Connection Success");
			return conn;
		} catch (SQLException e) {
			System.out.println(" DB Connection Fail");
			e.printStackTrace();
		}
		return conn;
	}
	
	
	
	
}
