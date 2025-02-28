package com.kh.semiproject.controller.admin;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/admin/notice")
public class AdminNoticeController {
	
	@GetMapping("/add")
	public String add() {
		return "/WEB-INF/views/admin/notice/add.jsp";
	}
	
	@RequestMapping("/list")
	public String list() {
		return "/WEB-INF/views/admin/notice/list.jsp";
	}
	
	@RequestMapping("/detail")
	public String detail() {
		return "/WEB-INF/views/admin/notice/detail.jsp";
	}
	
	@GetMapping("/edit")
	public String edit() {
		return "/WEB-INF/views/admin/notice/edit.jsp";
	}
}
