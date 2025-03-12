package com.kh.semiproject.mapper;

import java.sql.ResultSet;
import java.sql.SQLException;

import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Component;

import com.kh.semiproject.dto.ReviewListViewDto;

@Component
public class ReviewListViewMapper implements RowMapper<ReviewListViewDto>{

	@Override
	public ReviewListViewDto mapRow(ResultSet rs, int rowNum) throws SQLException {
		
		return ReviewListViewDto.builder()
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
				
				.memberId(rs.getString("member_id"))
				.memberNickname(rs.getString("member_nickname"))
				
				.placeNo(rs.getInt("place_no"))
				.placeTitle(rs.getString("place_title"))
				.build();
	}

}
