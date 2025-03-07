package com.kh.semiproject.configuration;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

import com.kh.semiproject.aop.AdminLoginInterceptor;
import com.kh.semiproject.aop.MemberLoginInterceptor;
import com.kh.semiproject.aop.NoticeReadInterceptor;
import com.kh.semiproject.aop.PlaceReadInterceptor;
import com.kh.semiproject.aop.ReviewReadInterceptor;

@Configuration
public class InterceptorConfiguration implements WebMvcConfigurer{
	@Autowired
	private PlaceReadInterceptor placeReadInterceptor;
	@Autowired
	private ReviewReadInterceptor reviewReadInterceptor;
	@Autowired
	private NoticeReadInterceptor noticeReadInterceptor;
	@Autowired
	private MemberLoginInterceptor memberLoginInterceptor;
	@Autowired 
	private AdminLoginInterceptor adminLoginInterceptor;
	
	@Override
	public void addInterceptors(InterceptorRegistry registry) {
		//여행지 조회 수 증가처리 인터셉터 등록
		registry.addInterceptor(placeReadInterceptor)
						.addPathPatterns("/place/detail");
		
		//후기 조회 수 증가처리 인터셉터 등록
		registry.addInterceptor(reviewReadInterceptor)
						.addPathPatterns("/review/detail");
		
		//공지사항 조회 수 증가처리 인터셉터 등록
		registry.addInterceptor(noticeReadInterceptor)
						.addPathPatterns("/notice/detail");
		
		//회원 전용 기능
		registry.addInterceptor(memberLoginInterceptor)
						.addPathPatterns(List.of(
							"/mypage/**",
							"/member/**",
							"/place/**",
							"/review/**",
							"/notice/**"	
						))
						.excludePathPatterns(List.of(
							"/member/join",
							"/member/login",
							"/member/exitFinish",
							"/place/list",
							"/place/detail",
							"/notice/list",
							"/notice/detail",
							"/review/list",
							"/review/detail"
						));
		
		//관리자 전용 기능
		registry.addInterceptor(adminLoginInterceptor)
						.addPathPatterns("/admin/**");
	}
}
