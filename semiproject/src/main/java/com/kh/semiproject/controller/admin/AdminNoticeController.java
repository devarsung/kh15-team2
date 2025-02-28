package com.kh.semiproject.controller.admin;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.kh.semiproject.dao.NoticeDao;
import com.kh.semiproject.dto.NoticeDto;

import jakarta.servlet.http.HttpSession;

@Controller
@RequestMapping("/admin/notice")
public class AdminNoticeController {
	@Autowired
	public NoticeDao noticeDao;
	
	@GetMapping("/add")
	public String add() {
		return "/WEB-INF/views/admin/notice/add.jsp";
	}
	
	@PostMapping("/add")
	public String add(@ModelAttribute NoticeDto noticeDto, HttpSession session) {
		
		return "redirect:list";
	}
	
	
	@RequestMapping("/list")
	public String list() {
		return "/WEB-INF/views/admin/notice/list.jsp";
	}
	
	@RequestMapping("/detail")
	public String detail(@RequestParam int noticeNo, Model model) {
		return "/WEB-INF/views/admin/notice/detail.jsp";
	}
	
	@GetMapping("/edit")
	public String edit(@RequestParam int noticeNo, Model model) {
		return "/WEB-INF/views/admin/notice/edit.jsp";
	}
	
	@PostMapping("/edit")
	public String edit(@ModelAttribute NoticeDto noticeDto) {
		return "redirect:list";
	}
}
