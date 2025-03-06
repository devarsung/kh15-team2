package com.kh.semiproject.controller;

import java.io.IOException;
import java.util.List;

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

import com.kh.semiproject.dao.MemberDao;
import com.kh.semiproject.dao.PlaceLikeDao;
import com.kh.semiproject.dao.ReplyDao;
import com.kh.semiproject.dao.ReviewDao;
import com.kh.semiproject.dao.ReviewLikeDao;
import com.kh.semiproject.dto.MemberDto;
import com.kh.semiproject.dto.PlaceLikeDto;
import com.kh.semiproject.dto.ReplyDto;
import com.kh.semiproject.dto.ReviewDto;
import com.kh.semiproject.dto.ReviewLikeDto;
import com.kh.semiproject.service.AttachmentService;

import jakarta.servlet.http.HttpSession;

@Controller
@RequestMapping("/mypage")
public class MypageController {
	@Autowired
	private MemberDao memberDao;
	@Autowired
	private PlaceLikeDao placeLikeDao;
	@Autowired
	private ReviewLikeDao reviewLikeDao;
	@Autowired
	private ReplyDao replyDao;
	@Autowired
	private ReviewDao reviewDao;
	@Autowired
	private AttachmentService attachmentService;

	// 마이페이지 매핑
	@RequestMapping("/home")
	public String mypage(HttpSession session, Model model) {
		String userId = (String) session.getAttribute("userId");// 내 아이디 추출
		MemberDto memberDto = memberDao.selectOne(userId);// 내정보 획득
		model.addAttribute("memberDto", memberDto);
		return "/WEB-INF/views/mypage/home.jsp";
	}

	// 비밀번호 변경 매핑
	@GetMapping("/password")
	public String password() {
		return "/WEB-INF/views/mypage/password.jsp";
	}

	@PostMapping("/password")
	public String password(@RequestParam String currentPw, @RequestParam String newPw, HttpSession session) {
		String userId = (String) session.getAttribute("userId");
		if (userId == null) {
			// 로그인되지 않으면 로그인 페이지로 리다이렉트
			return "redirect:/member/login";
		}
		MemberDto memberDto = memberDao.selectOne(userId);// 내정보 획득
		boolean isValid = currentPw.equals(memberDto.getMemberPw());
		if (isValid == false) {// 비밀번호 불일치
			return "redirect:password?error=1";
		}
		if (currentPw.equals(newPw)) {// 동일한 비밀번호로는 변경 X
			return "redirect:password?error=2";
		}
		memberDto.setMemberPw(newPw);// 비밀번호 변경
		memberDao.updateMemberPassword(memberDto);
		return "redirect:home";
	}

	// 개인정보 변경 매핑
	@GetMapping("/change")
	public String change(HttpSession session, Model model) {
		String userId = (String) session.getAttribute("userId");// 내 아이디 추출
		MemberDto memberDto = memberDao.selectOne(userId);// 내정보 획득
		model.addAttribute("memberDto", memberDto);
		return "/WEB-INF/views/mypage/change.jsp";
	}

	@PostMapping("/change")
	public String change(@ModelAttribute MemberDto memberDto, HttpSession session,
			@RequestParam MultipartFile memberProfile) throws IllegalStateException, IOException {
		String userId = (String) session.getAttribute("userId");// 내 아이디 추출
		MemberDto findDto = memberDao.selectOne(userId);
		boolean isValid = findDto.getMemberPw().equals(memberDto.getMemberPw());
		if (isValid == false) {// 비밀번호 불일치
			return "redirect:change?error";// 개인정보 변경페이지로 쫒아내기
		}
		// findDto에 원하는 항목을 교체한뒤 수정 요청
		findDto.setMemberNickname(memberDto.getMemberNickname());
		findDto.setMemberBirth(memberDto.getMemberBirth());
		findDto.setMemberGender(memberDto.getMemberGender());
		findDto.setMemberContact(memberDto.getMemberContact());
		findDto.setMemberEmail(memberDto.getMemberEmail());
		findDto.setMemberPost(memberDto.getMemberPost());
		findDto.setMemberAddress1(memberDto.getMemberAddress1());
		findDto.setMemberAddress2(memberDto.getMemberAddress2());

		// 회원 프로필변경 요청
		if (memberProfile.isEmpty() == false) {// 첨부파일이 존재한다면
			try {// 기존 이미지 삭제 처리(없으면 예외 발생)
				int attachmentNo = memberDao.findAttachment(memberDto.getMemberId());
				attachmentService.delete(attachmentNo);
			} catch (Exception e) {
				/* 아무것도 안함 */}

			// 신규 회원프로필 등록
			int newAttachmentNo = attachmentService.save(memberProfile);
			memberDao.connect(memberDto.getMemberId(), newAttachmentNo);
		}

		memberDao.update(findDto);
		return "redirect:/";
	}

	// 회원 탈퇴 매핑
	@GetMapping("/exit")
	public String exit() {
		return "/WEB-INF/views/mypage/exit.jsp";
	}

	@PostMapping("/exit")
	public String exit(@RequestParam String memberPw, HttpSession session) {
		String userId = (String) session.getAttribute("userId");
		MemberDto memberDto = memberDao.selectOne(userId);
		boolean isValid = memberPw.equals(memberDto.getMemberPw());
		if (isValid == false) {// 비밀번호 불일치
			return "redirect:exit?error";// 회원 탈퇴 페이지로 쫒아내기
		}

		memberDao.delete(userId);
		// 사용자ID 삭제
		session.removeAttribute("userId");
		return "redirect:exitFinish";
	}

	@RequestMapping("/exitFinish")
	public String exitFinish() {
		return "/WEB-INF/views/mypage/exitFinish.jsp";
	}

	// 내가좋아요표시한 여행지 목록 매핑
	@RequestMapping("/myLikePlace")
	public String myLikePlace(HttpSession session, Model model) {
		String userId = (String) session.getAttribute("userId");// 내 아이디 추출
		MemberDto memberDto = memberDao.selectOne(userId);// 내정보 획득
		List<PlaceLikeDto> placeLikeList = placeLikeDao.selectPlaceLikeList(userId); // 좋아요한 여행지 목록 조회
		model.addAttribute("placeLikeList", placeLikeList);
		return "/WEB-INF/views/mypage/myLikePlace.jsp";
	}

	// 내가좋아요표시한 후기 목록 매핑
	@RequestMapping("myLikeReview")
	public String myLikeReview(HttpSession session, Model model) {
		String userId = (String) session.getAttribute("userId");// 내 아이디 추출
		MemberDto memberDto = memberDao.selectOne(userId);// 내정보 획득
		List<ReviewLikeDto> reviewLikeList = reviewLikeDao.selectReviewLikeList(userId);// 좋아요한 후기 목록 조회
		model.addAttribute("reviewLikeList", reviewLikeList);
		return "/WEB-INF/views/mypage/myLikeReview.jsp";
	}

	// 내가 작성한 후기 목록 매핑
	@RequestMapping("myReview")
	public String myReview(HttpSession session, Model model) {
		String userId = (String) session.getAttribute("userId");// 내 아이디 추출
		MemberDto memberDto = memberDao.selectOne(userId);// 내정보 획득
		List<ReviewDto> list = reviewDao.selectListByUserId(userId);
		model.addAttribute("list", list);
		return "/WEB-INF/views/mypage/myReview.jsp";
	}

	// 내가 작성한 댓글 목록 매핑
	@RequestMapping("myReply")
	public String myReply(HttpSession session, Model model, int reviewNo) {
		String userId = (String) session.getAttribute("userId");// 내 아이디 추출
		MemberDto memberDto = memberDao.selectOne(userId);// 내정보 획득
		List<ReplyDto> list = replyDao.selectListByUserIdAndReviewNo(userId, reviewNo);
		model.addAttribute("list", list);
		return "/WEB-INF/views/mypage/myReply.jsp";
	}

	// 회원아이디로 이미지 주소를 반환하는 매핑
	@RequestMapping("/profile")
	public String image(@RequestParam String memberId) {
		try {// 플랜 A : 이미지가 있는 경우
			int attachmentNo = memberDao.findAttachment(memberId);
			return "redirect:/attachment/download?attachmentNo=" + attachmentNo;
		} catch (Exception e) {// 플랜 B : 이미지가 없는 경우
			return "redirect:https://placehold.co/400x400?text=p";
		}
	}
}
