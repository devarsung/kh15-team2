package com.kh.semiproject.mapper;

import java.sql.ResultSet;
import java.sql.SQLException;

import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Component;

import com.kh.semiproject.dto.HelpDto;

@Component
public class HelpMapper implements RowMapper<HelpDto>{

	@Override
	public HelpDto mapRow(ResultSet rs, int rowNum) throws SQLException {
		return HelpDto.builder()
				.helpNo(rs.getInt("help_no"))
				.helpTitle(rs.getString("help_title"))
				.helpContent(rs.getString("help_content"))
				.helpPlace(rs.getString("help_place"))
				.helpWriter(rs.getString("help_writer"))
				.helpDepth(rs.getInt("help_depth"))
				.helpTarget(rs.getInt("help_target"))
				.helpWtime(rs.getTimestamp("help_wtime"))
				.helpEtime(rs.getTimestamp("help_etime"))
				
				.build();
	}

}
