package com.kh.semiproject.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.kh.semiproject.dao.NoticeListViewDao;
import com.kh.semiproject.dao.ReviewListViewDao;

@Controller
public class HomeController {
	@Autowired
	private NoticeListViewDao noticeListViewDao;
	
	@Autowired
	private ReviewListViewDao reviewListViewDao;
	@RequestMapping("/")
	public String home(Model model) {
		model.addAttribute("reviews", reviewListViewDao.selectListOnReview());
		model.addAttribute("notice", noticeListViewDao.selectListOnNotice());
		
		return "/WEB-INF/views/home.jsp";
	}
}
