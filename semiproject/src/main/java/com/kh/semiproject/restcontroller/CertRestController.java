package com.kh.semiproject.restcontroller;

import java.time.Duration;
import java.time.LocalDateTime;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.kh.semiproject.dao.CertDao;
import com.kh.semiproject.dto.CertDto;
import com.kh.semiproject.service.CertService;

//cert에 대한 비동기 작업 처리
//@CrossOrigin
@RestController
@RequestMapping("/rest/cert")
public class CertRestController {
	@Autowired
	private CertService certService;
	@Autowired
	private CertDao certDao;
	
	@PostMapping("/send")
	public void send(@RequestParam String email) {
		certService.sendCertEmail(email);
	}
	
	@PostMapping("/check")
	public boolean check(@ModelAttribute CertDto certDto) {
		CertDto findDto = certDao.selectOne(certDto.getCertEmail());
		if(findDto == null) {
			return false;
			//throw new TargetNotFoundException();
		}
		//인증 유효 조건
		//1. 인증번호가 일치할 것
		//2. 지정한 시간 (10분) 내로 인증할 것(LocalDateTime. Duration)
		boolean condition1 = findDto.getCertNumber().equals(certDto.getCertNumber());
		
		LocalDateTime t1 = findDto.getCertTime().toLocalDateTime();//발송시각
		LocalDateTime t2 = LocalDateTime.now();//현재시각
		Duration duration = Duration.between(t1, t2);//차이 계산
		boolean condition2 = duration.toMinutes() < 10;//10분 미만
		boolean isValid = condition1&&condition2;
		if(isValid) {//인증번호가 일치한다면 인증번호 발송내역을 삭제
			//certDao.delete(certDto.getCertEmail());나중을 위해 보류
			certDao.confirm(certDto.getCertEmail());//인증시각이 기록되도록 처리
		}
		return isValid;
	}
}
