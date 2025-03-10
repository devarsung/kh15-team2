package com.kh.semiproject.dao;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import com.kh.semiproject.dto.ReplyDto;
import com.kh.semiproject.dto.ReviewDto;
import com.kh.semiproject.mapper.ReviewMapper;
import com.kh.semiproject.vo.PageVO;

@Repository
public class ReviewDao {
	@Autowired
	private JdbcTemplate jdbcTemplate;

	@Autowired
	private ReviewMapper reviewMapper;

	public int sequence() {
		String sql = "select review_seq.nextval from dual";
		return jdbcTemplate.queryForObject(sql, int.class);
	}

	public void insert(ReviewDto reviewDto) {
		String sql = "insert into review(review_no, review_title, review_content, review_writer, review_place, review_star) "
				+ "values(?,?,?,?,?,?)";
		Object[] data = {reviewDto.getReviewNo(), reviewDto.getReviewTitle(), reviewDto.getReviewContent(), reviewDto.getReviewWriter(),
				reviewDto.getReviewPlace(), reviewDto.getReviewStar() };
		jdbcTemplate.update(sql, data);
	}

	public boolean delete(int reviewNo) {
		String sql = "delete from review where review_no = ?";
		Object[] data = { reviewNo };
		return jdbcTemplate.update(sql, data) > 0;
	}

	public boolean update(ReviewDto reviewDto) {
		String sql = "update review set review_title = ?, review_content = ?, review_etime = systimestamp where review_no =?";
		Object[] data = { reviewDto.getReviewTitle(), reviewDto.getReviewContent(), reviewDto.getReviewNo() };
		return jdbcTemplate.update(sql, data) > 0;
	}

	public List<ReviewDto> selectList() {
		String sql = "select * from review";
		return jdbcTemplate.query(sql, reviewMapper);
	}

	// 내가 작성한 후기 목록
	public List<ReviewDto> selectListByUserId(String userId) {
		String sql = "select * from review where member_id = ?";
		Object[] data = { userId };
		return jdbcTemplate.query(sql, reviewMapper, data);
	}

	public ReviewDto selectOne(int reviewNo) {
		String sql = "select * from review where review_no = ?";
		Object[] data = { reviewNo };
		List<ReviewDto> list = jdbcTemplate.query(sql, reviewMapper, data);
		return list.isEmpty() ? null : list.get(0);
	}

//	public int count(PageVO pageVO) {
//		if (pageVO.isList()) {
//			String sql = "select count(*) from review";
//			return jdbcTemplate.queryForObject(sql, int.class);
//		} else if(pageVO.search()){
//			String sql = "select count(*) from review where instr(#1, ?) > 0";
//			sql = sql.replace("#1", pageVO.getColumn());
//			Object[] data = { pageVO.getKeyword() };
//			return jdbcTemplate.queryForObject(sql, int.class, data);
//		}
//		else if(pageVO.byPlace()) {
//			String sql = "select count(*) from review where review_place = ?";
//			Object[] data = {pageVO.getPlaceNo()};
//			return jdbcTemplate.queryForObject(sql,int.class,data );
//		}
//		else {
//			return 1;
//		}
//	}

	// 댓글 수 갱신 메소드
	public boolean updateReviewReply(int reviewNo) {
		String sql = "update review set review_reply = (" + "select count(*) from reply where reply_origin =?"
				+ ") where review_no = ?";
		Object[] data = { reviewNo, reviewNo };// 홀더 개수와 순서에 맞게
		return jdbcTemplate.update(sql, data) > 0;
	}

	

	
	


	// 조회수 1 증가 메소드
	public boolean updateReviewRead(int reviewNo) {
		String sql = "update review " + "set review_read=review_read+1 " + "where review_no=?";
		Object[] data = { reviewNo };
		return jdbcTemplate.update(sql, data) > 0;
	}

}


















