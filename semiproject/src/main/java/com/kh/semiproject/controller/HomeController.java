package com.kh.semiproject.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.kh.semiproject.dao.NoticeListViewDao;
import com.kh.semiproject.dao.PlaceDao;
import com.kh.semiproject.dao.ReviewListViewDao;

@Controller
public class HomeController {
	@Autowired
	private NoticeListViewDao noticeListViewDao;
	
	@Autowired
	private ReviewListViewDao reviewListViewDao;
	
	@Autowired
	private PlaceDao placeDao;
	
	@RequestMapping("/")

		model.addAttribute("reviews", reviewListViewDao.selectListOnReview());
		model.addAttribute("notices", noticeListViewDao.selectListOnNotice());
		model.addAttribute("places", placeDao.selectListOnPlace());

		return "/WEB-INF/views/home.jsp";
	}
}
