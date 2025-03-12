package com.kh.semiproject.controller;

import java.io.IOException;
import java.util.List;

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
import com.kh.semiproject.dao.MyReplyDao;
import com.kh.semiproject.dao.MyReviewDao;
import com.kh.semiproject.dao.PlaceLikeDao;
import com.kh.semiproject.dao.ReviewLikeDao;
import com.kh.semiproject.dto.MemberDto;
import com.kh.semiproject.dto.MyReplyDto;
import com.kh.semiproject.dto.MyReviewDto;
import com.kh.semiproject.dto.PlaceLikeDto;
import com.kh.semiproject.dto.ReviewLikeDto;
import com.kh.semiproject.service.AttachmentService;
import com.kh.semiproject.vo.RestPageVO;

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
	private MyReplyDao myReplyDao;
	@Autowired
	private MyReviewDao myReviewDao;
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
		String userId = (String) session.getAttribute("userId"); // 내 아이디 추출
		MemberDto memberDto = memberDao.selectOne(userId); // 내정보 획득
		model.addAttribute("memberDto", memberDto);

		// attachmentNo 추가 (프로필 이미지 번호)
		Integer attachmentNo = memberDao.findAttachment(userId); // 프로필 이미지 번호 조회
		model.addAttribute("attachmentNo", attachmentNo); // JSP로 전달

		return "/WEB-INF/views/mypage/change.jsp"; // 변경된 뷰 반환
	}

	@PostMapping("/change")
	public String change(@ModelAttribute MemberDto memberDto, HttpSession session,
			@RequestParam(required = false) MultipartFile memberProfile,
			@RequestParam(required = false, defaultValue = "false") boolean deleteProfile,
			@RequestParam String memberPw) throws IllegalStateException, IOException {

		String userId = (String) session.getAttribute("userId");
		MemberDto findDto = memberDao.selectOne(userId);

		// 비밀번호 확인
		if (!findDto.getMemberPw().equals(memberPw)) {
			return "redirect:change?error"; // 비밀번호 불일치 시 변경 페이지로 리다이렉트
		}

		// findDto에 변경된 값 반영
		findDto.setMemberNickname(memberDto.getMemberNickname());
		findDto.setMemberBirth(memberDto.getMemberBirth());
		findDto.setMemberGender(memberDto.getMemberGender());
		findDto.setMemberContact(memberDto.getMemberContact());
		findDto.setMemberEmail(memberDto.getMemberEmail());
		findDto.setMemberPost(memberDto.getMemberPost());
		findDto.setMemberAddress1(memberDto.getMemberAddress1());
		findDto.setMemberAddress2(memberDto.getMemberAddress2());

		// 프로필 처리
		Integer attachmentNo = memberDao.findAttachment(userId); // 기존 프로필 조회

		if (deleteProfile) { // 프로필 삭제 요청이 있을 경우
			if (attachmentNo != null) {
				attachmentService.delete(attachmentNo);
				memberDao.deleteProfile(userId);
				System.out.println("deleteProfile 상태: " + deleteProfile);
			}
		} else if (memberProfile != null && !memberProfile.isEmpty()) { // 새 프로필 업로드
			if (attachmentNo != null) { // 기존 프로필 삭제 후 새 파일 저장
				attachmentService.delete(attachmentNo);
			}
			int newAttachmentNo = attachmentService.save(memberProfile);
			memberDao.connect(userId, newAttachmentNo);
			System.out.println("상태: " + deleteProfile);
		}

		// 회원 정보 업데이트
		memberDao.update(findDto);

		return "redirect:home"; // 변경 후 다시 내 정보 수정 페이지로 이동

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
	public String myLikePlace(HttpSession session, Model model, RestPageVO restPageVO) {
		String userId = (String) session.getAttribute("userId"); // 내 아이디 추출
		restPageVO.setMemberId(userId);
		int count = placeLikeDao.count(restPageVO);
		restPageVO.setCount(count);
		List<PlaceLikeDto> placeLikeList = placeLikeDao.selectListRest(restPageVO); // 좋아요한 여행지 목록 조회
		model.addAttribute("placeLikeList", placeLikeList);
		return "/WEB-INF/views/mypage/myLikePlace.jsp";
	}

	// 내가좋아요표시한 후기 목록 매핑
	@RequestMapping("myLikeReview")
	public String myLikeReview(RestPageVO restPageVO, HttpSession session, Model model) {
		String userId = (String) session.getAttribute("userId");// 내 아이디 추출
		restPageVO.setMemberId(userId);
		//List<ReviewLikeDto> reviewLikeList = reviewLikeDao.selectReviewLikeList(userId);// 좋아요한 후기 목록 조회
		List<ReviewLikeDto> reviewLikeList = reviewLikeDao.selectListRest(restPageVO);// 좋아요한 후기 목록 조회
		int count = reviewLikeDao.count(restPageVO);
		restPageVO.setCount(count);
		model.addAttribute("reviewLikeList", reviewLikeList);
		return "/WEB-INF/views/mypage/myLikeReview.jsp";
	}

	// 내가 작성한 후기 목록 매핑
	@RequestMapping("/myReview")
	public String myReviewList(HttpSession session, Model model, RestPageVO restPageVO) {
		 String userId = (String) session.getAttribute("userId");
		 restPageVO.setMemberId(userId);
		 int count = myReviewDao.count(restPageVO);
		 restPageVO.setCount(count);
       // List<MyReviewDto> myReviewList = myReviewDao.selectMyReviewList(userId);
        List<MyReviewDto> myReviewList = myReviewDao.selectListRest(restPageVO);
        model.addAttribute("myReviewList", myReviewList);

        return "/WEB-INF/views/mypage/myReview.jsp";
    }

	// 내가 작성한 댓글 목록 매핑
	@RequestMapping("/myReply")
	public String myReply(HttpSession session, Model model, RestPageVO restPageVO) {
	    String userId = (String) session.getAttribute("userId");
	    restPageVO.setMemberId(userId);
	    int count = myReplyDao.count(restPageVO);
	    restPageVO.setCount(count);
	 //   List<MyReplyDto> myReplyList = myReplyDao.selectMyReplyList(userId);
	    List<MyReplyDto> myReplyList = myReplyDao.selectListRest(restPageVO);

	    model.addAttribute("myReplyList", myReplyList);
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
