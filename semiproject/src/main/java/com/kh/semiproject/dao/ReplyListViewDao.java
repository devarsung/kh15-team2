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
	
	// 댓글 목록 조회 (닉네임 포함)
    public List<ReplyListViewDto> selectList(int replyOrigin) {
        String sql = "SELECT r.reply_no, m.member_nickname AS reply_writer, " 
        		+"r.reply_origin, r.reply_content, r.reply_wtime, r.reply_etime " 
        		+"FROM reply r "
        		+"JOIN member m ON r.reply_writer = m.member_id " 
	        	+"WHERE r.reply_origin = ? " 
	        	+"ORDER BY r.reply_wtime DESC";
        Object[] data = {replyOrigin};
        return jdbcTemplate.query(sql, replyListViewMapper, data);
    }
    
    public String selectNicknameById(String userId) {
        String sql = "SELECT member_nickname FROM member WHERE member_id = ?";
        return jdbcTemplate.queryForObject(sql, String.class, userId);
    }

}


