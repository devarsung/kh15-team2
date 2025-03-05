package com.kh.semiproject.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.kh.semiproject.dao.NoticeDao;
import com.kh.semiproject.dao.NoticeListViewDao;
import com.kh.semiproject.dto.NoticeDto;
import com.kh.semiproject.dto.NoticeListViewDto;
import com.kh.semiproject.error.TargetNotFoundException;
import com.kh.semiproject.vo.PageVO;

@Controller
@RequestMapping("/notice")
public class NoticeController {


	@Autowired
	private NoticeDao noticeDao;
	
	@Autowired
	private NoticeListViewDao noticeListViewDao;
	
	@RequestMapping("/list")
	public String list(@ModelAttribute ("pageVO")PageVO pageVO, Model model) {
		List<NoticeListViewDto> list = noticeListViewDao.selectList(pageVO);
		model.addAttribute("list",list);
		return "/WEB-INF/views/notice/list.jsp";
	}
	@RequestMapping("/detail")
	public String detail(@RequestParam int noticeNo, Model model) {
		NoticeDto noticeDto = noticeDao.selectOne(noticeNo);
		if(noticeDto == null) {
			throw new TargetNotFoundException("존재 하지 않는 공지 사항 입니다");
		}
		model.addAttribute("noticeDto",noticeDto);
		return "/WEB-INF/views/notice/detail.jsp";
	}
	

}
