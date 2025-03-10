package com.kh.semiproject.mapper;

import java.sql.ResultSet;
import java.sql.SQLException;

import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Component;

import com.kh.semiproject.dto.PlaceLikeDto;

@Component
public class PlaceLikeMapper implements RowMapper<PlaceLikeDto>{

	@Override
	public PlaceLikeDto mapRow(ResultSet rs, int rowNum) throws SQLException {
		return PlaceLikeDto.builder()
				.placeNo(rs.getInt("place_no"))
				.placeTitle(rs.getString("place_title"))
				.placeRegion(rs.getString("place_region"))
				.placeType(rs.getString("place_type"))
				.placeFirstImage(rs.getInt("place_first_image"))
				.likeCount(rs.getInt("like_count"))
				.build();
	}

}
