package com.kh.semiproject.dao;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import com.kh.semiproject.dto.PlaceDto;
import com.kh.semiproject.dto.PlaceLikeDto;
import com.kh.semiproject.mapper.PlaceMapper;

@Repository
public class PlaceDao {
	@Autowired
	private JdbcTemplate jdbcTemplate;
	
	@Autowired
	private PlaceMapper placeMapper;
	
	public int sequence() {
		String sql = "select place_seq.nextval from dual";
		return jdbcTemplate.queryForObject(sql,  int.class);
	}
	
	public void insert(PlaceDto placeDto) {
		int placeNo = this.sequence();
		placeDto.setPlaceNo(placeNo);
		String sql = "insert into place(place_title, place_overview, place_post, place_address1, place_address2, place_legion, place_writer) "
				+ "valuse(?,?,?,?,?,?,?)";
		Object[] data = {placeDto.getPlaceTitle(), placeDto.getPlaceOverview(), placeDto.getPlacePost(), placeDto.getPlaceAddress1(), placeDto.getPlaceAddress2(), placeDto.getPlaceLegion(), placeDto.getPlaceWriter()};
		jdbcTemplate.update(sql, data);
	}
	
	public boolean delete(int placeNo) {
		String sql = "delete from place where place_no = ?";
		Object[] data = {placeNo};
		return jdbcTemplate.update(sql, data) > 0;
	}
	
	public boolean update(PlaceDto placeDto) {
		String sql = "update place set place_title=?, place_content=?, place_post=? place_address1=?, place_address2=?, place_legion=? where place_no =?";
		Object[] data = {placeDto.getPlaceTitle(), placeDto.getPlaceOverview(), placeDto.getPlacePost(), placeDto.getPlaceAddress1(), placeDto.getPlaceAddress2(), placeDto.getPlaceLegion(), placeDto.getPlaceNo()};
		return jdbcTemplate.update(sql, data) > 0;
	}
	
	public List<PlaceDto> selectList(){
		String sql = "select * from place";
		return jdbcTemplate.query(sql, placeMapper);
	}
	
	public PlaceDto selectOne(int placeNo) {
		String sql = "select * from where place_no = ?";
		Object[] data = {placeNo};
		List<PlaceDto> list = jdbcTemplate.query(sql,  placeMapper, data);
		return list.isEmpty() ? null:list.get(0);
	}
	
}


























