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

	// 시퀀스+등록 메소드
	public String sequence() {
		String sql = "select member_seq.nextval from dual";
		return jdbcTemplate.queryForObject(sql, String.class);
	}

	public void insert(MemberDto memberDto) {
		String sql = "insert into member( " + "member_id, member_pw, member_nickname, "
				+ "member_birth, member_gender, member_contact, " + "member_email, member_post, member_address1, "
				+ "member_address2" + ") " + "values(?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
		Object[] data = { memberDto.getMemberId(), memberDto.getMemberPw(), memberDto.getMemberNickname(),
				memberDto.getMemberBirth(), memberDto.getMemberGender(), memberDto.getMemberContact(),
				memberDto.getMemberEmail(), memberDto.getMemberPost(), memberDto.getMemberAddress1(),
				memberDto.getMemberAddress2()};
		jdbcTemplate.update(sql, data);
	}

	// 수정 메소드
	public boolean update(MemberDto memberDto) {
		String sql = "update member " + "set " + "member_nickname=?, member_birth=?, member_gender=?, "
				+ "member_contact=?, member_email=?, member_post=?, " + "member_address1=?, member_address2=? "
				+ "where member_id=?";
		Object[] data = { memberDto.getMemberNickname(), memberDto.getMemberBirth(), memberDto.getMemberGender(),
				memberDto.getMemberContact(), memberDto.getMemberEmail(), memberDto.getMemberPost(),
				memberDto.getMemberAddress1(), memberDto.getMemberAddress2(), memberDto.getMemberId() };
		return jdbcTemplate.update(sql, data) > 0;
	}

	// 회원 탈퇴 메소드(삭제)
	public boolean delete(String memberId) {
		String sql = "delete member where member_id=?";
		Object[] data = { memberId };
		return jdbcTemplate.update(sql, data) > 0;
	}

	// 조회 메소드
	public List<MemberDto> selectList() {
		String sql = "select * from member";
		return jdbcTemplate.query(sql, memberMapper);
	}

	// 상세조회 메소드
	public MemberDto selectOne(String memberId) {
		String sql = "select * from member where member_id=?";
		Object[] data = { memberId };
		List<MemberDto> list = jdbcTemplate.query(sql, memberMapper, data);
		return list.isEmpty() ? null : list.get(0);
	}
	
	//상세조회(회원닉네임) 메소드
	public MemberDto selectOneByMemberNickname(String memberNickname) {
		String sql = "select * from member where member_nickname=?";
		Object[] data = {memberNickname};
		List<MemberDto> list = jdbcTemplate.query(sql, memberMapper, data);
		return list.isEmpty() ? null : list.get(0);
	}
	
	// 최종 로그인 시각 갱신 메소드
	public boolean updateMemberLogin(String memberId) {
		String sql = "update member set member_login=systimestamp " + "where member_id=?";
		Object[] data = { memberId };
		return jdbcTemplate.update(sql, data) > 0;
	}

	// 비밀번호 변경(최종 비밀번호 변경일도 같이 변경) 메소드
	public boolean updateMemberPassword(MemberDto memberDto) {
		String sql = "update member " + "set member_pw=?, member_change=systimestamp " + "where member_id=?";
		Object[] data = { memberDto.getMemberPw(), memberDto.getMemberId() };
		return jdbcTemplate.update(sql, data) > 0;
	}

	// 개인정보 변경 메소드
	public boolean updateChange(MemberDto memberDto) {
		String sql = "update member " + "set " + "member_nickname=?, member_birth=?, member_gender=?, "
				+ "member_contact=?, member_email=?, member_post=?, " + "member_address1=?, member_address2=? "
				+ "where member_id=?";
		Object[] data = { memberDto.getMemberNickname(), memberDto.getMemberBirth(), memberDto.getMemberGender(),
				memberDto.getMemberContact(), memberDto.getMemberEmail(), memberDto.getMemberPost(),
				memberDto.getMemberAddress1(), memberDto.getMemberAddress2(), memberDto.getMemberId() };
		return jdbcTemplate.update(sql, data) > 0;
	}

	// 회원 프로필 등록(연결)
	public void connect(String memberId, int attachmentNo) {
		String sql = "insert into member_profile ( " + "member_id, attachment_no " + ") " + "values(?, ?)";
		Object[] data = { memberId, attachmentNo };
		jdbcTemplate.update(sql, data);
	}
	
	//회원 프로필 삭제
	public void deleteProfile(String memberId) {
	    String sql = "delete from member_profile where member_id = ?";
	    jdbcTemplate.update(sql, memberId);
	}
	
	//회원 이미지 찾기
	public Integer findAttachment(String memberId) {
	    String sql = "select attachment_no from member_profile where member_id = ?";
	    try {
	        return jdbcTemplate.queryForObject(sql, Integer.class, memberId);
	    } catch (Exception e) {
	        return null;  // 결과가 없으면 null 반환
	    }
	}
}