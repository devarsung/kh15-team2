package com.kh.semiproject.service;

import java.io.File;
import java.io.IOException;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.kh.semiproject.dao.AttachmentDao;
import com.kh.semiproject.dto.AttachmentDto;

@Service
public class AttachmentService {
	@Autowired
	private AttachmentDao attachmentDao;
	
	//파일 저장
	public int save(MultipartFile attach) throws IllegalStateException, IOException {
		if(attach.isEmpty()) return -1;
		//저장위치 생성
		File dir = new File("D:/uploadDir");
		if (!dir.exists()) {
            dir.mkdirs();  // 폴더 생성
        }
		//물리 파일 저장
		int attachmentNo = attachmentDao.sequence();//시퀸스번호 추출
		File target = new File(dir, String.valueOf(attachmentNo));//파일명으로 설정
		attach.transferTo(target);//저장
		//파일 정보 저장
		AttachmentDto attachmentDto = new AttachmentDto();
		attachmentDto.setAttachmentNo(attachmentNo);
		attachmentDto.setAttachmentName(attach.getOriginalFilename());
		attachmentDto.setAttachmentType(attach.getContentType());
		attachmentDto.setAttachmentSize(attach.getSize());
		attachmentDao.insert(attachmentDto);
		//파일 번호 반환
		return attachmentNo;
	}
}
