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
		String sql = "insert into reply( " + "reply_no, reply_writer, " + "reply_origin, reply_content " + ") "
				+ "values(?, ?, ?, ?)";
		Object[] data = { replyDto.getReplyNo(), replyDto.getReplyWriter(), replyDto.getReplyOrigin(),
				replyDto.getReplyContent() };
		jdbcTemplate.update(sql, data);
	}
	
	 // 댓글 목록 조회 (닉네임 포함)
    public List<ReplyDto>selectList(int replyOrigin) {
        String sql = "select r.reply_no, r.reply_writer, m.member_nickname, " +
                     "r.reply_origin, r.reply_content, r.reply_wtime, r.reply_etime " +
                     "from reply r " +
                     "join member m on r.reply_writer = m.member_id " + // 닉네임 가져오기
                     "where r.reply_origin = ? " +
                     "order by r.reply_wtime desc";
        Object[] data = { replyOrigin};
        return jdbcTemplate.query(sql, replyMapper, data);
    }
	
//	//내가 작성한 댓글 목록
//    public List<ReplyDto> selectListByUserIdAndReviewNo(String userId, int replyOrigin) {
//        String sql = "SELECT * FROM reply WHERE reply_origin = ? AND reply_writer = ?"; 
//        Object[] data = {replyOrigin, userId}; // 현재 로그인한 사용자의 ID 추가
//        return jdbcTemplate.query(sql, replyMapper, data);
//    }

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
	
	//댓글 수정
	public boolean update(ReplyDto replyDto) {
		String sql = "update reply " + "set reply_content=?, reply_etime=systimestamp " + "where reply_no=?";
		Object[] data = { replyDto.getReplyContent(), replyDto.getReplyNo() };
		return jdbcTemplate.update(sql, data) > 0;
	}
}
