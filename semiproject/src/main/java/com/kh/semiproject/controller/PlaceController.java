package com.kh.semiproject.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/place")
public class PlaceController {
	
	@RequestMapping("/list")
	public String list() {
		return "/WEB-INF/views/place/list.jsp";
	}
	
	@RequestMapping("/detail")
	public String detail() {
		return "/WEB-INF/views/place/detail.jsp";
	}
}
