package com.kh.semiproject.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.kh.semiproject.dao.MemberDao;
import com.kh.semiproject.dto.MemberDto;

import jakarta.servlet.http.HttpSession;

@Controller
@RequestMapping("/member")
public class MemberController {
	@Autowired
	private MemberDao memberDao;
	
	@GetMapping("/join")
	public String join() {
		return "/WEB-INF/views/member/join.jsp";
	}
	
	@PostMapping("/join")
	public String join(@ModelAttribute MemberDto memberDto) {
		memberDao.insert(memberDto);//회원가입
		return "redirect:joinFinish";
	}
	
	@RequestMapping("/joinFinish")
	public String joinFinish() {
		return "/WEB-INF-views/member/joinFinish.jsp";
	}
	
	@GetMapping("/login")
	public String login() {
		return "/WEB-INF/views/member/login.jsp";
	}
	
	@PostMapping("/login")
	public String login(@ModelAttribute MemberDto memberDto, 
											HttpSession session) {
		MemberDto findDto = memberDao.selectOne(memberDto.getMemberId());
		//아이디가 없으면 findDto = null
		if(findDto == null) {
			return "redirect:login?error";//로그인 페이지로 쫒아내기
		}
		boolean isValid = findDto.getMemberPw().equals(memberDto.getMemberPw());
		if(isValid) {//로그인 성공시
			session.setAttribute("userId", findDto.getMemberId());//userId란 이름으로 사용자의 ID 저장
			return "redirect:/";
		}
		else {//로그인 실패시
			return "redirect:login?error";//로그인 페이지로 쫒아내기
		}
	}
}
