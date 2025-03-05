package com.kh.semiproject.controller;

import java.io.IOException;
import java.nio.charset.StandardCharsets;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.ByteArrayResource;
import org.springframework.http.ContentDisposition;
import org.springframework.http.HttpHeaders;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.kh.semiproject.dao.AttachmentDao;
import com.kh.semiproject.dto.AttachmentDto;
import com.kh.semiproject.service.AttachmentService;

@Controller
@RequestMapping("/attachment")
public class FileDownloadController {
	@Autowired
	private AttachmentDao attachmentDao;
	@Autowired
	private AttachmentService attachmentService;

	@RequestMapping("/download")
	public ResponseEntity<ByteArrayResource> download(@RequestParam int attachmentNo) throws IOException {
		byte[] data = attachmentService.load(attachmentNo);
		AttachmentDto attachmentDto = attachmentDao.selectOne(attachmentNo);

		// 포장(Wrap)
		ByteArrayResource resource = new ByteArrayResource(data);

		// 반환
		return ResponseEntity.ok().header(HttpHeaders.CONTENT_ENCODING, "UTF-8")
				.header(HttpHeaders.CONTENT_TYPE, attachmentDto.getAttachmentType())// 알 때
				// .contentType(MediaType.APPLICATION_OCTET_STREAM)//모를 떄
				.contentLength(attachmentDto.getAttachmentSize())
				.header(HttpHeaders.CONTENT_DISPOSITION,
						ContentDisposition.attachment()
								.filename(attachmentDto.getAttachmentName(), StandardCharsets.UTF_8).build().toString())
				.body(resource);
	}
}
