package com.kh.semiproject.dao;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import com.kh.semiproject.dto.NoticeListViewDto;
import com.kh.semiproject.dto.ReviewListViewDto;
import com.kh.semiproject.mapper.NoticeListViewMapper;
import com.kh.semiproject.vo.PageVO;

@Repository
public class NoticeListViewDao {
	@Autowired
	private NoticeListViewMapper noticeListViewMapper;
	
	@Autowired
	private JdbcTemplate jdbcTemplate;
	
	public List<NoticeListViewDto> selectList(PageVO pageVO){
		String sql = "";
		if(pageVO.isList()) {
			sql = "select * from ("
				+ "select rownum rn, TMP.* from ("
					+ "SELECT N.*, M.* "
					+ "FROM Notice N "
					+ "LEFT JOIN MEMBER M ON N.notice_writer = M.member_id "
					+ "ORDER BY N.notice_no ASC "
				+ ")TMP"
			+ ") where rn between ? and ?";
			Object[] data = {pageVO.getStartRownum(), pageVO.getFinishRownum()};
			return jdbcTemplate.query(sql, noticeListViewMapper, data);
		}
		else {
			sql = "select * from ("
				+ "select rownum rn, TMP.* from ("
					+ "SELECT N.*, M.* "
					+ "FROM Notice N "
					+ "LEFT JOIN MEMBER M ON N.notice_writer = M.member_id "
					+ "where instr(#1, ?) > 0 "
					+ "ORDER BY N.notice_no ASC "
				+ ")TMP"
			+ ") where rn between ? and ?";
			sql = sql.replace("#1", pageVO.getColumn());
			Object[] data = {pageVO.getKeyword(),pageVO.getStartRownum(), pageVO.getFinishRownum()};
			return jdbcTemplate.query(sql, noticeListViewMapper, data);
		}
	}



	public List<NoticeListViewDto> selectListOnNotice(){
		String sql = "	SELECT * "
				+ "FROM ("
				+ "    SELECT rownum rn, TMP.*"
				+ "    FROM ("
				+ "    "
				+ "        ORDER BY notice_wtime DESC"
				+ "    ) TMP"
				+ ")"
				+ "WHERE rn BETWEEN 1 AND 5";
		
		List<NoticeListViewDto> list = jdbcTemplate.query(sql, noticeListViewMapper);
		System.out.println(list);
		return list;
	}







}
























