package com.kh.semiproject.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.kh.semiproject.dao.NoticeDao;
import com.kh.semiproject.dto.NoticeDto;

@Controller
@RequestMapping("/notice")
public class NoticeController {


	@Autowired
	private NoticeDao noticeDao;
	
	@RequestMapping("/list")
	public String list() {
		return "/WEB-INF/views/notice/list.jsp";
	}
	@RequestMapping("/detail")
	public String detail(@RequestParam int noticeNo, Model model) {
		NoticeDto noticeDto = noticeDao.selectOne(noticeNo);
		model.addAttribute("noticeDto",noticeDto);
		return "/WEB-INF/views/notice/detail.jsp";
	}
	

}
