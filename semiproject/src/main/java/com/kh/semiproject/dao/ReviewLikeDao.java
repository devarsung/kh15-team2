package com.kh.semiproject.dao;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import com.kh.semiproject.dto.ReviewLikeDto;
import com.kh.semiproject.mapper.ReviewLikeMapper;

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
	
	// 내가 좋아요한 여행지 목록 조회 메소드
	public List<ReviewLikeDto> selectReviewLikeList(String memberId) {
		String sql = "select review_no, count(*) as like_count " + "from review_like " + "where member_id = ? "
				+ "group by review_no " + "order by like_count desc";
		Object[] data = { memberId };

		return jdbcTemplate.query(sql, reviewLikeMapper, data);
	}
}