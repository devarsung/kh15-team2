package com.kh.semiproject.dao;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import com.kh.semiproject.dto.ReplyListViewDto;
import com.kh.semiproject.mapper.ReplyListViewMapper;

@Repository
public class ReplyListViewDao {
	@Autowired
	private ReplyListViewMapper replyListViewMapper;
	@Autowired
	private JdbcTemplate jdbcTemplate;
	
	public List<ReplyListViewDto> selectListByReviewNo(int reviewNo) {
	    String sql = "SELECT r.reply_no, r.reply_writer, r.reply_content, r.reply_wtime, r.reply_etime, m.member_nickname " 
	               + "FROM reply r "
	               + "JOIN member m ON r.reply_writer = m.member_id "
	               + "WHERE r.reply_origin = ?";
	    Object[] data = { reviewNo};
	    return jdbcTemplate.query(sql, replyListViewMapper, data);
	}
	
	public String selectNicknameById(String userId) {
	    String sql = "SELECT m.member_nickname FROM member m WHERE m.member_id = ?";
	    return jdbcTemplate.queryForObject(sql, String.class, userId);
	}
}


