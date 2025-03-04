package com.kh.semiproject.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.kh.semiproject.dao.ReviewDao;
import com.kh.semiproject.dao.ReviewListViewDao;
import com.kh.semiproject.dto.ReviewDto;
import com.kh.semiproject.dto.ReviewListViewDto;
import com.kh.semiproject.vo.PageVO;

import jakarta.servlet.http.HttpSession;

@Controller
@RequestMapping("/review")
public class ReviewController {
	@Autowired
	private ReviewDao reviewDao;
	
	@Autowired
	private ReviewListViewDao reviewListViewDao;
	
	@RequestMapping("/list")
	public String list(@ModelAttribute("pageVO") PageVO pageVO, Model model) {
		int count =  reviewDao.count(pageVO);
		pageVO.setCount(count);
		List<ReviewListViewDto> list = reviewListViewDao.selectList(pageVO);
		model.addAttribute("list",list);
		return "/WEB-INF/views/review/list.jsp";
	}
	

	@GetMapping("/add")
	public String add() {
		return "/WEB-INF/views/review/add.jsp";
	}
	
	@PostMapping("/add")
	public String add(@ModelAttribute ReviewDto reviewDto, HttpSession session) {
		String userId = (String)session.getAttribute("userId");
		reviewDto.setReviewWriter(userId);
		int reviewNo = reviewDao.sequence();
		reviewDto.setReviewNo(reviewNo);
		
		return "redirect:detail?reviewNo="+reviewNo;
	}
	
	
	@RequestMapping("/detail")
	public String detail(@RequestParam int reviewNo, Model model) {
		ReviewDto reviewDto = reviewDao.selectOne(reviewNo);
		model.addAttribute("reviewDto", reviewDto);
		return "/WEB-INF/views/review/detail.jsp";
	}
	
	@GetMapping("/edit")
	public String edit(@RequestParam int reviewNo, Model model) {
		ReviewDto reviewDto = reviewDao.selectOne(reviewNo);
		model.addAttribute("reviewDto", reviewDto);
		return "/WEB-INF/views/review/edit.jsp";
	}
	
	@PostMapping("/edit")
	public String edit(@ModelAttribute ReviewDto reviewDto) {
		reviewDao.update(reviewDto);
		return "redirect:list";
	}

}
























