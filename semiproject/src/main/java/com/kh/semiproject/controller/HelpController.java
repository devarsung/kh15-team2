package com.kh.semiproject.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.kh.semiproject.dao.HelpDao;
import com.kh.semiproject.dao.PlaceDao;
import com.kh.semiproject.dto.HelpDto;

import jakarta.servlet.http.HttpSession;

@Controller
@RequestMapping("/help")
public class HelpController {
	@Autowired
	private HelpDao helpDao;
	@Autowired
	private PlaceDao placeDao;
	
	@GetMapping("/add")
	public String add(@RequestParam int placeNo, Model model) {
		model.addAttribute("placeDto", placeDao.selectOne(placeNo));
		return "/WEB-INF/views/help/list.jsp";
	}
	
	@PostMapping("/add")
	public String add(@ModelAttribute HelpDto helpDto, HttpSession session) {
		String userId = (String)session.getAttribute("userId");
		helpDto.setHelpWriter(userId);
		int helpNo = helpDao.sequence();
		helpDto.setHelpNo(helpNo);
		helpDao.inesrt(helpDto);
		return "redirect:detail?helpNo="+helpNo;
	}
	
	@RequestMapping("/detail")
	public String detail(@RequestParam int helpNo, Model model) {
		
		return "/WEB-INF/views/help/detail.jsp";
	}
	
	@GetMapping("/delete")
	public String delete(@RequestParam int helpNo) {
		
		return "redirect:list";
	}
	
	@GetMapping("/edit")
	public String edit(@RequestParam int helpNo, Model model) {
		
		return "/WEB-INF/views/help/edit.jsp";
	}
	
	@PostMapping("/edit")
	public String edit(@ModelAttribute HelpDto helpDto) {
		
		return "redirect:detail?helpNo="+helpDto.getHelpNo();
	}
	
	
	
}































