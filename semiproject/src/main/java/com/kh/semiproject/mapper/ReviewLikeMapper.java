package com.kh.semiproject.mapper;

import java.sql.ResultSet;
import java.sql.SQLException;

import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Component;

import com.kh.semiproject.dto.ReviewLikeDto;

@Component
public class ReviewLikeMapper implements RowMapper<ReviewLikeDto>{

	@Override
	public ReviewLikeDto mapRow(ResultSet rs, int rowNum) throws SQLException {
		return ReviewLikeDto.builder()
				.reviewNo(rs.getInt("review_no"))
				.likeCount(rs.getInt("like_count"))
				.reviewTitle(rs.getString("review_title"))
				.reviewRead(rs.getInt("review_read"))
				.reviewWtime(rs.getTimestamp("review_wtime"))
				.reviewWriter(rs.getString("review_writer"))
				.build();
	}

}
