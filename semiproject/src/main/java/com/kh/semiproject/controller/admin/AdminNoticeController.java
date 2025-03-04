package com.kh.semiproject.controller.admin;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.kh.semiproject.dao.NoticeDao;
import com.kh.semiproject.dao.NoticeListViewDao;
import com.kh.semiproject.dto.NoticeDto;
import com.kh.semiproject.dto.NoticeListViewDto;
import com.kh.semiproject.vo.PageVO;

import jakarta.servlet.http.HttpSession;

@Controller
@RequestMapping("/admin/notice")
public class AdminNoticeController {
	@Autowired
	public NoticeDao noticeDao;
	
	@Autowired
	public NoticeListViewDao noticeListViewDao;
	
	@GetMapping("/add")
	public String add() {
		return "/WEB-INF/views/admin/notice/add.jsp";
	}
	
	@PostMapping("/add")
	public String add(@ModelAttribute NoticeDto noticeDto, HttpSession session) {
		String userId = (String) session.getAttribute("userId");
		noticeDto.setNoticeWriter(userId);
		int noticeNo = noticeDao.sequence();
		noticeDto.setNoticeNo(noticeNo);
		return "redirect:/admin/detail?noticeNo="+noticeNo;
	}
	
	
	@RequestMapping("/list")
	public String list(@ModelAttribute ("pageVO") PageVO pageVO, Model model) {
		List<NoticeListViewDto> list = noticeListViewDao.selectList(pageVO);
		model.addAttribute("list",list);
		return "/WEB-INF/views/admin/notice/list.jsp";
	}
	
	@RequestMapping("/detail")
	public String detail(@RequestParam int noticeNo, Model model) {
		NoticeDto noticeDto = noticeDao.selectOne(noticeNo);
		model.addAttribute("noticeDto",noticeDto);
		return "/WEB-INF/views/admin/notice/detail.jsp";
	}
	
	@GetMapping("/edit")
	public String edit(@RequestParam int noticeNo, Model model) {
		NoticeDto noticeDto = noticeDao.selectOne(noticeNo);
		model.addAttribute("noticeDto",noticeDto);
		return "/WEB-INF/views/admin/notice/edit.jsp";
	}
	
	@PostMapping("/edit")
	public String edit(@ModelAttribute NoticeDto noticeDto) {
		int noticeNo = noticeDto.getNoticeNo();
		noticeDao.update(noticeDto);
		return "redirect:admin/detail?noticeNo="+noticeNo;
	}
}















