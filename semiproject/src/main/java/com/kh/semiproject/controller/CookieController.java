package com.kh.semiproject.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServletResponse;

@Controller
@RequestMapping("/cookie")
public class CookieController {
	
	@RequestMapping("/home")
	public String home() {
		return "/WEB-INF/views/cookie/home.jsp";
	}
	
	@RequestMapping("/create")
	public String create(@RequestParam String dummy, 
									HttpServletResponse response) {
		//쿠키 생성
		//[1] 쿠키 인스턴스 생성(Cookie)
		//[2] 쿠키 정보 설정
		//[3] 쿠키를 사용자에게 보낼 응답 데이터에 첨부(HttpServletResponse)
		Cookie cookie = new Cookie("dummy", dummy);//[1]
		cookie.setMaxAge(10);//[2] 만약 시간이 0이면 삭제와 같은 효과
		response.addCookie(cookie);//[3]
		
		return "redirect:home";
	}
	
}