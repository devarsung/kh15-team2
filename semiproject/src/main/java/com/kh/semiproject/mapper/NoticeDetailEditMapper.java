package com.kh.semiproject.mapper;

import java.sql.ResultSet;
import java.sql.SQLException;

import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Component;

import com.kh.semiproject.dto.NoticeDetailEditDto;

@Component
public class NoticeDetailEditMapper implements RowMapper<NoticeDetailEditDto>{

	@Override
	public NoticeDetailEditDto mapRow(ResultSet rs, int rowNum) throws SQLException {
		return NoticeDetailEditDto.builder()
				.noticeNo(rs.getInt("notice_no"))
				.noticeTitle(rs.getString("notice_title"))
				.noticeContent(rs.getString("notice_content"))
				.noticeWtime(rs.getTimestamp("notice_wtime"))
				.noticeEtime(rs.getTimestamp("notice_etime"))
				.noticeWriter(rs.getString("notice_writer"))
				.noticeRead(rs.getInt("notice_read"))
				.memberId(rs.getString("member_id"))
				.memberNickname(rs.getString("member_nickname"))
				.build();
	}

}
