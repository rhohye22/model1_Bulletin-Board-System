package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import db.DBClose;
import db.DBConnection;
import dto.BbsDto;

public class BbsDao {

	private static BbsDao dao = null;

	private BbsDao() {
		DBConnection.loadDBDriver();
	}

	public static BbsDao getInstanse() {
		if (dao == null) {
			dao = new BbsDao();
		}
		return dao;
	}

	// 글쓰기에 입력한 걸 데이터로
	public boolean insertWrite(String id, String title, String content) {

		String sql = "INSERT INTO bbs(id, ref, step, depth, title, content, wdate, del, readcount) "
				+ "VALUES(?, (select ifnull(max(ref), 0)+1 from bbs b), 0, 0, ?, ?, now(), 0, 0);";

		Connection conn = null;
		PreparedStatement psmt = null;

		int count = 0;
		try {
			conn = DBConnection.getConnection();
			System.err.println("insertWrite process sucsess(1/3");

			psmt = conn.prepareStatement(sql);

			psmt.setString(1, id);
			psmt.setString(2, title);
			psmt.setString(3, content);
			System.err.println("insertWrite process sucsess(2/3");

			// 반영된 레코드의 건수를 반환
			count = psmt.executeUpdate();
			System.out.println("3/3 insertWrite success");

		} catch (SQLException e) {
			System.out.println("insertWrite fail");
			e.printStackTrace();
		} finally {
			DBClose.close(conn, psmt, null);
		}
		return count > 0 ? true : false;
	}

	// seq조회로 dto반환하는
	public BbsDto getFromSeq(int seq) {

		String sql = "SELECT * FROM mydb.bbs WHERE seq = ?;";

		Connection conn = null;
		PreparedStatement psmt = null;
		ResultSet rs = null;

		BbsDto bd = null;

		try {

			conn = DBConnection.getConnection();
			System.out.println("getFromSeq process sucsess(1/3)");

			psmt = conn.prepareStatement(sql);
			psmt.setInt(1, seq);
			System.out.println("getFromSeq process sucsess(2/3)");

			rs = psmt.executeQuery();// 테이블 반환
			System.out.println("getFromSeq process sucsess(3/3)");

			if (rs.next()) {// 쿼리 결과가 있다면
				int _seq = rs.getInt(1);
				String _id = rs.getString(2);

				int _ref = rs.getInt(3);
				int _step = rs.getInt(4);
				int _depth = rs.getInt(5);

				String _title = rs.getString(6);
				String _content = rs.getString(7);
				String _wdate = rs.getString(8);

				int _del = rs.getInt(9);
				int _readcount = rs.getInt(10);

				bd = new BbsDto(_seq, _id, _ref, _step, _depth, _title, _content, _wdate, _del, _readcount);
			}

		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DBClose.close(conn, psmt, rs);
		}
		return bd;

	}

	// 최대 seq 수 알기
	public int maxSeq() {

		String sql = "SELECT max(seq) FROM mydb.bbs;";

		Connection conn = null;
		PreparedStatement psmt = null;
		ResultSet rs = null;

		int ms = 0;

		try {

			conn = DBConnection.getConnection();
			System.out.println("maxSeq process sucsess(1/3)");
			psmt = conn.prepareStatement(sql);
			System.out.println("maxSeq process sucsess(2/3)");
			rs = psmt.executeQuery();

			if (rs.next()) {
				ms = rs.getInt(1);

				System.out.println("maxSeq process sucsess(3/3)");
			}

		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DBClose.close(conn, psmt, rs);
		}
		return ms;

	}

	// dto객체를 닮은 리스트 생성
	public List<BbsDto> getBbsList() {

		String sql = "SELECT * FROM bbs ORDER BY ref DESC, step  ASC;";

		Connection conn = null;
		PreparedStatement psmt = null;
		ResultSet rs = null;

		List<BbsDto> list = new ArrayList<BbsDto>();

		try {
			conn = DBConnection.getConnection();
			System.out.println("1/4 getBbsList success");
			psmt = conn.prepareStatement(sql);
			System.out.println("2/4 getBbsList success");
			rs = psmt.executeQuery();
			System.out.println("3/4 getBbsList success");
			while (rs.next()) {
				BbsDto dto = new BbsDto(rs.getInt(1), rs.getString(2), rs.getInt(3), rs.getInt(4), rs.getInt(5),
						rs.getString(6), rs.getString(7), rs.getString(8), rs.getInt(9), rs.getInt(10));

				list.add(dto);
				System.out.println("4/4 getBbsList success");
			}

		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DBClose.close(conn, psmt, rs);
		}
		return list;
	}

	public void readcount(int seq) {
		String sql = "UPDATE bbs SET readcount = readcount+1 where seq = ?;";

		Connection conn = null;
		PreparedStatement psmt = null;

		try {
			conn = DBConnection.getConnection();
			psmt = conn.prepareStatement(sql);
			psmt.setInt(1, seq);

			psmt.execute();

		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DBClose.close(conn, psmt, null);
		}

	}

	public BbsDto getBbs(int seq) {
		String sql = "SELECT * FROM bbs WHERE seq = ?;";

		Connection conn = null;
		PreparedStatement psmt = null;
		ResultSet rs = null;

		BbsDto post = null;

		try {
			conn = DBConnection.getConnection();
			psmt = conn.prepareStatement(sql);
			psmt.setInt(1, seq);
			rs = psmt.executeQuery();

			if (rs.next()) {
				int _seq = rs.getInt(1);
				String _id = rs.getString(2);

				int _ref = rs.getInt(3);
				int _step = rs.getInt(4);
				int _depth = rs.getInt(5);

				String _title = rs.getString(6);
				String _content = rs.getString(7);
				String _wdate = rs.getString(8);

				int _del = rs.getInt(9);
				int _readcount = rs.getInt(10);

				post = new BbsDto(_seq, _id, _ref, _step, _depth, _title, _content, _wdate, _del, _readcount);
			}

		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DBClose.close(conn, psmt, rs);

		}
		return post;

	}

	public boolean insertAns(String id, int ref, String title, String content) {
		String sql = "INSERT INTO bbs(id, ref, step, depth, title, content, wdate, del, readcount)"
				+ "VALUES(?, ?, (SELECT ifnull(max(step),0)+1 FROM bbs b WHERE ref = ?  ), 1, ?, ?, now(), 0, 0);";

		Connection conn = null;
		PreparedStatement psmt = null;

		int count = 0;
		try {
			conn = DBConnection.getConnection();
			psmt = conn.prepareStatement(sql);
			System.out.println("1/3 insertAns success");
			psmt.setString(1, id);
			psmt.setInt(2, ref);
			psmt.setInt(3, ref);
			psmt.setString(4, title);
			psmt.setString(5, content);
			System.out.println("2/3 insertAns success");
			count = psmt.executeUpdate();
			System.out.println("3/3 insertAns success");
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DBClose.close(conn, psmt, null);
		}
		return count > 0 ? true : false;

	}

	public boolean delete(int seq) {
		String sql = "UPDATE bbs SET del = 1 WHERE seq = ?;";

		Connection conn = null;
		PreparedStatement psmt = null;
		int count = 0;
		try {
			conn = DBConnection.getConnection();
			psmt = conn.prepareStatement(sql);

			psmt.setInt(1, seq);

			count = psmt.executeUpdate();
			// TODO: handle exception
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DBClose.close(conn, psmt, null);
		}
		return count > 0 ? true : false;
	}

	public List<BbsDto> getBbsSearchList(String choice, String search) {

		String sql = "SELECT * FROM bbs";

		Connection conn = null;
		PreparedStatement psmt = null;
		ResultSet rs = null;

		List<BbsDto> list = new ArrayList<BbsDto>();

		if (choice.equals( "title")) {
			sql += " WHERE title LIKE '%"+search+"%'";

		} else if (choice.equals("content")) {
			sql += " WHERE content LIKE '%"+search+"%'";

		} else if (choice.equals("writer")) {
			sql += " WHERE id LIKE '%"+search+"%'";
		}

		sql += " order by ref desc, step asc; ";
		
		System.out.println(sql);
		try {
			conn = DBConnection.getConnection();
			psmt = conn.prepareStatement(sql);
	
			rs = psmt.executeQuery();

			while (rs.next()) {

				BbsDto dto = new BbsDto(rs.getInt(1), rs.getString(2), rs.getInt(3), rs.getInt(4), rs.getInt(5),
						rs.getString(6), rs.getString(7), rs.getString(8), rs.getInt(9), rs.getInt(10));
				list.add(dto);

			}

		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DBClose.close(conn, psmt, rs);
		}
		return list;

	}

public List<BbsDto> getBbsPageList(String choice, String search, int pageNumber) {
		
		String sql = " select seq, id, ref, step, depth, title, content, wdate, del, readcount "
				+ " from "
				+ " (select row_number()over(order by ref desc, step asc) as rnum,"
				+ "	seq, id, ref, step, depth, title, content, wdate, del, readcount "
				+ " from bbs ";

		String searchSql = "";
		if(choice.equals("title")) {
			searchSql = " where title like '%" + search + "%' ";
		}
		else if(choice.equals("content")) {
			searchSql = " where content like '%" + search + "%' ";
		} 
		else if(choice.equals("writer")) {
			searchSql = " where id='" + search + "' "; 
		} 
		sql += searchSql;
		
		sql += 	  " order by ref desc, step asc) a "
				+ " where rnum between ? and ? ";
				
		Connection conn = null;
		PreparedStatement psmt = null;
		ResultSet rs = null;
		
		// pageNumber(0, 1, 2...)
		int start, end;
		start = 1 + 10 * pageNumber;	//  1 11 21 31 41
		end = 10 + 10 * pageNumber;		// 10 20 30 40 50
		
		List<BbsDto> list = new ArrayList<BbsDto>();
				
		try {
			conn = DBConnection.getConnection();
			System.out.println("1/4 getBbsPageList success");
			
			psmt = conn.prepareStatement(sql);
			psmt.setInt(1, start);
			psmt.setInt(2, end);
			System.out.println("2/4 getBbsPageList success");
			
			rs = psmt.executeQuery();
			System.out.println("3/4 getBbsPageList success");
			
			while(rs.next()) {
				
				BbsDto dto = new BbsDto(rs.getInt(1), 
										rs.getString(2), 
										rs.getInt(3), 
										rs.getInt(4), 
										rs.getInt(5), 
										rs.getString(6), 
										rs.getString(7), 
										rs.getString(8), 
										rs.getInt(9), 
										rs.getInt(10));
				
				list.add(dto);
			}
			System.out.println("4/4 getBbsPageList success");
			
		} catch (SQLException e) {	
			System.out.println("getBbsList fail");
			e.printStackTrace();
		} finally {
			DBClose.close(conn, psmt, rs);
		}
		
		return list;		
	}
	
//글 수정

public boolean updateDto( int seq, String title, String content) {
	String sql = "UPDATE bbs SET title =? , content = ? WHERE seq=?;";
	
	Connection conn = null;
	PreparedStatement psmt =null;
	int count = 0;
	try {
		conn =  DBConnection.getConnection();
		System.out.println("updateDto process sucsess(1/3)");
		psmt = conn.prepareStatement(sql);
		psmt.setString(1, title);
		psmt.setString(2, content);
		psmt.setInt(3, seq);
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
