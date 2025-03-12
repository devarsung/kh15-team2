package com.kh.semiproject.controller.admin;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.kh.semiproject.dao.StatusDao;

@Controller
@RequestMapping("/admin/status")
public class AdminStatusController {
	@Autowired
	private StatusDao statusDao;
	
	//현황1
	@RequestMapping("/member")
	public String member(Model model) {
		model.addAttribute("memberGenderList", statusDao.memberGenderGroup());
		model.addAttribute("memberAgeList", statusDao.memberAgeGroup());
		return "/WEB-INF/views/admin/status/member.jsp";
	}
	
	//현황 2 
	// 후기가 가장 많은 여행지와
	// 댓글이 가장 많은 후기
	@RequestMapping("/review")
	public String place(Model model) {
		model.addAttribute("placeReviewList", statusDao.placeReviewGroup());
		model.addAttribute("reviewReplyList", statusDao.reviewReplyGroup());	
		model.addAttribute("placeLikeList", statusDao.placeLikeGroup()); // 여행지 좋아요
		model.addAttribute("placeReadList", statusDao.placeReadGroup()); // 여행지 조회수
		model.addAttribute("reviewLikeList", statusDao.reviewLikeGroup());// 후기 좋아요
		model.addAttribute("reviewReadList", statusDao.reviewReadGroup());// 후기 조회수
		return "/WEB-INF/views/admin/status/review.jsp";
	}
	
	//현황 3
//	@RequestMappping("/")
	
	
	
}
