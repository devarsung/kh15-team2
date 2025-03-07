package com.kh.semiproject.mapper;

import java.sql.ResultSet;
import java.sql.SQLException;

import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Component;

import com.kh.semiproject.vo.StatusVO;

@Component
public class StatusMapper implements RowMapper<StatusVO>{

	@Override
	public StatusVO mapRow(ResultSet rs, int rowNum) throws SQLException {
		StatusVO statusVO = new StatusVO();
		statusVO.setKey(rs.getString("key"));
		statusVO.setValue(rs.getLong("value"));
		return statusVO;
	}
}
