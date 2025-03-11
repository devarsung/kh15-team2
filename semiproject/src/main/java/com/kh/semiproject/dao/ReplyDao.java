package com.kh.semiproject.dao;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import com.kh.semiproject.dto.ReplyDto;
import com.kh.semiproject.mapper.ReplyMapper;

@Repository
public class ReplyDao {

	@Autowired
	private ReplyMapper replyMapper;
	@Autowired
	private JdbcTemplate jdbcTemplate;

	// 등록(+시퀸스)
	public int sequence() {
		String sql = "select reply_seq.nextval from dual";
		return jdbcTemplate.queryForObject(sql, int.class);
	}

	public void insert(ReplyDto replyDto) {
		String sql = "INSERT INTO reply (reply_no, reply_writer, reply_origin, reply_content, reply_wtime) "
				+ "VALUES (reply_seq.NEXTVAL, ?, ?, ?, SYSTIMESTAMP)";

		Object[] data = { replyDto.getReplyWriter(), // 작성자 ID (member_id)
				replyDto.getReplyOrigin(), // 댓글이 달린 게시글 번호
				replyDto.getReplyContent() // 댓글 내용
		};

		jdbcTemplate.update(sql, data);
	}

	// 댓글 목록 조회 (닉네임 포함)
	public List<ReplyDto> selectList(int replyOrigin) {
	    String sql = "SELECT r.reply_no, r.reply_origin, m.member_nickname, " +
	                 "r.reply_content, r.reply_wtime, r.reply_etime " +
	                 "FROM reply r " +
	                 "LEFT JOIN member m ON r.reply_writer = m.member_id " +
	                 "WHERE r.reply_origin = ? " +
	                 "ORDER BY r.reply_wtime ASC";
	    Object[] data = {replyOrigin};
	    return jdbcTemplate.query(sql, replyMapper, data);
	}

	// 댓글 삭제
	public boolean delete(int replyNo) {
		String sql = "delete reply where reply_no =?";
		Object[] data = { replyNo };
		return jdbcTemplate.update(sql, data) > 0;
	}

	public ReplyDto selectOne(int replyNo) {
		String sql = "select * from reply where reply_no = ?";
		Object[] data = { replyNo };
		List<ReplyDto> list = jdbcTemplate.query(sql, replyMapper, data);
		return list.isEmpty() ? null : list.get(0);
	}

	// 댓글 수정
	public boolean update(ReplyDto replyDto) {
		String sql = "update reply " + "set reply_content=?, reply_etime=systimestamp " + "where reply_no=?";
		Object[] data = { replyDto.getReplyContent(), replyDto.getReplyNo() };
		return jdbcTemplate.update(sql, data) > 0;
	}
}
