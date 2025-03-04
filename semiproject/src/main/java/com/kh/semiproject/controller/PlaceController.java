package com.kh.semiproject.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.kh.semiproject.dao.PlaceDao;
import com.kh.semiproject.dto.PlaceDto;
import com.kh.semiproject.vo.PageVO;

@Controller
@RequestMapping("/place")
public class PlaceController {

	@Autowired
	public PlaceDao placeDao;
	
	
	@RequestMapping("/list")
	public String list(@ModelAttribute ("pageVO")PageVO pageVO, Model model) {
		List<PlaceDto> list = placeDao.selectList(pageVO);
		model.addAttribute("list", list);
		return "/WEB-INF/views/place/list.jsp";
	}
	
	@RequestMapping("/detail")
	public String detail(@RequestParam int placeNo, Model model) {
		PlaceDto placeDto = placeDao.selectOne(placeNo);
		model.addAttribute("placeDto",placeDto);
		return "/WEB-INF/views/place/detail.jsp";
	}


	


}
