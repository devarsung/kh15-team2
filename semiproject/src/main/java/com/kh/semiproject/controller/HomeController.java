package com.kh.semiproject.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.kh.semiproject.dao.NoticeListViewDao;
import com.kh.semiproject.dao.PlaceDao;
import com.kh.semiproject.dao.ReviewPlaceMemberListViewDao;

@Controller
public class HomeController {
	@Autowired
	private NoticeListViewDao noticeListViewDao;
	
	@Autowired
	private ReviewPlaceMemberListViewDao reviewPlaceMemberListViewDao;
	
	@Autowired
	private PlaceDao placeDao;
	
	@RequestMapping("/")
		public String home(Model model) {
	//	model.addAttribute("reviews", reviewPlaceMemberListViewDao.selectListOnReview());
		model.addAttribute("notices", noticeListViewDao.selectListOnNotice());
		model.addAttribute("places", placeDao.selectListOnPlace());

		return "/WEB-INF/views/home.jsp";
	}
}
