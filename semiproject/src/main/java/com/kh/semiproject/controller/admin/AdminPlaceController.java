package com.kh.semiproject.controller.admin;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.kh.semiproject.dao.PlaceDao;
import com.kh.semiproject.dto.PlaceDto;

import jakarta.servlet.http.HttpSession;

@Controller
@RequestMapping("/admin/place")
public class AdminPlaceController {
	@Autowired
	public PlaceDao placeDao;
	
	@GetMapping("/add")
	public String add() {
		return "/WEB-INF/views/admin/place/add.jsp";
	}
	
	@PostMapping("/add")
	public String add(@ModelAttribute PlaceDto placeDto, HttpSession session) {
		
		return "redirect:list";
	}
	
	
	@RequestMapping("/list")
	public String list() {
		return "/WEB-INF/views/admin/place/list.jsp";
	}
	
	@RequestMapping("/detail")
	public String detail(@RequestParam int placeNo, Model model) {
		return "/WEB-INF/views/admin/place/detail.jsp";
	}
	
	@GetMapping("/edit")
	public String edit(@RequestParam int placeNo, Model model) {
		return "/WEB-INF/views/admin/place/edit.jsp";
	}
	
	@PostMapping("/edit")
	public String edit(@ModelAttribute PlaceDto palceDto) {
		return "redirect:list";
	}
}

















