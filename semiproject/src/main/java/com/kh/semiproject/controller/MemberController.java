package com.kh.semiproject.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.kh.semiproject.dao.MemberDao;
import com.kh.semiproject.dto.MemberDto;

import jakarta.servlet.http.HttpSession;

@Controller
@RequestMapping("/member")
public class MemberController {
	@Autowired
	private MemberDao memberDao;
	
	//회원가입 매핑
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
	
	//비밀번호 변경 매핑
	@GetMapping("/password")
	public String password() {
		return "/WEB-INF/views/member/password.jsp";
	}
	@PostMapping("/password")
	public String password(@RequestParam String currentPw,
													@RequestParam String newPw, HttpSession session) {
		String userId = (String) session.getAttribute("userId");//내 아이디 추출
		MemberDto memberDto = memberDao.selectOne(userId);//내정보 획득
		boolean isValid = currentPw.equals(memberDto.getMemberPw());
		if(isValid == false) {//비밀번호 불일치
			return "redirect:password?error=1";
		}
		if(currentPw.equals(currentPw)) {//동일한 비밀번호로는 변경 X
			return "redirect:password?error=2";
		}
		memberDto.setMemberPw(newPw);//비밀번호 변경
		memberDao.updateMemberPassword(memberDto);
		return "redirect:mypage";
	}
	
	//개인정보 변경 매핑
	@GetMapping("/change")
	public String change(HttpSession session, Model model) {
		String userId = (String)session.getAttribute("userId");//내 아이디 추출
		MemberDto memberDto = memberDao.selectOne(userId);//내정보 획득
		model.addAttribute("memberDto", memberDto);
		return "/WEB-INF/views/member/change.jsp";
	}
	@PostMapping("/change")
	public String change(@ModelAttribute MemberDto memberDto,
												HttpSession session) {
		String userId = (String)session.getAttribute("userId");//내 아이디 추출
		MemberDto findDto = memberDao.selectOne(userId);
		boolean isValid = findDto.getMemberPw().equals(memberDto.getMemberPw());
		if(isValid == false) {//비밀번호 불일치
			return "redirect:change?error";//개인정보 변경페이지로 쫒아내기
		}
		//findDto에 원하는 항목을 교체한뒤 수정 요청
		findDto.setMemberNickname(memberDto.getMemberNickname());
		findDto.setMemberBirth(memberDto.getMemberBirth());
		findDto.setMemberGender(memberDto.getMemberGender());
		findDto.setMemberContact(memberDto.getMemberContact());
		findDto.setMemberEmail(memberDto.getMemberEmail());
		findDto.setMemberPost(memberDto.getMemberPost());
		findDto.setMemberAddress1(memberDto.getMemberAddress1());
		findDto.setMemberAddress2(memberDto.getMemberAddress2());
		
		memberDao.update(findDto);
		return "redirect:mypage";
	}
	
	//회원 탈퇴 매핑
	@GetMapping("/exit")
	public String exit() {
		return "/WEB-INF/views/member/exit.jsp";
	}
	@PostMapping("/exit")
	public String exit(@RequestParam String memberPw, HttpSession session) {
		String userId = (String)session.getAttribute("userId");
		MemberDto memberDto = memberDao.selectOne(userId);
		boolean isValid = memberPw.equals(memberDto.getMemberPw());
		if(isValid == false) {//비밀번호 불일치
			return "redirect:exit?error";//회원 탈퇴 페이지로 쫒아내기
		}
		
		memberDao.delete(userId);
		//사용자ID 삭제
		session.removeAttribute("userId");
		return "redirect:exitFinish";
	}
	@RequestMapping("/exitFinish")
	public String exitFinish() {
		return "/WEB-INF/views/member/exitFinish.jsp";
	}
}
