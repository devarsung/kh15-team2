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
	public String review(Model model) {
		model.addAttribute("reviewUserList", statusDao.reviewUserGroup());// 후기 유저수
		model.addAttribute("reviewReplyList", statusDao.reviewReplyGroup());	// 후기 댓글 많으수
		
		return "/WEB-INF/views/admin/status/review.jsp";
	}
	
	//현황 3
	@RequestMapping("/place")
	public String place(Model model) {
		model.addAttribute("placeTypeList", statusDao.placeTypeGroup());// 여행지 타입
		model.addAttribute("placeRegionList", statusDao.placeRegionGroup());// 여행지 지역
		model.addAttribute("placeReviewList", statusDao.placeReviewGroup()); // 리뷰가 많은 여행지순
		return "/WEB-INF/views/admin/status/place.jsp";
	}
	
	
	
}
