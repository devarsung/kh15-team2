package com.kh.semiproject.restcontroller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

import com.kh.semiproject.dao.PlaceLikeDao;
import com.kh.semiproject.error.TargetNotFoundException;
import com.kh.semiproject.service.AttachmentService;

import jakarta.servlet.http.HttpSession;

@CrossOrigin
@RestController
@RequestMapping("/rest/place")
public class PlaceRestController {
	@Autowired
	private PlaceLikeDao placeLikeDao;
	
	//좋아요 여부 검사 매핑
	@PostMapping("/check")
	public Map<String, Object> check(@RequestParam int placeNo, HttpSession session){
		String userId = (String)session.getAttribute("userId");
		
		boolean done = placeLikeDao.checkPlaceLike(userId, placeNo);
		int count = placeLikeDao.countPlaceLike(placeNo);
		
		Map<String, Object> map = new HashMap<>();
		map.put("done", done);//이 회원의 좋아요 여부
		map.put("count", count);//이 여행지의 좋아요 개수
		return map;
	}
	
	//좋아요 설정/해제 매핑 → 게시글의 좋아요 개수를 갱신
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
		
		Map<String, Object> map = new HashMap<>();
		map.put("done", !current);//이 회원의 좋아요 여부
		map.put("count", count);//이 여행지의 좋아요 개수
		return map;
	}
	
	//첨부파일 업로드(summernote 전용 기능)
		@Autowired
		private AttachmentService attachmentService;
		
		@PostMapping("/upload")
		public int upload(@RequestParam MultipartFile attach) throws IllegalStateException, IOException{
			if(attach.isEmpty()) {
				throw new TargetNotFoundException("첨부파일이 없습니다");
			}
			
			return attachmentService.save(attach);
		}
		@PostMapping("/uploads")
		public List<Integer> uploads(
				@RequestParam(value="attach") List<MultipartFile> attachList) throws IllegalStateException, IOException{
			List<Integer> numbers = new ArrayList<>();
			for(MultipartFile attach : attachList) {
				if(attach.isEmpty()) continue;
				int attachmentNo = attachmentService.save(attach);
				numbers.add(attachmentNo);
			}
			return numbers;
		}
}
