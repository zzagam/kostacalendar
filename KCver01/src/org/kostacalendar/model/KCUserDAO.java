package org.kostacalendar.model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.sql.DataSource;

public class KCUserDAO {
	private KCUserDAO() {
		dataSource = DataSourceManager.getInstance().getDataSource();
	}
	private static KCUserDAO instance = new KCUserDAO();
	public static KCUserDAO getInstance() {
		return instance;
	}
	private DataSource dataSource;
	
	
	
	
	public Connection getConnection() throws SQLException{
		return dataSource.getConnection();
	}

	public void closeAll(ResultSet rs, PreparedStatement pstmt, Connection con) throws SQLException {
		if (rs != null) {
			rs.close();
		}
		if (pstmt != null) {
			pstmt.close();
		}
		if (con != null) {
			con.close();
		}
	}
	public void closeAll(PreparedStatement pstmt, Connection con) throws SQLException {
		if (pstmt != null) {
			pstmt.close();
		}
		if (con != null) {
			con.close();
		}
	}


	public void register(KCUserDTO dto) throws SQLException {
		Connection con=null;
		PreparedStatement pstmt=null;
		try {
			con=getConnection();
			String sql="insert into kc_user(id,password,name) values(?,?,?)";
			pstmt=con.prepareStatement(sql);
			pstmt.setString(1, dto.getId());
			pstmt.setString(2, dto.getPassword());
			pstmt.setString(3, dto.getName());
			pstmt.executeUpdate();
		} finally {
			closeAll(pstmt, con);
		}
		
	}
		
	public boolean idcheck(String id) throws SQLException {
		boolean flag =false;
		Connection con=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		try {
			con=getConnection();
			String sql="select count(*) from kc_user where id=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1,id);
			rs = pstmt.executeQuery();
			if (rs.next() && (rs.getInt(1)) > 0)
				flag = true;
		} finally {
			closeAll(rs, pstmt, con);
		}
		return flag;
	}
	
	public KCUserDTO login(KCUserDTO dto) throws SQLException {
		Connection con=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		KCUserDTO resultDTO=null;
		try {
			con=getConnection();
			String sql="select name from kc_user where id=? and password=?";
			pstmt=con.prepareStatement(sql);
			pstmt.setString(1, dto.getId());
			pstmt.setString(2, dto.getPassword());
			pstmt.executeQuery();
			rs=pstmt.executeQuery();
			if(rs.next())
				resultDTO=new KCUserDTO(dto.getId(),dto.getPassword(),rs.getString(1),0);
		} finally {
			closeAll(rs, pstmt, con);
		}
		return resultDTO;
	}

	public boolean checkIdDup(String id) throws SQLException {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String userId = "noDup";
		try {
			con = getConnection();
			String sql = "select id from KC_User where id=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				userId=rs.getString(1);
			}
		}finally {
			closeAll(rs, pstmt, con);
		}
		if (userId.equals("noDup")) {
			return true;
		}
			
		return false;
	}
	
}
