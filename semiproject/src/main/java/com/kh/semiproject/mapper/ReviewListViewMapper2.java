package com.kh.semiproject.mapper;

import java.sql.ResultSet;
import java.sql.SQLException;

import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Component;

import com.kh.semiproject.dto.ReviewListViewDto2;

@Component
public class ReviewListViewMapper2 implements RowMapper<ReviewListViewDto2>{

	@Override
	public ReviewListViewDto2 mapRow(ResultSet rs, int rowNum) throws SQLException {
		
		return ReviewListViewDto2.builder()
				.reviewNo(rs.getInt("review_no"))
				.reviewTitle(rs.getString("review_title"))
				.reviewReply(rs.getInt("review_reply"))
				.reviewLike(rs.getInt("review_like"))
				.reviewWtime(rs.getTimestamp("review_wtime"))
				
				.memberNickname(rs.getString("member_nickname"))
				
				.build();
	}

}
