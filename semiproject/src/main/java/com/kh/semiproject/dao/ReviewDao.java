package com.kh.semiproject.dao;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import com.kh.semiproject.dto.ReplyDto;
import com.kh.semiproject.dto.ReviewDto;
import com.kh.semiproject.mapper.ReviewMapper;

@Repository
public class ReviewDao {
	@Autowired
	private JdbcTemplate jdbcTemplate;
	
	@Autowired
	private ReviewMapper reviewMapper;
	
	public int sequence() {
		String sql = "select review_seq.nextval from daul";
		return jdbcTemplate.queryForObject(sql, int.class);
	}

	public void insert(ReviewDto reviewDto) {
		int reviewNo = this.sequence();
		reviewDto.setReviewNo(reviewNo);
		String sql = "insert into review(review_title, review_content, review_writer, review_place)"
				+ "values(?,?,?,?)";
		Object[] data={reviewDto.getReviewTitle(), reviewDto.getReviewContent(), reviewDto.getReviewWriter(), reviewDto.getReviewPlace()};
		 jdbcTemplate.update(sql, data);
	}

	public boolean delete(int reviewNo) {
		String sql = "delete from review where review_no = ?";
		Object[] data = {reviewNo};
		return jdbcTemplate.update(sql, data) > 0;
	}
	
	public boolean update(ReviewDto reviewDto) {
		String sql = "update review set review_title = ?, review_content = ?, review_etime = systimestamp where review_no =?";
		Object[] data = {reviewDto.getReviewTitle(), reviewDto.getReviewContent(), reviewDto.getReviewNo()};
		return jdbcTemplate.update(sql, data) > 0;
	}
	
	public List<ReviewDto> selectList(){
		String sql = "select * from review";
		return jdbcTemplate.query(sql, reviewMapper);
	}
	
	//내가 작성한 후기 목록
	public List<ReviewDto> selectListByUserId(String userId) {
	    String sql = "select * from review where member_id = ?";
	    Object[] data = {userId};
	    return jdbcTemplate.query(sql, reviewMapper, data);
	}
	
	public ReviewDto selectOne(int reviewNo) {
		String sql = "select * from review where review_no = ?";
		Object[] data = {reviewNo};
		List<ReviewDto> list = jdbcTemplate.query(sql,  reviewMapper, data);
		return list.isEmpty() ? null:list.get(0);
	}
	
}
























