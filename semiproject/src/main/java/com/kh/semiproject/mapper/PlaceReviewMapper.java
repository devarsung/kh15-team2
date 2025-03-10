package com.kh.semiproject.mapper;

import java.sql.ResultSet;
import java.sql.SQLException;

import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Component;

import com.kh.semiproject.dto.PlaceReviewDto;

@Component
public class PlaceReviewMapper implements RowMapper<PlaceReviewDto>{

	@Override
	public PlaceReviewDto mapRow(ResultSet rs, int rowNum) throws SQLException {
		return PlaceReviewDto.builder()
				.placeNo(rs.getInt("place_no"))
	            .placeTitle(rs.getString("place_title"))
	            .placeOverview(rs.getString("place_overview"))
	            .placeFirstImage(rs.getInt("place_first_image"))
	            .avgReviewStar(rs.getDouble("avg_review_star")) 
				.build();
	}

}
