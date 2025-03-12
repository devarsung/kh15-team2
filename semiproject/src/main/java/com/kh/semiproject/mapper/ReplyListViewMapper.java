package com.kh.semiproject.mapper;

import java.sql.ResultSet;
import java.sql.SQLException;

import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Component;

import com.kh.semiproject.dto.ReplyListViewDto;

@Component
public class ReplyListViewMapper implements RowMapper<ReplyListViewDto>{

	@Override
	public ReplyListViewDto mapRow(ResultSet rs, int rowNum) throws SQLException {
		
		return ReplyListViewDto.builder()
				.replyNo(rs.getInt("reply_no"))
				.replyWriter(rs.getString("reply_writer"))
				.replyOrigin(rs.getInt("reply_origin"))
				.replyContent(rs.getString("reply_content"))
				.replyWtime(rs.getTimestamp("reply_wtime"))
				.replyEtime(rs.getTimestamp("reply_etime"))
				.memberNickname(rs.getString("member_nickname"))
				.build();
	}
	
}
