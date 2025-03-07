package com.kh.semiproject.controller.admin;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.kh.semiproject.dao.StatusDao;

@Controller
@RequestMapping("/admin/status")
public class AdminStatusController {
	@Autowired
	private StatusDao statusDao;
	
	@RequestMapping("member")
	public String member(Model model) {
		model.addAttribute("memberGenderList", statusDao.memberGenderGroup());
		
		return "/WEB-INF/views/admin/status/member.jsp";
	}
}
