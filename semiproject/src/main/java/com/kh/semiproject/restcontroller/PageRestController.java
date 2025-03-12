package com.kh.semiproject.restcontroller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.kh.semiproject.dao.PlaceDao;
import com.kh.semiproject.dao.MyReplyDao;
import com.kh.semiproject.dao.MyReviewDao;
import com.kh.semiproject.dao.PlaceLikeDao;
import com.kh.semiproject.dao.ReviewLikeDao;
import com.kh.semiproject.dto.MyReplyDto;
import com.kh.semiproject.dto.MyReviewDto;
import com.kh.semiproject.dto.PlaceLikeDto;
import com.kh.semiproject.dto.ReviewLikeDto;
import com.kh.semiproject.vo.RestPageVO;

import jakarta.servlet.http.HttpSession;

@CrossOrigin
@RestController
@RequestMapping("/rest/page")
public class PageRestController {
	@Autowired
	private PlaceLikeDao placeLikeDao;
	@Autowired
	private ReviewLikeDao reviewLikeDao;
	@Autowired
	private MyReviewDao myReviewDao;
	@Autowired
	private MyReplyDao myReplyDao;
	
	
	@RequestMapping("/myLikePlace")
	public Map<String, Object> placeList(RestPageVO restPageVO, HttpSession session) {
		String userId = (String)session.getAttribute("userId");
		restPageVO.setMemberId(userId);
		
		int count = placeLikeDao.count(restPageVO);//총 데이터의 개수
		restPageVO.setCount(count);
		
		List<PlaceLikeDto> list = placeLikeDao.selectListRest(restPageVO);//목록 리스트
		boolean isLastPage = restPageVO.isLastPage();//마지막 페이지인지 아닌지
		
		Map<String, Object> result = new HashMap<>();
		result.put("totalCount", count);//좋아요한 총 개수
		result.put("isLastPage", isLastPage);//마지막 페이지인지 아닌지
		result.put("length", list.size());//지금 페이지에서 조회한 목록 개수
		result.put("list", list);//지금 페이지에서 조회한 목록
		return result;
	}
	
	//placeRestController의 action은 반환하는 데이터가
	//나의 좋아요 여부, 이 여행지의 좋아요 개수인데
	//마이페이지에서 필요한건
	//나의 좋아요 여부, 나의 좋아요 개수
	//백엔드 분들이 구현하신거 큰 수정없이 사용하겠습니다  
	@PostMapping("action")
	public Map<String, Object> action(@RequestParam int placeNo, HttpSession session){
		String userId = (String)session.getAttribute("userId");
		
		boolean current = placeLikeDao.checkPlaceLike(userId, placeNo);
		if(current) {//이미 좋아요 한 상태
			placeLikeDao.deletePlaceLike(userId, placeNo);//삭제
		}
		else {//좋아요 한 적 없는 상태
			placeLikeDao.insertPlaceLike(userId, placeNo);//등록
		}
		int count = placeLikeDao.countPlaceLike(placeNo);//카운트 다시 구하기
		placeLikeDao.updatePlaceLike(placeNo, count);//좋아요 개수 갱신
		
		//위에 까진 똑같음
		
		//나의 좋아요 개수 구하기
		//placeLikeDao.count에서 restPageVO의 member_id만 사용하니 파라미터 맞춰주기
		RestPageVO restPageVO = new RestPageVO();
		restPageVO.setMemberId(userId);
		int myCount = placeLikeDao.count(restPageVO);
		
		Map<String, Object> map = new HashMap<>();
		map.put("done", !current);//이 회원의 좋아요 여부
		map.put("count", count);//이 여행지의 좋아요 개수
		map.put("myCount", myCount);//나의 좋아요 총 개수
		return map;
	}
	
	@RequestMapping("/myLikeReview")
	public Map<String, Object> reviewList(RestPageVO restPageVO, HttpSession session) {
		String userId = (String)session.getAttribute("userId");
		restPageVO.setMemberId(userId);
		
		int count = reviewLikeDao.count(restPageVO);//총 데이터의 개수
		restPageVO.setCount(count);
		
		List<ReviewLikeDto> list = reviewLikeDao.selectListRest(restPageVO);
		boolean isLastPage = restPageVO.isLastPage();//마지막 페이지인지 아닌지
		
		Map<String, Object> result = new HashMap<>();
		result.put("totalCount", count);//총 데이터 개수
		result.put("isLastPage", isLastPage);//마지막 페이지인지 아닌지
		result.put("length", list.size());//지금 페이지에서 조회한 목록 개수
		result.put("list", list);//지금 페이지에서 조회한 목록
		return result;
	}
	
	@RequestMapping("/myReview")
	public Map<String, Object> myReviewList(RestPageVO restPageVO, HttpSession session) {
		 String userId = (String) session.getAttribute("userId");
		 restPageVO.setMemberId(userId);
		 
		 int count = myReviewDao.count(restPageVO);
		 restPageVO.setCount(count);
		 
        List<MyReviewDto> list = myReviewDao.selectListRest(restPageVO);
        boolean isLastPage = restPageVO.isLastPage();//마지막 페이지인지 아닌지
        
        Map<String, Object> result = new HashMap<>();
		result.put("totalCount", count);//총 데이터 개수
		result.put("isLastPage", isLastPage);//마지막 페이지인지 아닌지
		result.put("length", list.size());//지금 페이지에서 조회한 목록 개수
		result.put("list", list);//지금 페이지에서 조회한 목록
		return result;
	}
	
	@RequestMapping("/myReply")
	public  Map<String, Object> myReplyList(RestPageVO restPageVO, HttpSession session) {
		String userId = (String) session.getAttribute("userId");
	    restPageVO.setMemberId(userId);
	    
	    int count = myReplyDao.count(restPageVO);
	    restPageVO.setCount(count);
	    
	    List<MyReplyDto> list = myReplyDao.selectListRest(restPageVO);
	    boolean isLastPage = restPageVO.isLastPage();//마지막 페이지인지 아닌지
	    
	    Map<String, Object> result = new HashMap<>();
		result.put("totalCount", count);//총 데이터 개수
		result.put("isLastPage", isLastPage);//마지막 페이지인지 아닌지
		result.put("length", list.size());//지금 페이지에서 조회한 목록 개수
		result.put("list", list);//지금 페이지에서 조회한 목록
		return result;
	}
	
}
















