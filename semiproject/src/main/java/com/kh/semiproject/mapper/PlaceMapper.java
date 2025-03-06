package com.kh.semiproject.mapper;

import java.sql.ResultSet;
import java.sql.SQLException;

import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Component;

import com.kh.semiproject.dto.PlaceDto;

@Component
public class PlaceMapper implements RowMapper<PlaceDto>{

	@Override
	public PlaceDto mapRow(ResultSet rs, int rowNum) throws SQLException {
		return PlaceDto.builder()
				.placeNo(rs.getInt("place_no"))
				.placeTitle(rs.getString("place_title"))
				.placeOverview(rs.getString("place_overview"))
				.placePost(rs.getString("place_title"))
				.placeAddress1(rs.getString("place_address1"))
				.placeAddress2(rs.getString("place_address2"))
				.placeLike(rs.getInt("place_like"))
				.placeReview(rs.getInt("place_review"))
				.placeWtime(rs.getTimestamp("place_wtime"))
				.placeEtime(rs.getTimestamp("place_etime"))
				.placeRegion(rs.getString("place_region"))
				.placeWriter(rs.getString("place_writer"))
				.placeLat(rs.getObject("place_lat", Double.class))
				.placeLng(rs.getObject("place_lng", Double.class))
				.placeType(rs.getString("place_type"))
				.placeFirstImage(rs.getInt("place_first_image"))
				.placeView(rs.getInt("place_view"))
				.build();
	}

}
