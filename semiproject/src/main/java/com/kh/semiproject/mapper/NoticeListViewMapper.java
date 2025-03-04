package com.kh.semiproject.mapper;

import java.sql.ResultSet;
import java.sql.SQLException;

import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Component;

import com.kh.semiproject.dto.NoticeListViewDto;
@Component
public class NoticeListViewMapper implements RowMapper<NoticeListViewDto>{

	@Override
	public NoticeListViewDto mapRow(ResultSet rs, int rowNum) throws SQLException {
		return NoticeListViewDto.builder()
				.noticeNo(rs.getInt("notice_no"))
				.noticeTitle(rs.getString("notice_title"))
//				.noticeContent(rs.getString("notice_content"))
				.noticeWtime(rs.getTimestamp("notice_wtime"))
				.noticeEtime(rs.getTimestamp("notice_etime"))
				.noticeWriter(rs.getString("notice_writer"))
				
				.memberId(rs.getString("member_id"))
				.memberPw(rs.getString("member_pw"))
				.memberNickname(rs.getString("member_nickname"))
				.memberBirth(rs.getString("member_birth"))
				.memberGender(rs.getString("member_gender"))
				.memberContact(rs.getString("member_contact"))
				.memberEmail(rs.getString("member_email"))
				.memberPost(rs.getString("member_post"))
				.memberAddress1(rs.getString("member_address1"))
				.memberAddress2(rs.getString("member_address2"))
				.memberLevel(rs.getString("member_level"))
				.memberJoin(rs.getTimestamp("member_join"))
				.memberLogin(rs.getTimestamp("member_login"))
				.memberChange(rs.getTimestamp("member_change"))
				.build();
	}

}
