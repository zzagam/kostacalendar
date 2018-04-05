package org.kostacalendar.model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import javax.sql.DataSource;

public class TodoListDAO {
	private TodoListDAO() {
		dataSource = DataSourceManager.getInstance().getDataSource();
	}

	private static TodoListDAO instance = new TodoListDAO();

	public static TodoListDAO getInstance() {
		return instance;
	}

	private DataSource dataSource;

	public Connection getConnection() throws SQLException {
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

	public ArrayList<TodoListDTO> getTodoListById(String id) throws SQLException {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		StringBuilder sql = new StringBuilder();
		ArrayList<TodoListDTO> list = new ArrayList<TodoListDTO>();
		try {
			con = getConnection();
			sql.append("select t.todo_no,t.category_no,t.title,to_char(t.start_date,'MM/DD/YYYY'),to_char(t.end_date,'MM/DD/YYYY')"); //"select t.todo_no,t.title,t.start_date,t.end_date\n" + 
			sql.append(" from todo_list t, kc_user k");		//" from todo_list t, kc_user k\n" + 
			sql.append(" where t.id=k.id and t.id=?");//" where t.id=k.id and t.id=?"
			sql.append(" order by t.start_date");
			pstmt = con.prepareStatement(sql.toString());
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				list.add(new TodoListDTO(rs.getInt(1), null, new CategoryDTO(rs.getInt(2), null), rs.getString(3), null,
						rs.getString(4), rs.getString(5)));
			}
		} finally {
			closeAll(rs, pstmt, con);
		}
		return list;
	}

	public TodoListDTO getReadDetail(int todoNo) throws SQLException {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		StringBuilder sql = new StringBuilder();
		TodoListDTO tdto = null;
		CategoryDTO cdto = new CategoryDTO();
		try {
			con = getConnection();
			sql.append(
					" SELECT t.category_no, t.title, t.content, to_char(t.start_date,'YYYY.MM.DD.hh24:mi'), to_char(t.end_date,'YYYY.MM.DD.hh24:mi'),c.category_name ");
			sql.append(" FROM todo_list t, category c ");
			sql.append(" WHERE todo_no=? and t.category_no=c.category_no ");
			pstmt = con.prepareStatement(sql.toString());
			pstmt.setInt(1, todoNo);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				tdto = new TodoListDTO(todoNo, null, cdto, rs.getString(2), rs.getString(3), rs.getString(4),
						rs.getString(5));
				cdto.setCategoryNo(rs.getInt(1));
				cdto.setCategoryName(rs.getString(6));
			}
		} finally {
			closeAll(rs, pstmt, con);
		}
		return tdto;
	}

	public ArrayList<TodoListDTO> getTodayTodoList(String id) throws SQLException {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		StringBuilder sql = new StringBuilder();
		ArrayList<TodoListDTO> list = new ArrayList<TodoListDTO>();
		try {
			con = getConnection();
			sql.append(
					"select t.todo_no, c.category_no, c.category_name, t.title, to_char(t.start_date,'YYYY.MM.DD.HH24:MI'), to_char(t.end_date,'YYYY.MM.DD.HH24:MI'), t.content");
			sql.append(" from todo_list t, category c");
			sql.append(
					" where t.id=? and t.category_no=c.category_no and start_date < sysdate and end_date > sysdate");
			pstmt = con.prepareStatement(sql.toString());
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				list.add(new TodoListDTO(rs.getInt(1), null, new CategoryDTO(rs.getInt(2), rs.getString(3)),
						rs.getString(4), rs.getString(7), rs.getString(5), rs.getString(6)));
			}
		} finally {
			closeAll(rs, pstmt, con);
		}
		return list;
	}

	public ArrayList<TodoListDTO> getEachCategoryCount(String id) throws SQLException {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		ArrayList<TodoListDTO> list = new ArrayList<TodoListDTO>();
		StringBuilder sql = new StringBuilder();
		try {
			con = getConnection();

			sql.append("select category_no,category_name,count(category_name)");
			sql.append(" from (select c.category_no,c.category_name from todo_list t, category c");
			sql.append(" where t.id=? and c.category_no=t.category_no)");
			sql.append(" group by category_name,category_no order by category_no asc");
			pstmt = con.prepareStatement(sql.toString());
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				TodoListDTO dto = new TodoListDTO();
				dto.setCategory(new CategoryDTO(rs.getInt(1), rs.getString(2)));
				dto.setCount(rs.getInt(3));
				list.add(dto);
			}
		} finally {
			closeAll(rs, pstmt, con);
		}

		return list;
	}

	public void updatePosting(TodoListDTO tdListDTO) throws SQLException {
		Connection con = null;
		PreparedStatement pstmt = null;

		try {
			con = getConnection();
			StringBuilder sql = new StringBuilder();
			sql.append("UPDATE TODO_LIST SET CATEGORY_NO = ?, TITLE = ?, CONTENT = ?,");
			sql.append("START_DATE = TO_DATE(?, 'YYYY-MM-DD'),");
			sql.append("END_DATE = TO_DATE(?, 'YYYY-MM-DD') ");
			sql.append("WHERE id=? AND todo_no=?");
			pstmt = con.prepareStatement(sql.toString());
			pstmt.setInt(1, tdListDTO.getCategory().getCategoryNo());
			pstmt.setString(2, tdListDTO.getTitle());
			pstmt.setString(3, tdListDTO.getContent());
			pstmt.setString(4, tdListDTO.getStartDate());
			pstmt.setString(5, tdListDTO.getEndDate());
			pstmt.setString(6, tdListDTO.getUser().getId());
			pstmt.setInt(7, tdListDTO.getTodoNo());
			System.out.println("성공");
			pstmt.executeUpdate();
		} finally {
			closeAll(pstmt, con);
		}
	}

	public TodoListDTO getPostingByNo(int todoNo) throws SQLException {
		TodoListDTO tdListDTO = null;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		System.out.println("getPostingByNo" + todoNo);
		try {
			con = getConnection();
			StringBuilder sql = new StringBuilder();
			sql.append("select t.todo_no, t.title, to_char(t.start_date,'YYYY-MM-DD') as start_date,");
			sql.append("to_char(t.end_date,'YYYY-MM-DD') as end_date, t.content,t.category_no, t.id, u.name ");
			sql.append("from todo_list t, kc_user u ");
			sql.append("where t.id=u.id and t.todo_no=?");
			pstmt = con.prepareStatement(sql.toString());
			pstmt.setInt(1, todoNo);
			rs = pstmt.executeQuery();

			if (rs.next()) {
				tdListDTO = new TodoListDTO();
				tdListDTO.setTodoNo(rs.getInt("todo_no"));
				tdListDTO.setTitle(rs.getString("title"));
				tdListDTO.setContent(rs.getString("content"));
				tdListDTO.setStartDate(rs.getString("start_date"));
				tdListDTO.setEndDate(rs.getString("end_date"));
				tdListDTO.setCategory(new CategoryDTO(rs.getInt("category_no"), null));
				KCUserDTO kcuDTO = new KCUserDTO();
				kcuDTO.setId(rs.getString("id"));
				kcuDTO.setName(rs.getString("name"));

			}
			// System.out.println("dao getContent:"+tdListDTO);
		} finally {
			closeAll(rs, pstmt, con);
		}
		return tdListDTO;
	}

	// 등록된 카테고리 리스트 가져오기
	public ArrayList<CategoryDTO> getCategoryList() throws SQLException {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		ArrayList<CategoryDTO> list = new ArrayList<>();
		try {
			con = getConnection();
			String sql = "select category_no, category_name from category";
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				list.add(new CategoryDTO(rs.getInt(1), rs.getString(2)));
			}
		} finally {
			closeAll(rs, pstmt, con);
		}
		return list;
	}

	//일정등록하기
	public void createSchedule(TodoListDTO dto) throws SQLException {
		Connection con = null;
		PreparedStatement pstmt = null;
		try {
			System.out.println(dto.getStartDate());
			System.out.println(dto.getEndDate());
			con = dataSource.getConnection();
			StringBuilder sql = new StringBuilder();
			sql.append("insert into todo_list(todo_no, id, category_no, title, content, start_date, end_date) ");
			sql.append("values (todo_seq.nextval, ?,?,?,?");
			sql.append(",to_date(?,'YYYYMMDDHH24mi'),to_date(?,'YYYYMMDDHH24mi'))");
			pstmt = con.prepareStatement(sql.toString());
			pstmt.setString(1, dto.getUser().getId());
			pstmt.setInt(2, dto.getCategory().getCategoryNo());
			pstmt.setString(3, dto.getTitle());
			pstmt.setString(4, dto.getContent());
			pstmt.setString(5, dto.getStartDate());
			pstmt.setString(6, dto.getEndDate());
			pstmt.executeUpdate();
		} finally {
			closeAll(null, pstmt, con);
		}
	}

	//일정삭제
	public void deleteSchedule(String id, int no) throws SQLException {
		Connection con=null;
		PreparedStatement pstmt=null;
		try{
			con=dataSource.getConnection();
			String sql = "delete from todo_list where todo_no = ? and id = ?";
			pstmt=con.prepareStatement(sql.toString());
			pstmt.setInt(1, no);
			pstmt.setString(2, id);
			pstmt.executeUpdate();
		} finally {
			closeAll(null, pstmt, con);
		}
	}

	public ArrayList<TodoListDTO> readCountDetail(int categoryNo, String id) throws SQLException {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		ArrayList<TodoListDTO> list = new ArrayList<TodoListDTO>();
		con = dataSource.getConnection();
		StringBuilder sql = new StringBuilder();
		sql.append(
				" select t.todo_no,t.category_no,t.title,to_char(t.start_date,'MM/DD/YYYY'),to_char(t.end_date,'MM/DD/YYYY')");
		sql.append(" from category c , todo_list t  ");
		sql.append(" where t.category_no=c.category_no and c.category_no=? and t.id=?");
		pstmt = con.prepareStatement(sql.toString());
		pstmt.setInt(1, categoryNo);
		pstmt.setString(2, id);
		rs = pstmt.executeQuery();
		while (rs.next()) {
			list.add(new TodoListDTO(rs.getInt(1), null, new CategoryDTO(rs.getInt(2), null), rs.getString(3), null,
					rs.getString(4), rs.getString(5)));
		}
		return list;
	}

	public int getTotalTodoListById(String id) throws SQLException {
		Connection con=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		StringBuilder sql = new StringBuilder();
		try {
			con=getConnection();
			sql.append("select count(*) from todo_list");
			sql.append(" where id=?");
			pstmt=con.prepareStatement(sql.toString());
			pstmt.setString(1, id);
			rs=pstmt.executeQuery();
			if(rs.next()) {
				return rs.getInt(1);
			}
		}finally {
			closeAll(rs, pstmt, con);
		}
		return 0;
	}

	public ArrayList<TodoListDTO> getBoardTodoListById(String id, int startRow, int endRow) throws SQLException {
		Connection con=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		StringBuilder sql = new StringBuilder();
		ArrayList<TodoListDTO> list = new ArrayList<TodoListDTO>();
		try {
	
			con=getConnection();
			sql.append("select t.todo_no, t.category_no, c.category_name, t.title,");
			sql.append(" to_char(t.start_date,'yyyy/mm/dd.hh24:mi'),");
			sql.append(" to_char(t.end_date,'yyyy/mm/dd.hh24:mi') ");
			sql.append(" from(");
			sql.append(" select row_number() over(order by todo_no desc) as rnum,");
			sql.append(" todo_no, category_no, title,");
			sql.append(" start_date, end_date ");
			sql.append(" from todo_list where id=?)t, category c");
			sql.append(" where t.category_no=c.category_no and rnum between ? and ?");
			sql.append(" order by todo_no desc");
			pstmt=con.prepareStatement(sql.toString());
			pstmt.setString(1, id);
			pstmt.setInt(2, startRow);
			pstmt.setInt(3, endRow);
			rs=pstmt.executeQuery();
			while(rs.next()) {
				list.add(new TodoListDTO(rs.getInt(1), null, 
						new CategoryDTO(rs.getInt(2), 
								rs.getString(3)), 
						rs.getString(4), null, 
						rs.getString(5), rs.getString(6)));
			}
		}finally {
			closeAll(rs, pstmt, con);
		}
		return list;
	}

}
