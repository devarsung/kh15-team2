package com.kh.semiproject.mapper;

import java.sql.ResultSet;
import java.sql.SQLException;

import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Component;

import com.kh.semiproject.dto.MyReviewDto;

@Component
public class MyReviewMapper implements RowMapper<MyReviewDto>{

	@Override
	public MyReviewDto mapRow(ResultSet rs, int rowNum) throws SQLException {
		return MyReviewDto.builder()
				.reviewNo(rs.getInt("review_no"))
				.reviewTitle(rs.getString("review_title"))
				.reviewWriter(rs.getString("review_writer"))
				.reviewLike(rs.getInt("review_like"))
				.reviewRead(rs.getInt("review_read"))
				.reviewReply(rs.getInt("review_reply"))
				.reviewWtime(rs.getTimestamp("review_wtime"))
				.reviewEtime(rs.getTimestamp("review_etime"))
				.build();
	}

}
