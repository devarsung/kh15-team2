package com.kh.semiproject.controller.admin;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/admin")
public class AdminHomeController {

	@RequestMapping("/home")
	public String home() {
		return "/WEB-INF/views/admin/home.jsp";
	}
}
