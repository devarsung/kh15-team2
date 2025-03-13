package com.kh.semiproject.restcontroller;

import java.time.Duration;
import java.time.LocalDateTime;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServletResponse;

@RestController
@RequestMapping("/rest/cookie")
public class CookieRestController {

	
		@GetMapping("/ad")
		public void ad(HttpServletResponse response) {
			
			LocalDateTime current= LocalDateTime.now();
			
			LocalDateTime limit=current.plusDays(1L).withHour(0).withMinute(0).withSecond(0);
			Duration duration= Duration.between(current, limit);
			int seconds=(int)duration.toSeconds();
			
			Cookie cookie =new Cookie("adblock", "OK");
			cookie.setMaxAge(seconds);
			cookie.setPath("/");
			response.addCookie(cookie);
		}
}
