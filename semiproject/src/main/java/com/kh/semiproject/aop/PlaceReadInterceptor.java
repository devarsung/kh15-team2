package com.kh.semiproject.aop;

import java.util.HashSet;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.servlet.HandlerInterceptor;

import com.kh.semiproject.dao.PlaceDao;
import com.kh.semiproject.dto.PlaceDto;

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
public class PlaceReadInterceptor implements HandlerInterceptor{
	@Autowired
	private PlaceDao placeDao;
	//여행지 조회수
	@Override
	public boolean preHandle(HttpServletRequest request, 
			HttpServletResponse response, Object handler) {
		//여행지 번호 가져오기
		int placeNo = Integer.parseInt(request.getParameter("placeNo"));
		
		//1. 작성자(관리자)는 무조건 조회수 증가 금지
		HttpSession session = request.getSession();	
		String userId = (String)session.getAttribute("userId");
		PlaceDto placeDto = placeDao.selectOne(placeNo);
		if(userId != null && userId.equals(placeDto.getPlaceWriter())) {//여행지 작성자면
			return true;//조회수 증가하지 X
		}
		//2. 세션을 이용하여 읽은 글인지 확인
		HashSet<Integer> placeHistory = (HashSet<Integer>)session.getAttribute("placeHistory");
		if(placeHistory == null) {//없으면
			placeHistory = new HashSet<>();//새로 생성
		}
		if(placeHistory.contains(placeNo)) {//이미 본적있는 여행지라면
			return true;//조회수 증가 X 
		}
		else {//처음보는 여행지라면
			placeDao.updatePlaceRead(placeNo);//조회수 증가처리
			placeHistory.add(placeNo);//여행지저장소에 번호를 추가
			session.setAttribute("placeHistory", placeHistory);//세션을 갱신
		}
		return true;
	}
}
