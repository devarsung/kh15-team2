package com.kh.semiproject.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/notice")
public class NoticeController {
	
	@RequestMapping("/list")
	public String list() {
		return "/WEB-INF/views/notice/list.jsp";
	}
	
	@RequestMapping("/detail")
	public String detail() {
		return "/WEB-INF/views/notice/detail.jsp";
	}
}
