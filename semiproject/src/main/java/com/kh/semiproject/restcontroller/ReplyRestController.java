package com.kh.semiproject.restcontroller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.kh.semiproject.dao.ReplyDao;
import com.kh.semiproject.dao.ReviewDao;
import com.kh.semiproject.dto.ReplyDto;

import jakarta.servlet.http.HttpSession;

@CrossOrigin
@RestController
@RequestMapping("/rest/reply")
public class ReplyRestController {
	@Autowired
	private ReplyDao replyDao;
	@Autowired
	private ReviewDao reviewDao;
	
	//댓글 목록
	@RequestMapping("/list")
	public List<ReplyDto> list(@RequestParam int replyOrigin){
		return replyDao.selectList(replyOrigin);
	}
	
	//댓글 작성
	@RequestMapping("/write")
	public void write(@ModelAttribute ReplyDto replyDto, HttpSession session) {
		String userId = (String)session.getAttribute("userId");
		replyDto.setReplyWriter(userId);
		int replyNo = replyDao.sequence();
		replyDto.setReplyNo(replyNo);
		
		replyDao.insert(replyDto);//댓글 등록
		reviewDao.updateReviewReply(replyDto.getReplyOrigin());//댓글개수 갱신
	}
	
	//댓글 삭제
	@PostMapping("/delete")
	public void delete(@RequestParam int replyNo) {
		ReplyDto replyDto = replyDao.selectOne(replyNo);
		replyDao.delete(replyNo);//댓글 삭제
		reviewDao.updateReviewReply(replyDto.getReplyOrigin());//댓글개수 갱신
	}
	
	//댓글 수정
	@PostMapping("/edit")
	public void edit(@ModelAttribute ReplyDto replyDto) {
		replyDao.update(replyDto);
	}
}
