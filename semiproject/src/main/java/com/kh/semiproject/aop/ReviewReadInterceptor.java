package com.kh.semiproject.aop;

import java.util.HashSet;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.servlet.HandlerInterceptor;

import com.kh.semiproject.dao.ReviewDao;
import com.kh.semiproject.dto.ReviewDto;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
/**
 	조회 수 증가를 하지 않아야할 상황
 	1.관리자가 작성한 여행지를 관리자가 읽는 경우 조회수 증가 X
 	2. 같은 세션당 한 번만 조회 수가 증가되도록 처리
 	- 세션에 현재 사용자가 읽은 글 번호를 저장할 저장소를 설정
	- HashSet<Integer>
	- 회원이든 비회원이든 상관없음
 */
@Service
public class ReviewReadInterceptor implements HandlerInterceptor{
	@Autowired
	private ReviewDao reviewDao;
	//여행지 조회수
	@Override
	public boolean preHandle(HttpServletRequest request, 
			HttpServletResponse response, Object handler) {
		//후기 번호 가져오기
		int reviewNo = Integer.parseInt(request.getParameter("reviewNo"));
		
		//1. 작성자는 무조건 조회수 증가 금지
		HttpSession session = request.getSession();	
		String userId = (String)session.getAttribute("userId");
		ReviewDto reviewDto = reviewDao.selectOne(reviewNo);
		if(userId != null && userId.equals(reviewDto.getReviewWriter())) {//후기 작성자면
			return true;//조회수 증가하지 X
		}
		//2. 세션을 이용하여 읽은 후기인지 확인
		HashSet<Integer> reviewHistory = (HashSet<Integer>)session.getAttribute("reviewHistory");
		if(reviewHistory == null) {//없으면
			reviewHistory = new HashSet<>();//새로 생성
		}
		if(reviewHistory.contains(reviewNo)) {//이미 본적있는 후기라면
			return true;//조회수 증가 X 
		}
		else {//처음보는 후기라면
			reviewDao.updateReviewRead(reviewNo);//조회수 증가처리
			reviewHistory.add(reviewNo);//후기저장소에 번호를 추가
			session.setAttribute("reviewHistory", reviewHistory);//세션을 갱신
		}
		return true;
	}
}
