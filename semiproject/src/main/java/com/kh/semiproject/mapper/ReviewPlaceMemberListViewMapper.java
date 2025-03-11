package com.kh.semiproject.mapper;

import java.sql.ResultSet;
import java.sql.SQLException;

import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Component;

import com.kh.semiproject.dto.ReviewPlaceMemberListViewDto;

@Component
public class ReviewPlaceMemberListViewMapper implements RowMapper<ReviewPlaceMemberListViewDto>{

	@Override
	public ReviewPlaceMemberListViewDto mapRow(ResultSet rs, int rowNum) throws SQLException {
		return ReviewPlaceMemberListViewDto.builder()
				.reviewNo(rs.getInt("review_no"))
				.reviewTitle(rs.getString("review_title"))
				.reviewLike(rs.getInt("review_like"))
				.reviewRead(rs.getInt("review_read"))
				.reviewStar(rs.getInt("review_star"))
				.reviewWtime(rs.getTimestamp("review_wtime"))
				.reviewWriter(rs.getString("review_writer"))
				.reviewPlace(rs.getInt("review_place"))
				
				.memberId(rs.getString("member_id"))
				.memberNickname(rs.getString("member_nickname"))
//				
				.placeNo(rs.getInt("place_no"))
				.placeTitle(rs.getString("place_title"))
		//		.totalLikesAndReads(rs.getInt("total_likes_and_reads"))
				.build();
	}

}
