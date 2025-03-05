package com.kh.semiproject.aop;

import org.springframework.beans.propertyeditors.StringTrimmerEditor;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.InitBinder;

@ControllerAdvice(basePackages = {"com.kh.semiproject.controller"})
public class EmptyStringControllerAdvice {
	
	@InitBinder//컨트롤러 처리 전에 사전 밑작업을 할 수 있는 메소드
	public void initBinder(WebDataBinder binder) {
		//binder에 원하는 변조작업을 처리할 수 있는 도구를 등록
		//binder.registerCustomEditor(String.class, 빈칸을 null로 처리하는 도구);
		binder.registerCustomEditor(String.class, new StringTrimmerEditor(true));
	}
}
