package com.kh.semiproject.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.kh.semiproject.dao.PlaceDao;
import com.kh.semiproject.dto.PlaceDto;

@Controller
@RequestMapping("/place")
public class PlaceController {

	@Autowired
	public PlaceDao placeDao;
	
	@RequestMapping("/list")
	public String list() {
		return "/WEB-INF/views/place/list.jsp";
	}
	
	@RequestMapping("/detail")
	public String detail(@RequestParam int placeNo, Model model) {
		PlaceDto placeDto = placeDao.selectOne(placeNo);
		model.addAttribute("placeDto",placeDto);
		return "/WEB-INF/views/place/detail.jsp";
	}


	


}
