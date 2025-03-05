package com.kh.semiproject.controller.admin;

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

import com.kh.semiproject.dao.NoticeDao;
import com.kh.semiproject.dao.NoticeListViewDao;
import com.kh.semiproject.dto.NoticeDto;
import com.kh.semiproject.dto.NoticeListViewDto;
import com.kh.semiproject.error.TargetNotFoundException;
import com.kh.semiproject.service.AttachmentService;
import com.kh.semiproject.vo.PageVO;

import jakarta.servlet.http.HttpSession;

@Controller
@RequestMapping("/admin/notice")
public class AdminNoticeController {
	@Autowired
	private NoticeDao noticeDao;
	
	@Autowired
	private NoticeListViewDao noticeListViewDao;
	
	@Autowired
	private AttachmentService attachmentService;
	
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
		if(noticeDto == null) {
			throw new TargetNotFoundException("존재 하지 않는 공지 사항 입니다");
		}
		model.addAttribute("noticeDto",noticeDto);
		return "/WEB-INF/views/admin/notice/detail.jsp";
	}
	
	@GetMapping("/edit")
	public String edit(@RequestParam int noticeNo, Model model) {
		NoticeDto noticeDto = noticeDao.selectOne(noticeNo);
		if(noticeDto == null) {
			throw new TargetNotFoundException("존재 하지 않는 공지 사항 입니다");
		}
		model.addAttribute("noticeDto",noticeDto);
		return "/WEB-INF/views/admin/notice/edit.jsp";
	}
	
	@PostMapping("/edit")
	public String edit(@ModelAttribute NoticeDto noticeDto ) {
		int noticeNo = noticeDto.getNoticeNo();
		NoticeDto originDto = noticeDao.selectOne(noticeNo);
		
		Set<Integer> before = new HashSet<>();
		Document beforeDocument = Jsoup.parse(originDto.getNoticeContent());
		Elements beforeElements = beforeDocument.select(".somnething");
		for(Element element:beforeElements) {
			int attachmentNo = Integer.parseInt(element.attr(".attach"));
			before.add(attachmentNo);
		}
		
		
		Set<Integer> after = new HashSet<>();
		Document afterDocument = Jsoup.parse(noticeDto.getNoticeContent());
		Elements afterElements = afterDocument.select(".something");
		for(Element element:afterElements) {
			int attachmentNo = Integer.parseInt(element.attr(".attach"));
			after.add(attachmentNo);
		}
		
		Set<Integer> minus = new HashSet<>(before);
		minus.removeAll(after);
		
		for(int attachmentNo:minus) {
			attachmentService.delete(attachmentNo);
		}
		noticeDao.update(noticeDto);
		return "redirect:/admin/detail?noticeNo="+noticeNo;
	}
	
	@RequestMapping("/delete")
	public String delete(@RequestParam int noticeNo) {
		NoticeDto noticeDto = noticeDao.selectOne(noticeNo);
		if(noticeDto == null) {
			throw new TargetNotFoundException("존재 하지 않는 공지 사항 입니다");
		}
		String content = noticeDto.getNoticeContent();
		Document document = Jsoup.parse(content);
		Elements elements = document.select(".ddd");
		
		for(Element element : elements) {
			String data = element.attr("data-set");
			int attachmentNo = Integer.parseInt(data);
			attachmentService.delete(attachmentNo);
		}
		
		noticeDao.delete(noticeNo);
		return "redirect:/admin/list";
	}
}















