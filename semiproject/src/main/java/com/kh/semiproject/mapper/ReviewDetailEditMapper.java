package com.kh.semiproject.mapper;

import java.sql.ResultSet;
import java.sql.SQLException;

import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Component;

import com.kh.semiproject.dto.ReviewDetailEditDto;

@Component
public class ReviewDetailEditMapper implements RowMapper<ReviewDetailEditDto>{

	@Override
	public ReviewDetailEditDto mapRow(ResultSet rs, int rowNum) throws SQLException {
		return ReviewDetailEditDto.builder()
				
				.reviewNo(rs.getInt("review_no"))
				.reviewTitle(rs.getString("review_title"))
				.reviewContent(rs.getString("review_content"))
				.reviewLike(rs.getInt("review_like"))
				.reviewRead(rs.getInt("review_read"))
				.reviewStar(rs.getInt("review_star"))
				.reviewWtime(rs.getTimestamp("review_wtime"))
				.reviewWriter(rs.getString("review_writer"))
				.reviewPlace(rs.getInt("review_place"))
				.reviewReply(rs.getInt("review_reply"))
				
				.memberId(rs.getString("member_id"))
				.memberNickname(rs.getString("member_nickname"))
//				
				.placeNo(rs.getInt("place_no"))
				.placeTitle(rs.getString("place_title"))
		//		.totalLikesAndReads(rs.getInt("total_likes_and_reads"))
				.build();
	}

}
