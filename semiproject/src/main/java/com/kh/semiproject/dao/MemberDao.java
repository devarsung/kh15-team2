package com.kh.semiproject.dao;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import com.kh.semiproject.dto.MemberDto;
import com.kh.semiproject.mapper.MemberMapper;

@Repository
public class MemberDao {
	@Autowired
	private MemberMapper memberMapper;
	@Autowired
	private JdbcTemplate jdbcTemplate;
	
	//시퀀스+등록
	 public String sequence() {
		 String sql = "select member_seq.nextval from dual";
		 return jdbcTemplate.queryForObject(sql, String.class);
	 }
	 public void insert(MemberDto memberDto) {
		 String sql = "insert into member( "
		 		+ "member_id, member_pw, member_nickname, "
		 		+ "member_birth, member_gender, member_contact, "
		 		+ "member_email, member_post, member_address1, "
		 		+ "member_address2, member_level, member_join, "
		 		+ "member_login, member_change "
		 		+ ") "
		 		+ "values(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
		 Object[] data = {
			memberDto.getMemberId(), memberDto.getMemberPw(), memberDto.getMemberNickname(),
			memberDto.getMemberBirth(), memberDto.getMemberGender(), memberDto.getMemberContact(),
			memberDto.getMemberEmail(), memberDto.getMemberPost(), memberDto.getMemberAddress1(),
			memberDto.getMemberAddress2(), memberDto.getMemberLevel(), memberDto.getMemberJoin(),
			memberDto.getMemberLogin(), memberDto.getMemberChange()
		 };
		 jdbcTemplate.update(sql, data);
	 }
}
