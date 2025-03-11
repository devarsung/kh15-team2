package com.kh.semiproject.restcontroller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.kh.semiproject.dao.PlaceLikeDao;
import com.kh.semiproject.dao.ReviewLikeDao;
import com.kh.semiproject.dto.PlaceLikeDto;
import com.kh.semiproject.dto.ReviewLikeDto;
import com.kh.semiproject.vo.RestPageVO;

import jakarta.servlet.http.HttpSession;

@CrossOrigin
@RestController
@RequestMapping("/rest/page")
public class PageRestController {
	@Autowired
	private PlaceLikeDao placeLikeDao;
	@Autowired
	private ReviewLikeDao reviewLikeDao;
	
	
	@RequestMapping("/myLikePlace")
	public List<PlaceLikeDto> placeList(RestPageVO restPageVO, Model model, HttpSession session) {
		String userId = (String)session.getAttribute("userId");
		restPageVO.setMemberId(userId);
		int count = placeLikeDao.count(restPageVO);
		restPageVO.setCount(count);
		List<PlaceLikeDto> list = placeLikeDao.selectListRest(restPageVO);
		return list;
	}
	
	@RequestMapping("/myLikeReview")
	public List<ReviewLikeDto> reviewList(RestPageVO restPageVO, Model model, HttpSession session) {
		String userId = (String)session.getAttribute("userId");
		restPageVO.setMemberId(userId);
		int count = placeLikeDao.count(restPageVO);
		restPageVO.setCount(count);
		List<ReviewLikeDto> list = reviewLikeDao.selectListRest(restPageVO);
		return list;
	}
	
	@RequestMapping("/myReview")
	public void myReviewList() {
		
	}
	
	@RequestMapping("/myReply")
	public void myReplyList() {
		
	}
	
}
















