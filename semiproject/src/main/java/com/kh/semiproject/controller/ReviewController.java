package com.kh.semiproject.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.kh.semiproject.dao.ReviewDao;

@Controller
@RequestMapping("/review")
public class ReviewController {
	@Autowired
	private ReviewDao reviewDao;
	
	@RequestMapping("/list")
	public String list() {
		return "/WEB-INF/views/review/list.jsp";
	}
	
	@RequestMapping("/detail")
	public String detail() {
		return "/WEB-INF/views/review/detail.jsp";
	}
}
