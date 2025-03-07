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
