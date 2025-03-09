package com.kh.semiproject.mapper;

import java.sql.ResultSet;
import java.sql.SQLException;

import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Component;

import com.kh.semiproject.dto.PlaceListViewDto;

@Component
public class PlaceListViewMapper implements RowMapper<PlaceListViewDto>{

	@Override
	public PlaceListViewDto mapRow(ResultSet rs, int rowNum) throws SQLException {
		return PlaceListViewDto.builder()
				.placeNo(rs.getInt("place_no"))
				.placeTitle(rs.getString("place_title"))
				.placeLike(rs.getInt("place_like"))
				.placeReview(rs.getInt("place_review"))
				.placeWtime(rs.getTimestamp("place_wtime"))
				.placeEtime(rs.getTimestamp("place_etime"))
				.placeRegion(rs.getString("place_region"))
				.placeWriter(rs.getString("place_writer"))
				.placeType(rs.getString("place_type"))
				.placeFirstImage(rs.getObject("place_first_image", Integer.class))
				.placeRead(rs.getInt("place_read"))
				.placeStar(rs.getObject("place_star", Double.class))
				.build();
	}
}
