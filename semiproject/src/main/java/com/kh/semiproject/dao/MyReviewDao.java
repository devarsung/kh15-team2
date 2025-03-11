package com.kh.semiproject.dao;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import com.kh.semiproject.dto.MyReviewDto;
import com.kh.semiproject.mapper.MyReviewMapper;
@Repository
public class MyReviewDao {
	@Autowired
	private JdbcTemplate jdbcTemplate;
	@Autowired
	private MyReviewMapper myReviewMapper;
	
	public List<MyReviewDto> selectMyReviewList(String memberId) {
	    String sql = "SELECT review_no, review_title, review_writer, review_wtime, " +
	                 "review_read, review_like, review_reply, review_etime " +
	                 "FROM review " +
	                 "WHERE review_writer = ? " +
	                 "ORDER BY review_wtime DESC";
	    Object[] data = {memberId};
	    return jdbcTemplate.query(sql, myReviewMapper, data);
	}
}
