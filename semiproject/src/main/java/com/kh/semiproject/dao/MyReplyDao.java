package com.kh.semiproject.dao;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import com.kh.semiproject.dto.MyReplyDto;
import com.kh.semiproject.mapper.MyReplyMapper;
import com.kh.semiproject.vo.RestPageVO;

@Repository
public class MyReplyDao {
	@Autowired
	private MyReplyMapper MyReplyMapper;
	@Autowired
	private JdbcTemplate jdbcTemplate;
	
	//내가 작성한 후기 목록
	public List<MyReplyDto> selectMyReplyList(String memberId) {

			String sql = "SELECT r.reply_no, r.reply_origin, rv.review_title, "
					+ "m.member_nickname, r.reply_content, r.reply_wtime, r.reply_etime " + "FROM reply r "
					+ "LEFT JOIN member m ON r.reply_writer = m.member_id "
					+ "LEFT JOIN review rv ON r.reply_origin = rv.review_no " + "WHERE r.reply_writer = ? "
					+ "ORDER BY r.reply_wtime DESC";

			Object[] data = {memberId};
			return jdbcTemplate.query(sql, MyReplyMapper, data);
	}
	
	public int count(RestPageVO restPageVO) {
		String sql = "select count(*) from reply where reply_writer = ?";
		Object[] data = {restPageVO.getMemberId()};
		return jdbcTemplate.queryForObject(sql, int.class, data);
	}
	
	public List<MyReplyDto> selectListRest(RestPageVO restPageVO){
		String sql = "SELECT * FROM ("
				+ "				    SELECT rownum rn, TMP.*"
				+ "				    FROM ("
				+ "SELECT r.reply_no, r.reply_origin, rv.review_title, r.reply_writer,"
				+ "					m.member_nickname, r.reply_content, r.reply_wtime, r.reply_etime "
				+ "					FROM reply r "
				+ "					LEFT JOIN member m ON r.reply_writer = m.member_id "
				+ "					LEFT JOIN review rv ON r.reply_origin = rv.review_no  "
				+ "					WHERE r.reply_writer = ? "
				+ "					ORDER BY r.reply_wtime DESC"
					+ "				    ) TMP"
				+ "				)"
				+ "				WHERE rn BETWEEN ? AND ?";
		Object[] data = { restPageVO.getMemberId(), restPageVO.getStartRownum(), restPageVO.getFinishRownum() };
		return jdbcTemplate.query(sql, MyReplyMapper, data);
	}
	
}



















