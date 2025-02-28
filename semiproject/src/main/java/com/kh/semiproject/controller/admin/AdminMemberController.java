package com.kh.semiproject.controller.admin;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/admin/member")
public class AdminMemberController {
	
	@RequestMapping("/list")
	public String list() {
		return "/WEB-INF/views/admin/member/list.jsp";
	}
	
	@RequestMapping("/detail")
	public String detail() {
		return "/WEB-INF/views/admin/member/detail.jsp";
	}
	
	@GetMapping("/edit")
	public String edit() {
		return "/WEB-INF/views/admin/member/edit.jsp";
	}
}
