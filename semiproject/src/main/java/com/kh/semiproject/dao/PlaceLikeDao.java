package com.kh.semiproject.dao;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import com.kh.semiproject.dto.PlaceLikeDto;
import com.kh.semiproject.mapper.PlaceLikeMapper;
import com.kh.semiproject.vo.RestPageVO;

@Repository
public class PlaceLikeDao {
	@Autowired
	private JdbcTemplate jdbcTemplate;
	@Autowired
	private PlaceLikeMapper placeLikeMapper;

	// 좋아요 설정
	public void insertPlaceLike(String memberId, int placeNo) {
		String sql = "insert into place_like(member_id, place_no) values(?, ?)";
		Object[] data = { memberId, placeNo };
		jdbcTemplate.update(sql, data);
	}

	// 좋아요 해제
	public void deletePlaceLike(String memberId, int placeNo) {
		String sql = "delete place_like where member_id=? and place_no=?";
		Object[] data = { memberId, placeNo };
		jdbcTemplate.update(sql, data);
	}

	// 좋아요 검사
	public boolean checkPlaceLike(String memberId, int placeNo) {
		String sql = "select count(*) from place_like " + "where member_id=? and place_no=?";
		Object[] data = { memberId, placeNo };
		return jdbcTemplate.queryForObject(sql, int.class, data) > 0;
	}

	// 좋아요 개수
	public int countPlaceLike(int placeNo) {
		String sql = "select count(*) from place_like where place_no=?";
		Object[] data = { placeNo };
		return jdbcTemplate.queryForObject(sql, int.class, data);
	}

	// 좋아요 개수를 갱신하는 메소드
	public boolean updatePlaceLike(int placeNo, int count) {
		String sql = "update place set place_like = ? where place_no = ?";
		Object[] data = { count, placeNo };
		return jdbcTemplate.update(sql, data) > 0;
	}

	// 내가 좋아요한 여행지 목록 조회 메소드
	public List<PlaceLikeDto> selectPlaceLikeList(String memberId) {
		String sql = "SELECT p.place_no, p.place_title, p.place_type, p.place_region, p.place_first_image, "
				+ "COUNT(pl.member_id) AS like_count " 
				+ "FROM place_like pl "
				+ "JOIN place p ON pl.place_no = p.place_no " 
				+ "WHERE pl.member_id = ? "
				+ "GROUP BY p.place_no, p.place_title, p.place_type, p.place_region, p.place_first_image "
				+ "ORDER BY like_count DESC";
		Object[] data = { memberId };
		return jdbcTemplate.query(sql, placeLikeMapper, data);
	}
	
	// 내가 좋아요한 여행지 갯수
	public int count(RestPageVO restPageVO) {
		String sql = "select count(*) from place_like where member_id = ?";
		Object[] data = {restPageVO.getMemberId()};
		return jdbcTemplate.queryForObject(sql, int.class, data);
	}

	public List<PlaceLikeDto> selectListRest(RestPageVO restPageVO) {
		String sql = "SELECT * FROM ("
				+ "				    SELECT rownum rn, TMP.*"
				+ "				    FROM ("
				+  "SELECT p.place_no, p.place_title, p.place_type, p.place_region, p.place_first_image, pl.place_like_time,"
					+ "COUNT(pl.member_id) AS like_count " 
					+ "FROM place_like pl "
					+ "JOIN place p ON pl.place_no = p.place_no " 
					+ "WHERE pl.member_id = ? "
					+ "GROUP BY p.place_no, p.place_title, p.place_type, p.place_region, p.place_first_image, pl.place_like_time "			
					+ "ORDER BY pl.place_like_time DESC"
					+ "				    ) TMP"
				+ "				)"
				+ "				WHERE rn BETWEEN ? AND ?";
		Object[] data = { restPageVO.getMemberId(), restPageVO.getStartRownum(), restPageVO.getFinishRownum() };
		return jdbcTemplate.query(sql, placeLikeMapper, data);
	}
}






























