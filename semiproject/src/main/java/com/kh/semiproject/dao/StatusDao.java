package com.kh.semiproject.dao;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import com.kh.semiproject.mapper.StatusMapper;
import com.kh.semiproject.vo.StatusVO;

@Repository
public class StatusDao {
	@Autowired
	private JdbcTemplate jdbcTemplate;
	@Autowired
	private StatusMapper statusMapper;

	// 회원 성별 현황
	public List<StatusVO> memberGenderGroup() {
		String sql = "select member_gender key, count(*) value from member " + "group by member_gender "
				+ "order by value desc, key asc";
		return jdbcTemplate.query(sql, statusMapper);
	}


}
