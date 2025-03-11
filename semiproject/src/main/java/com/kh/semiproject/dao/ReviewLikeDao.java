package com.kh.semiproject.dao;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import com.kh.semiproject.dto.ReviewLikeDto;
import com.kh.semiproject.mapper.ReviewLikeMapper;
import com.kh.semiproject.vo.RestPageVO;

@Repository
public class ReviewLikeDao {
	@Autowired
	private JdbcTemplate jdbcTemplate;
	@Autowired
	private ReviewLikeMapper reviewLikeMapper;

	// 좋아요 설정
	public void insertReviewLike(String memberId, int reviewNo) {
		String sql = "insert into review_like(member_id, review_no) values(?, ?)";
		Object[] data = { memberId, reviewNo };
		jdbcTemplate.update(sql, data);
	}

	// 좋아요 해제
	public void deleteReviewLike(String memberId, int reviewNo) {
		String sql = "delete review_like where member_id=? and review_no=? ";
		Object[] data = { memberId, reviewNo };
		jdbcTemplate.update(sql, data);
	}

	// 좋아요 검사
	public boolean checkReviewLike(String memberId, int reviewNo) {
		String sql = "select count(*) from review_like " + "where member_id=? and review_no=?";
		Object[] data = { memberId, reviewNo };
		return jdbcTemplate.queryForObject(sql, int.class, data) > 0;
	}

	// 좋아요 개수
	public int countReviewLike(int reviewNo) {
		String sql = "select count(*) from review_like where review_no=?";
		Object[] data = { reviewNo };
		return jdbcTemplate.queryForObject(sql, int.class, data);
	}

	// 좋아요 개수를 갱신하는 메소드
	public boolean updateReviewLike(int reviewNo, int count) {
		String sql = "update review set review_like = ? where review_no = ?";
		Object[] data = { count, reviewNo };
		return jdbcTemplate.update(sql, data) > 0;
	}
	
	// 내가 좋아요한 후기 목록 조회 메소드
	public List<ReviewLikeDto> selectReviewLikeList(String memberId) {
        String sql = "SELECT r.review_no, r.review_title, m.member_nickname AS review_writer, " 
        			+"r.review_wtime, r.review_read, COUNT(rl2.member_id) AS like_count " 
	        		+"FROM review_like rl " 
	        		+"JOIN review r ON rl.review_no = r.review_no " 
	        		+"JOIN member m ON r.review_writer = m.member_id " 
	        		+"LEFT JOIN review_like rl2 ON r.review_no = rl2.review_no " 
	        		+"WHERE rl.member_id = ? " 
	        		+"GROUP BY r.review_no, r.review_title, m.member_nickname, r.review_wtime, r.review_read " 
	        		+"ORDER BY r.review_wtime DESC";
        Object[] data = { memberId };
        return jdbcTemplate.query(sql, reviewLikeMapper, data);
    }
	
	public int count(RestPageVO restPageVO) {
		String sql = "select count(*) from review_like where = ?";
		Object[] data = {restPageVO.getMemberId()};
		return jdbcTemplate.queryForObject(sql, int.class, data);
	}
	
	public List<ReviewLikeDto> selectListRest(RestPageVO restPageVO){
		String sql =  "SELECT * FROM ("
				+ "				    SELECT rownum rn, TMP.*"
				+ "				    FROM ("
				+  "SELECT r.review_no, r.review_title, m.member_nickname AS review_writer, " 
     			+"r.review_wtime, r.review_read, COUNT(rl2.member_id) AS like_count " 
	        		+"FROM review_like rl " 
	        		+"JOIN review r ON rl.review_no = r.review_no " 
	        		+"JOIN member m ON r.review_writer = m.member_id " 
	        		+"LEFT JOIN review_like rl2 ON r.review_no = rl2.review_no " 
	        		+"WHERE rl.member_id = ? " 
	        		+"GROUP BY r.review_no, r.review_title, m.member_nickname, r.review_wtime, r.review_read " 
	        		+"ORDER BY r.review_wtime DESC"
					+ "				    ) TMP"
				+ "				)"
				+ "				WHERE rn BETWEEN ? AND ?";
		Object[] data = { restPageVO.getMemberId(), restPageVO.getStartRownum(), restPageVO.getFinishRownum() };
		return jdbcTemplate.query(sql, reviewLikeMapper, data);
	}
	 
}
















