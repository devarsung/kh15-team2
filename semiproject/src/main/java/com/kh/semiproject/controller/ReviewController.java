package com.kh.semiproject.controller;

import java.util.HashSet;
import java.util.List;
import java.util.Set;

import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;
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
import com.kh.semiproject.error.TargetNotFoundException;
import com.kh.semiproject.service.AttachmentService;
import com.kh.semiproject.vo.PageVO;

import jakarta.servlet.http.HttpSession;

@Controller
@RequestMapping("/review")
public class ReviewController {
	@Autowired
	private ReviewDao reviewDao;
	
	@Autowired
	private ReviewListViewDao reviewListViewDao;
	
	@Autowired
	private AttachmentService attachmentService;
	
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
		if(reviewDto == null) {
			throw new TargetNotFoundException("존재 하지 않는 후기 입니다");
		}
		model.addAttribute("reviewDto", reviewDto);
		return "/WEB-INF/views/review/detail.jsp";
	}
	
	@GetMapping("/edit")
	public String edit(@RequestParam int reviewNo, Model model) {
		ReviewDto reviewDto = reviewDao.selectOne(reviewNo);
		if(reviewDto == null) {
			throw new TargetNotFoundException("존재 하지 않는 후기 입니다");
		}
		model.addAttribute("reviewDto", reviewDto);
		return "/WEB-INF/views/review/edit.jsp";
	}
	
	@PostMapping("/edit")
	public String edit(@ModelAttribute ReviewDto reviewDto) {
		reviewDao.update(reviewDto);
		int reviewNo = reviewDto.getReviewNo();
		
		ReviewDto originDto = reviewDao.selectOne(reviewNo);
		
		// 수정전
		Set<Integer> before = new HashSet<>();
		Document beforeDocument = Jsoup.parse(originDto.getReviewContent());
		Elements beforeElements = beforeDocument.select(".before");
		for(Element element : beforeElements) {
			int attachmentNo = Integer.parseInt(element.attr(".attachment"));
			before.add(attachmentNo);
		}
		
		// 수정후
		Set<Integer> after = new HashSet<>();
		Document afterDocument = Jsoup.parse(reviewDto.getReviewContent());
		Elements afterElements = afterDocument.select(".after");
		for(Element element : afterElements) {
			int attachmentNo = Integer.parseInt(element.attr(".attachment"));
			after.add(attachmentNo);
		}
		
		// 비교
		return "redirect:detail?reviewNo="+reviewNo;
	}

	@RequestMapping("/delete")
	public String delete(@RequestParam int reviewNo) {
		ReviewDto reviewDto = reviewDao.selectOne(reviewNo);
		if(reviewDto == null) {
			throw new TargetNotFoundException("존재하지 않는 후기 입니다");
		}
		
		String content = reviewDto.getReviewContent();
		Document document = Jsoup.parse(content);
		Elements elements = document.select(".sunmmer");
		
		for(Element element : elements) {
			String dataset = element.attr("data-attachment-no");
			int attachmentNo = Integer.parseInt(dataset);
			//attachmentService.delete(attachmentNo);
		}
		
		reviewDao.delete(reviewNo);
		return "redirect:list";
	}
}
























