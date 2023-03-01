package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import db.DBClose;
import db.DBConnection;
import dto.CalendarDto;

public class CalendarDao {

	private static CalendarDao dao = null;
	
	private CalendarDao() {
		DBConnection.loadDBDriver();
	}
	
	public static CalendarDao getInstance() {
		if(dao == null) {
			dao = new CalendarDao();
		}
		return dao;
	}
	public boolean addCalendar(CalendarDto dto) {
		String sql ="INSERT INTO calendar(id, title, content, rdate,wdate) VALUES(?,?,?,?, now());";
		
		Connection conn = null;
		PreparedStatement psmt = null;
		
		int count = 0;
		try {
			conn = DBConnection.getConnection();
			System.err.println("addCalendar process sucsess(1/3");
			psmt = conn.prepareStatement(sql);
			psmt.setString(1, dto.getId());
			psmt.setString(2, dto.getTitle());
			psmt.setString(3, dto.getContent());
			psmt.setString(4, dto.getRdate());
			System.err.println("addCalendar process sucsess(2/3");

			count = psmt.executeUpdate();
			System.out.println("addCalendar process sucsess(3/3)");
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			DBClose.close(conn, psmt, null);
		}
		return count>0?true:false;
		
		
	}
	
	// 해당일자 일정 가져오기
	
	public List<CalendarDto> getCalendarList(String id, String yyyymmdd){
		
		String sql ="SELECT * FROM calendar WHERE id = ? and rdate LIKE ? ORDER BY rdate asc;";
		

		Connection conn = null;
		PreparedStatement psmt = null;
		ResultSet rs = null;
		
		List<CalendarDto> list = new ArrayList<CalendarDto>();
		CalendarDto dto = null;
		
		try {
			conn= DBConnection.getConnection();
			System.out.println("1/3 getCalendarList success");
			
			psmt = conn.prepareStatement(sql);
		
			psmt.setString(1, id);
			psmt.setString(2, yyyymmdd+"%");
			System.out.println("2/3 getCalendarList success");
			
			rs = psmt.executeQuery();
			System.out.println("3/3 getCalendarList success");
			while (rs.next()) {
				int _seq = rs.getInt(1);
				String _id = rs.getString(2);
				String _title = rs.getString(3);
				String _content = rs.getString(4);
				String _rdate = rs.getString(5);
				String _wdate = rs.getString(6);
				
				dto = new CalendarDto(_seq,  _id,  _title,  _content,  _rdate,  _wdate);
				list.add(dto);

			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			DBClose.close(conn, psmt, rs);
		}return list;
		
	}
	
	//seq로 dto 얻는 함수
	public CalendarDto getCalDto(int seq) {

		String sql = "SELECT * FROM calendar WHERE seq = ?;";

		Connection conn = null;
		PreparedStatement psmt = null;
		ResultSet rs = null;
		CalendarDto dto = null;
		try {
			conn = DBConnection.getConnection();
			System.out.println("1/3 getCalDto success");

			psmt = conn.prepareStatement(sql);

			psmt.setInt(1, seq);
			System.out.println("2/3 getCalDto success");

			rs = psmt.executeQuery();
			System.out.println("3/3 getCalDto success");

			while (rs.next()) {
				int _seq = rs.getInt(1);
				String _id = rs.getString(2);
				String _title = rs.getString(3);
				String _content = rs.getString(4);
				String _rdate = rs.getString(5);
				String _wdate = rs.getString(6);

				dto = new CalendarDto(_seq, _id, _title, _content, _rdate, _wdate);

			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DBClose.close(conn, psmt, rs);
		}return dto;
	}
	
	//기존 Dto를 업데이트하는 함수
	public boolean updateDto(String title, String content, String rdate, int seq) {
		String sql = "UPDATE calendar SET title =? , content = ?, rdate=? WHERE seq=?;";
		
		Connection conn = null;
		PreparedStatement psmt =null;
		int count = 0;
		try {
			conn =  DBConnection.getConnection();
			System.out.println("updateDto process sucsess(1/3)");
			psmt = conn.prepareStatement(sql);
			psmt.setString(1, title);
			psmt.setString(2, content);
			psmt.setString(3, rdate);
			psmt.setInt(4, seq);
			System.out.println("updateDto process sucsess(2/3)");
			
			count = psmt.executeUpdate();
			System.out.println("updateDto process sucsess(3/3)");
			
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			DBClose.close(conn, psmt, null);
		}return count>0? true:false;		
		
		
	}


	
	
	
	
	
}
