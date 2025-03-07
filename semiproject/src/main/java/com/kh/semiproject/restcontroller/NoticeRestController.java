package com.kh.semiproject.restcontroller;

import java.io.IOException;
import java.util.LinkedList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

import com.kh.semiproject.error.TargetNotFoundException;
import com.kh.semiproject.service.AttachmentService;

@RestController
@RequestMapping("/rest/notice")
public class NoticeRestController {
	@Autowired
	private AttachmentService attachmentService;
	
	@PostMapping("/upload")
	public int upload(@RequestParam MultipartFile attach) throws IllegalStateException, IOException {
		int attachmentNo;
		if(attach == null) {
			throw new TargetNotFoundException("파일이 존재하지 않습니다");
		}
		else{
			attachmentNo = attachmentService.save(attach);
		}
		return attachmentNo;
	}
	
	@PostMapping("/uploads")
	public List<Integer> uploads(@RequestParam (value="attach") List<MultipartFile> attaches) throws IllegalStateException, IOException{
		List<Integer> numbers = new LinkedList<>();
		if(attaches == null) {
			throw new TargetNotFoundException("파일이 존재하지 않습니다");
		}
		else{
			for(MultipartFile attach:attaches) {
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
