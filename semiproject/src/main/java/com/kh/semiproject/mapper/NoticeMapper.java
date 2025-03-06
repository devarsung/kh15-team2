package com.kh.semiproject.mapper;

import java.sql.ResultSet;
import java.sql.SQLException;

import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Component;

import com.kh.semiproject.dto.NoticeDto;

@Component
public class NoticeMapper implements RowMapper<NoticeDto>{

	@Override
	public NoticeDto mapRow(ResultSet rs, int rowNum) throws SQLException {
		return NoticeDto.builder()
				.noticeNo(rs.getInt("notice_no"))
				.noticeTitle(rs.getString("notice_title"))
				.noticeContent(rs.getString("notice_content"))
				.noticeWtime(rs.getTimestamp("notice_wtime"))
				.noticeEtime(rs.getTimestamp("notice_etime"))
				.noticeWriter(rs.getString("notice_writer"))
				.noticeRead(rs.getInt("notice_read"))
				.build();
	}

}
