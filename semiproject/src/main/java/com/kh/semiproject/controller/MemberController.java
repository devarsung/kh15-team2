package com.kh.semiproject.controller;

import java.io.IOException;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.kh.semiproject.dao.MemberDao;
import com.kh.semiproject.dto.MemberDto;
import com.kh.semiproject.service.AttachmentService;

import jakarta.servlet.http.HttpSession;

@Controller
@RequestMapping("/member")
public class MemberController {
	@Autowired
	private MemberDao memberDao;
	@Autowired
	private AttachmentService attachmentService;
	
	//회원가입 매핑
	@GetMapping("/join")
	public String join() {
		return "/WEB-INF/views/member/join.jsp";
	}
	@PostMapping("/join")
	public String join(@ModelAttribute MemberDto memberDto,
										@RequestParam MultipartFile attach) throws IllegalStateException, IOException {
		String memberId = memberDao.sequence();
		memberDto.setMemberId(memberId);
		memberDao.insert(memberDto);
		if(attach.isEmpty()==false) {
		//첨부파일 등록
		int attachmentNo = attachmentService.save(attach);
		//회원 프로필 등록
		memberDao.connect(memberId, attachmentNo);
		}
		return "redirect:joinFinish";
	}
	@RequestMapping("/joinFinish")
	public String joinFinish() {
		return "/WEB-INF/views/member/joinFinish.jsp";
	}
	
	//로그인 매핑
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
		//아이디가 있으면 비밀번호 검사를 진행
		boolean isValid = findDto.getMemberPw().equals(memberDto.getMemberPw());
		if(isValid) {//로그인 성공시
			//userId란 이름으로 사용자의 ID 저장
			session.setAttribute("userId", findDto.getMemberId());
			//userLevel이란 이름으로 사용자 등급 저장
			session.setAttribute("userLevel", findDto.getMemberLevel());
			//최종로그인시각 갱신 처리
			memberDao.updateMemberLogin(findDto.getMemberId());
			return "redirect:/";
		}
		else {//로그인 실패시
			return "redirect:login?error";//로그인 페이지로 쫒아내기
		}
	}
	   
	//로그아웃 매핑
	@RequestMapping("/logout")
	public String logout(HttpSession session) {
		session.removeAttribute("userId");
		return "redirect:/";
	}
	
	//마이페이지 매핑
	@RequestMapping("/mypage")
	public String mypage(HttpSession session, Model model) {
		String userId = (String) session.getAttribute("userId");//내 아이디 추출
		MemberDto  memberDto = memberDao.selectOne(userId);//내정보 획득
		model.addAttribute("memberDto", memberDto);
		return "/WEB-INF/views/member/mypage.jsp";
	}
}
