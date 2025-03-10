package com.kh.semiproject.dao;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import com.kh.semiproject.dto.ReviewPlaceMemberListViewDto;
import com.kh.semiproject.mapper.ReviewPlaceMemberListViewMapper;

@Repository
public class ReviewPlaceMemberListViewDao {
	@Autowired
	private ReviewPlaceMemberListViewMapper reviewPlaceMemberListViewMapper;
	@Autowired
	private JdbcTemplate jdbcTemplate;
	
	
	// top 5
	public List<ReviewPlaceMemberListViewDto> selectListOnReview(){
		String sql = "select * from("
				+ "select rownum rn, MEMBER_ID, member_nickname, review_no,review_place,  place_no, place_title "
				+ "from review_place_member_list_view) where rn between 1 and 5";
		return jdbcTemplate.query(sql, reviewPlaceMemberListViewMapper);
	}
	
	
}
