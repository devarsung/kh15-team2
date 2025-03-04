package com.kh.semiproject.dao;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import com.kh.semiproject.dto.PlaceDto;
import com.kh.semiproject.mapper.PlaceMapper;
import com.kh.semiproject.vo.PageVO;

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
		String sql = "insert into place(place_title, place_overview, place_post, place_address1, place_address2, place_legion, place_writer, place_lat, place_lng, place_type) "
				+ "valuse(?,?,?,?,?,?,?)";
		Object[] data = {placeDto.getPlaceTitle(), placeDto.getPlaceOverview(), placeDto.getPlacePost(), placeDto.getPlaceAddress1(), placeDto.getPlaceAddress2(), placeDto.getPlaceLegion(), placeDto.getPlaceWriter()};
		jdbcTemplate.update(sql, data);
	}
	
	public boolean delete(int placeNo) {
		String sql = "delete from place where place_no = ?";
		// 추가 이미지 삭제
		
		Object[] data = {placeNo};
		return jdbcTemplate.update(sql, data) > 0;
	}
	
	public boolean update(PlaceDto placeDto) {
		String sql = "update place set place_title=?, place_content=?, place_post=? place_address1=?, place_address2=?, place_legion=? where place_no =?";
		Object[] data = {placeDto.getPlaceTitle(), placeDto.getPlaceOverview(), placeDto.getPlacePost(), placeDto.getPlaceAddress1(), placeDto.getPlaceAddress2(), placeDto.getPlaceLegion(), placeDto.getPlaceNo()};
		return jdbcTemplate.update(sql, data) > 0;
	}
	
	public int count(PageVO pageVO) {
		String sql = "";
		if(pageVO.isList()) {
			sql = "select count(*) from place";
			return jdbcTemplate.queryForObject(sql, int.class);
		}
		else {
			sql = "select count(*) from place where instr(#1, ?) > 0";
			sql = sql.replace("#1", pageVO.getColumn());
			Object[] data = {pageVO.getKeyword()};
			return jdbcTemplate.queryForObject(sql,  int.class, data);
		}
	}
	
	
	public List<PlaceDto> selectList(PageVO pageVO){
		String sql = "";
		if(pageVO.isList()) {
		sql =  "select * from ("
            + "select rownum rn, TMP.* from ("
                + "select * from place"
                + "order  place_no asc"
            + ") TMP"
            + ") where rn between ? and ?";
		return jdbcTemplate.query(sql, placeMapper);
		}
		else{
			sql = "select * from ("
		            + "select rownum rn, TMP.* from ("
		                + "select * from place "
		                + "where instr(#1, ?) > 0 "
		                + "order by place_no asc"
		            + ") TMP"
		            + ") where rn between ? and ?";
			
			sql.replace("#1", pageVO.getColumn());
			Object[] data = {pageVO.getKeyword(), pageVO.getStartRownum(), pageVO.getFinishRownum()};
			return jdbcTemplate.query(sql, placeMapper, data);
		}
		
	}
	
	public PlaceDto selectOne(int placeNo) {
		String sql = "select * from where place_no = ?";
		Object[] data = {placeNo};
		List<PlaceDto> list = jdbcTemplate.query(sql,  placeMapper, data);
		return list.isEmpty() ? null:list.get(0);
	}
	
//	public int findAttachment(int placeFirstImageNo) {
//		String sql = "select * from attachment where attachment_no = ?";
//		Object[] data = {placeFirstImageNo};
//		
//	}
}


























