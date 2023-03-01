package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import db.DBClose;
import db.DBConnection;
import dto.MemberDto;

public class MemberDao {
//싱글톤

	// 외부에서 인스턴스 못만드는 정적변수(객체) 선언 = null
	private static MemberDao dao = null;

	// 외부에서 호출못하는 생성자(클래스 내에서만 사용가능)
	private MemberDao() {
		DBConnection.loadDBDriver();// 드라이버 찾기
	}

	// 외부에서 (짭)인스턴스를 만들수 있는 메서드
	public static MemberDao getInstance() {
		// 앞서 생성된 dao가 없다면 새로 만들고 아니면 있던거 줌
		if (dao == null) {
			dao = new MemberDao();
		}
		return dao;
	}

	// 회원가입 정보 DB에 넣기
	public boolean addMember(MemberDto dto) {

		String sql = "INSERT INTO member(id, pwd, name, email,auth) VALUES(?,?,?,?,?);";

		/*
		 * 기본적으로 데이터베이스 연결할 때 커넥션이 필요하고 쿼리를 위해서 psmt가 필요하고 조회결과를 담기 위해서 resultset같은 것이
		 * 필요해요
		 */
		Connection conn = null;
		PreparedStatement psmt = null;

		int count = 0;
		try {
			// 1단계 conn을 드라이버에 연결
			conn = DBConnection.getConnection();
			System.out.println("addMeber process sucsess(1/3)");

			// 2단계 sql쿼리문(sql 구문을 JDBC 드라이버가 읽을 수 있는 형식으로 전처리)

			psmt = conn.prepareStatement(sql);
			psmt.setString(1, dto.getId());
			psmt.setString(2, dto.getPwd());
			psmt.setString(3, dto.getName());
			psmt.setString(4, dto.getEmail());
			psmt.setInt(5, dto.getAuth());
			System.out.println("addMeber process sucsess(2/3)");

			// 반영된 레코드의 건수를 반환
			count = psmt.executeUpdate();
			System.out.println("addMeber process sucsess(3/3)");
		} catch (SQLException e) {
			System.out.println("addMeber process fail");
			e.printStackTrace();
		} finally {
			// DB닫기
			DBClose.close(conn, psmt, null);
		}

		return count > 0 ? true : false;

	}

	// 정보 조회 메서드
	public boolean serchId(String id) {

		String sql = "SELECT id FROM member WHERE id = ?;";

		Connection conn = null;
		PreparedStatement psmt = null;
		ResultSet rs = null;

		boolean find_id = false;// 있으면 true, 없으면 false

		try {
			conn = DBConnection.getConnection();
			System.out.println("serchId process sucsess(1/3)");

			psmt = conn.prepareStatement(sql);
			psmt.setString(1, id);
			System.out.println("serchId process sucsess(2/3)");

			rs = psmt.executeQuery();//테이블 반환
			System.out.println("serchId process sucsess(3/3)");

			if (rs.next()) {// 쿼리 결과가 있다면
				find_id = true;
			}

		} catch (SQLException e) {
			System.out.println("find id fail");
			e.printStackTrace();
		} finally {
			DBClose.close(conn, psmt, rs);
		}
		return find_id;
	}

//로그인	1
	public boolean serchIdPw(String id, String pwd) {

		String sql = "SELECT id, pwd FROM member WHERE id = ? and pwd = ?;";

		Connection conn = null;
		PreparedStatement psmt = null;
		ResultSet rs = null;

		boolean find_meber = false;// 있으면 true, 없으면 false

		try {
			conn = DBConnection.getConnection();
			System.out.println("serchId process sucsess(1/3)");

			psmt = conn.prepareStatement(sql);
			psmt.setString(1, id);
			psmt.setString(2, pwd);

			System.out.println("serchId process sucsess(2/3)");

			rs = psmt.executeQuery();
			System.out.println("serchId process sucsess(3/3)");

			if (rs.next()) {// 쿼리 결과가 있다면
				find_meber = true;
			}

		} catch (SQLException e) {
			System.out.println("find id fail");
			e.printStackTrace();
		} finally {
			DBClose.close(conn, psmt, rs);
		}
		return find_meber;
	}

	// 로그인 2
	public MemberDto login(String id, String pwd) {

		String sql = " select id, name, email, auth from member where id=? and pwd=? ";

		Connection conn = null;
		PreparedStatement psmt = null;
		ResultSet rs = null;

		MemberDto mem = null;

		try {
			conn = DBConnection.getConnection();
			System.out.println("1/3 login success");
 
			psmt = conn.prepareStatement(sql);
			psmt.setString(1, id);
			psmt.setString(2, pwd);
			System.out.println("2/3 login success");

			rs = psmt.executeQuery();
			System.out.println("3/3 login success");

			if (rs.next()) {
				String _id = rs.getString(1);
				String _name = rs.getString(2);
				String _email = rs.getString(3);
				int _auth = rs.getInt(4);

				mem = new MemberDto(_id, null, _name, _email, _auth);

			}

		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			DBClose.close(conn, psmt, rs);
		}

		return mem;
	}

}
