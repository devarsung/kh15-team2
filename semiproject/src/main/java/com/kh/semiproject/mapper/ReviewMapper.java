package com.kh.semiproject.mapper;

import java.sql.ResultSet;
import java.sql.SQLException;

import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Component;

import com.kh.semiproject.dto.ReviewDto;

@Component
public class ReviewMapper implements RowMapper<ReviewDto>{

	@Override
	public ReviewDto mapRow(ResultSet rs, int rowNum) throws SQLException {
		return ReviewDto.builder()
				.reviewNo(rs.getInt("review_no"))
				.reviewTitle(rs.getString("review_title"))
				.reviewContent(rs.getString("review_content"))				
				.reviewLike(rs.getInt("review_like"))
				.reviewRead(rs.getInt("review_read"))
				.reviewReply(rs.getInt("review_reply"))
				.reviewWtime(rs.getTimestamp("review_wtime"))
				.reviewEtime(rs.getTimestamp("review_etime"))
				.reviewWriter(rs.getString("review_writer"))
				.reviewPlace(rs.getString("review_place"))
				.reviewStar(rs.getFloat("review_star"))
				.build();
	}

}
