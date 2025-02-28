package com.kh.semiproject.dao;

import java.util.List;

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
	
	//시퀀스+등록메소드
	 public String sequence() {
		 String sql = "select member_seq.nextval from dual";
		 return jdbcTemplate.queryForObject(sql, String.class);
	 }
	 public void insert(MemberDto memberDto) {
		 String sql = "insert into member( "
					 		+ "member_id, member_pw, member_nickname, "
					 		+ "member_birth, member_gender, member_contact, "
					 		+ "member_email, member_post, member_address1, "
					 		+ "member_address2, member_level "
					 		+ ") "
					 		+ "values(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
		 Object[] data = {
			memberDto.getMemberId(), memberDto.getMemberPw(), memberDto.getMemberNickname(),
			memberDto.getMemberBirth(), memberDto.getMemberGender(), memberDto.getMemberContact(),
			memberDto.getMemberEmail(), memberDto.getMemberPost(), memberDto.getMemberAddress1(),
			memberDto.getMemberAddress2(), memberDto.getMemberLevel()
		 };
		 jdbcTemplate.update(sql, data);
	 }
	 
	 //수정메소드
	 public boolean update(MemberDto memberDto) {
		 String sql = "update member "
						 		+ "set "
						 		+ "member_nickname=?, member_birth=?, member_gender=?, "
						 		+ "member_contact=?, member_email=?, member_post=?, "
						 		+ "member_address1=?, member_address2=?, member_level=? "
						 		+ "where member_id=?";
		 Object[] data = {
			memberDto.getMemberNickname(), memberDto.getMemberBirth(), memberDto.getMemberGender(),
			memberDto.getMemberContact(), memberDto.getMemberEmail(), memberDto.getMemberPost(),
			memberDto.getMemberAddress1(), memberDto.getMemberAddress2(), memberDto.getMemberLevel(),
			memberDto.getMemberId()
		 };
		 return jdbcTemplate.update(sql, data) > 0;
	 }
	 
	 //삭제메소드
	 public boolean delete(String memberId) {
		 String sql = "delete member where member_id=?";
		 Object[] data = {memberId};
		 return jdbcTemplate.update(sql, data) > 0;
	 }
	 
	 //조회메소드
	 public List<MemberDto> selectList(){
		 String sql = "select * from member";
		 return jdbcTemplate.query(sql, memberMapper);
	 }
}
