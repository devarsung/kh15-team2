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
				.memberId(rs.getString("memberId"))
				.memberNickname(rs.getString("member_nickname"))
				
				.reviewNo(rs.getInt("review_no"))
				.reviewTitle(rs.getString("review_title"))
				
				.placeNo(rs.getInt("place_no"))
				.placeTitle(rs.getString("place_title"))
				
				.build();
	}

}
