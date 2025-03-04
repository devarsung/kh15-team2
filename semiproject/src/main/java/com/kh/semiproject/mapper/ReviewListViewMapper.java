package com.kh.semiproject.mapper;

import java.sql.ResultSet;
import java.sql.SQLException;

import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Component;

import com.kh.semiproject.dto.ReviewListViewDto;

@Component
public class ReviewListViewMapper implements RowMapper<ReviewListViewDto>{

	@Override
	public ReviewListViewDto mapRow(ResultSet rs, int rowNum) throws SQLException {
		
		return ReviewListViewDto.builder()
				.reviewNo(rs.getInt("review_no"))
				.reviewTitle(rs.getString("review_title"))
				.reviewContent(rs.getString("review_content"))				
				.reviewLike(rs.getInt("review_like"))
				.reviewRead(rs.getInt("review_read"))
				.reviewReply(rs.getInt("review_reply"))
				.reviewWtime(rs.getTimestamp("review_wtime"))
				.reviewEtime(rs.getTimestamp("review_etime"))
				.reviewWriter(rs.getString("review_writer"))
				.reviewPlace(rs.getString("review_place"))
				
				
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
