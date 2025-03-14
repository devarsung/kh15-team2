package com.kh.semiproject.controller;

import java.io.IOException;

import javax.naming.NoPermissionException;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.kh.semiproject.dao.CertDao;
import com.kh.semiproject.dao.MemberDao;
import com.kh.semiproject.dto.CertDto;
import com.kh.semiproject.dto.MemberDto;
import com.kh.semiproject.service.AttachmentService;
import com.kh.semiproject.service.EmailService;

import jakarta.mail.MessagingException;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@Controller
@RequestMapping("/member")
public class MemberController {
	@Autowired
	private MemberDao memberDao;
	@Autowired
	private AttachmentService attachmentService;
	@Autowired
	private EmailService emailService;
	@Autowired
	private CertDao certDao;

	// 회원가입 매핑
	@GetMapping("/join")
	public String join() {
		return "/WEB-INF/views/member/join.jsp";
	}

	@PostMapping("/join")
	public String join(@ModelAttribute MemberDto memberDto, @RequestParam MultipartFile memberProfile,
			@RequestParam String certNumber) throws IllegalStateException, IOException, MessagingException {
		// 사용자 입력한 memberId를 그대로 사용
		String memberId = memberDto.getMemberId();
		memberDao.insert(memberDto);// 회원가입
		emailService.sendWelcomeMail(memberDto);// 환영메일 발송
		if (memberProfile.isEmpty() == false) {
			// 첨부파일 등록
			int attachmentNo = attachmentService.save(memberProfile);
			// 회원 프로필 등록
			memberDao.connect(memberId, attachmentNo);
		}
		return "redirect:joinFinish";
	}

	@RequestMapping("/joinFinish")
	public String joinFinish() {
		return "/WEB-INF/views/member/joinFinish.jsp";
	}

	// 로그인 매핑
	@GetMapping("/login")
	public String login() {
		return "/WEB-INF/views/member/login.jsp";
	}

	@PostMapping("/login")
	public String login(@ModelAttribute MemberDto memberDto,
			@RequestParam(required = false) String remember, 
			HttpSession session
			,HttpServletResponse response) {
		MemberDto findDto = memberDao.selectOne(memberDto.getMemberId());
		// 아이디가 없으면 findDto = null
		if (findDto == null) {
			return "redirect:login?error";// 로그인 페이지로 쫒아내기
		}
		// 아이디가 있으면 비밀번호 검사를 진행
		boolean isValid = findDto.getMemberPw().equals(memberDto.getMemberPw());
		if (isValid) {// 로그인 성공시
			// userId란 이름으로 사용자의 ID 저장
			session.setAttribute("userId", findDto.getMemberId());
			// userLevel이란 이름으로 사용자 등급 저장
			session.setAttribute("userLevel", findDto.getMemberLevel());
			// 최종로그인시각 갱신 처리
			memberDao.updateMemberLogin(findDto.getMemberId());
			
			if(remember == null) {
				Cookie cookie = new Cookie("saveId", memberDto.getMemberId());
				cookie.setMaxAge(0);
				response.addCookie(cookie);
			}
			else {
				Cookie cookie = new Cookie("saveId", memberDto.getMemberId());
				cookie.setMaxAge(4*7*24*60*60);//4주
				response.addCookie(cookie);
			}
			
			
			
			return "redirect:/";
		} else {// 로그인 실패시
			return "redirect:login?error";// 로그인 페이지로 쫒아내기
		}
	}

	// 로그아웃 매핑
	@RequestMapping("/logout")
	public String logout(HttpSession session) {
		session.removeAttribute("userId");
		return "redirect:/";
	}

	// 비밀번호 찾기 매핑
	@GetMapping("/findPw")
	public String findPw() {
		return "/WEB-INF/views/member/findPw.jsp";
	}

	@PostMapping("/findPw")
	public String findPw(@ModelAttribute MemberDto memberDto) throws MessagingException, IOException {
		MemberDto findDto = memberDao.selectOne(memberDto.getMemberId());
		//System.out.println("findDto: "+ findDto);
		if (findDto == null) {
			// throw new TargetNotFoundException("존재하지 않는 아이디");
			return "redirect:findPw?error";
		}
		if (!findDto.getMemberEmail().equals(memberDto.getMemberEmail())) {
			// throw new NoPermissionException("이메일 정보 오류");
			return "redirect:findPw?error";
		}

		emailService.sendResetMail(memberDto);// 재설정 메일 발송

		return "redirect:findPwSend";
	}

	@GetMapping("/findPwSend")
	public String findPwSend() {
		return "/WEB-INF/views/member/findPwSend.jsp";
	}

	@GetMapping("/reset")
	public String reset(@RequestParam String memberId, Model model, @RequestParam String certEmail,
			@RequestParam String certNumber) throws NoPermissionException {
		CertDto certDto = certDao.selectOne(certEmail);
		if (certDto == null)
			throw new NoPermissionException("허용되지 않는 접근");
		if (!certDto.getCertNumber().equals(certNumber))
			throw new NoPermissionException("허용되지 않는 접근");

		model.addAttribute("memberId", memberId);
		model.addAttribute("certEmail", certEmail);
		model.addAttribute("certNumber", certNumber);
		return "/WEB-INF/views/member/reset.jsp";
	}

	@PostMapping("/reset")
	public String reset(@ModelAttribute MemberDto memberDto, @RequestParam String certEmail,
			@RequestParam String certNumber) throws NoPermissionException {
		CertDto certDto = certDao.selectOne(certEmail);
		if (certDto == null)
			throw new NoPermissionException("허용되지 않는 접근");
		if (!certDto.getCertNumber().equals(certNumber))
			throw new NoPermissionException("허용되지 않는 접근");

		certDao.delete(certEmail);// 인증정보 삭제
		memberDao.updateMemberPassword(memberDto);
		return "redirect:resetFinish";
	}

	@GetMapping("/resetFinish")
	public String resetFinish() {
		return "/WEB-INF/views/member/resetFinish.jsp";
	}
}
