package com.kh.semiproject.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.kh.semiproject.dao.ReviewDao;
import com.kh.semiproject.dto.ReviewDto;

import jakarta.servlet.http.HttpSession;

@Controller
@RequestMapping("/review")
public class ReviewController {
	@Autowired
	private ReviewDao reviewDao;
	
	@RequestMapping("/list")
	public String list() {
		return "/WEB-INF/views/review/list.jsp";
	}
	

	@GetMapping("/add")
	public String add() {
		return "/WEB-INF/views/review/add.jsp";
	}
	
	@PostMapping("/add")
	public String add(@ModelAttribute ReviewDto reviewDto, HttpSession session) {
		return "redirect:list";
	}
	
	
	@RequestMapping("/detail")
	public String detail(@RequestParam int reviewNo, Model model) {
		return "/WEB-INF/views/review/detail.jsp";
	}
	
	@GetMapping("/edit")
	public String edit(@RequestParam int reviewNo, Model model) {
		return "/WEB-INF/views/review/edit.jsp";
	}
	
	@PostMapping("/edit")
	public String edit(@ModelAttribute ReviewDto reviewDto) {
		return "redirect:list";
	}

}
























