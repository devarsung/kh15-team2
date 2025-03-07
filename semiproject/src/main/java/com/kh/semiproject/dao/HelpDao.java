package com.kh.semiproject.dao;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import com.kh.semiproject.dto.HelpDto;
import com.kh.semiproject.mapper.HelpMapper;

@Repository
public class HelpDao {
	@Autowired
	private JdbcTemplate jdbcTemplate;
	
	@Autowired
	private HelpMapper helpMapper;
	
	public int sequence() {
		String sql = "select help_seq.nextval from dual";
		return jdbcTemplate.queryForObject(sql, int.class);
	}
	
	public void inesrt(HelpDto helpDto) {
		String sql = "insert into help(help_no, help_title, help_content, help_place, help_writer, help_depth, help_target) "
				+ "values(?,?,?,?,?,?,?)";
		Object[] data = {
				helpDto.getHelpNo(), helpDto.getHelpTitle(), helpDto.getHelpContent(), helpDto.getHelpPlace(), helpDto.getHelpWriter(),
				helpDto.getHelpDepth(), helpDto.getHelpTarget()
		};
		jdbcTemplate.update(sql, data);
	}
	
	public void delete(int helpNo) {
		String sql = "delete    ";
	}
	
	public void update(int helpNo) {
		
	}
	
	public HelpDto selectOne(int helpNo) {
		String sql = "select * from help where help_no=?";
		Object[] data = {helpNo};
		List<HelpDto> list = jdbcTemplate.query(sql, helpMapper, data);
		return list.isEmpty() ? null:list.get(0);
	}
}















