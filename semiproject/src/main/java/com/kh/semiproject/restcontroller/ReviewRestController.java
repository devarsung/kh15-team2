package com.kh.semiproject.restcontroller;

import java.io.IOException;
import java.util.HashMap;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

import com.kh.semiproject.dao.ReviewLikeDao;
import com.kh.semiproject.error.TargetNotFoundException;
import com.kh.semiproject.service.AttachmentService;

import jakarta.servlet.http.HttpSession;

@CrossOrigin
@RestController
@RequestMapping("/rest/review")
public class ReviewRestController {
	
	@Autowired
	private ReviewLikeDao reviewLikeDao;
	
	@Autowired
	private AttachmentService attachmentService;
	
	//좋아요 여부 검사 매핑
	@PostMapping("/check")
	public Map<String, Object> check(@RequestParam int reviewNo, HttpSession session){
		String userId = (String)session.getAttribute("userId");
		
		boolean done = reviewLikeDao.checkReviewLike(userId, reviewNo);
		int count = reviewLikeDao.countReviewLike(reviewNo);
		
		Map<String, Object> map = new HashMap<>();
		map.put("done", done);//이 회원의 좋아요 여부
		map.put("count", count);//이 후기의 좋아요 개수
		return map;
	}
	
	//좋아요 설정/해제 매핑 → 게시글의 좋아요 개수를 갱신
	@PostMapping("action")
	public Map<String, Object> action(@RequestParam int reviewNo, HttpSession session){
		String userId = (String)session.getAttribute("userId");
		
		boolean current = reviewLikeDao.checkReviewLike(userId, reviewNo);
		if(current) {//이미 좋아요 한 상태
			reviewLikeDao.deleteReviewLike(userId, reviewNo);//삭제
		}
		else {//좋아요 한 적 없는 상태
			reviewLikeDao.insertReviewLike(userId, reviewNo);//등록
		}
		int count = reviewLikeDao.countReviewLike(reviewNo);//카운트 다시 구하기
		reviewLikeDao.updateReviewLike(reviewNo, count);//좋아요 개수 갱신
		
		Map<String, Object> map = new HashMap<>();
		map.put("done", !current);//이 회원의 좋아요 여부
		map.put("count", count);//이 후기의 좋아요 개수
		return map;
	}
	
	@PostMapping("/upload")
	public int upload(@RequestParam MultipartFile attach) throws IllegalStateException, IOException {
		int attachmentNo;
		if(attach == null) {
			throw new TargetNotFoundException("첨부파일이 존재하지 않습니다");
		}
		else {
			attachmentNo = attachmentService.save(attach);
		}
		return attachmentNo;
	}
	
	@PostMapping("/uploads")
	public List<Integer> uploads(@RequestParam (value = "attach")List<MultipartFile> attaches) throws IllegalStateException, IOException {
		List<Integer> numbers = new LinkedList<>();
		if(attaches == null) {
			throw new TargetNotFoundException("첨부파일이 존재하지 않습니다");
		}
		else {
			for(MultipartFile attach : attaches) {
				if(attach == null) {
					continue;
				}
				int attachmentNo = attachmentService.save(attach);
				 numbers.add(attachmentNo);
			}
		}
		
		return numbers;
	}

}





























