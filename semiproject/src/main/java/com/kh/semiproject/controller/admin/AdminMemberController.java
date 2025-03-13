package com.kh.semiproject.controller.admin;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.kh.semiproject.dao.MemberDao;
import com.kh.semiproject.vo.PageVO;

@Controller
@RequestMapping("/admin/member")
public class AdminMemberController {
	
	@Autowired
	private MemberDao memberDao;
	
	@RequestMapping("/list")
	public String list(@ModelAttribute ("pageVO")PageVO pageVO, Model model) {
		model.addAttribute("list", memberDao.selectList(pageVO));
		int count = memberDao.count(pageVO);
		pageVO.setCount(count);
		return "/WEB-INF/views/admin/member/list.jsp";
	}
	
	@RequestMapping("/detail")
	public String detail(@RequestParam String memberId, Model model) {
		model.addAttribute("memberDto", memberDao.selectOne(memberId));
		return "/WEB-INF/views/admin/member/detail.jsp";
	}
	
	@GetMapping("/edit")
	public String edit(@RequestParam String memberId, Model model) {
		model.addAttribute("memberDto", memberDao.selectOne(memberId));
		return "/WEB-INF/views/admin/member/edit.jsp";
	}
}
