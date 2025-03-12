package com.kh.semiproject.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Service;

import com.kh.semiproject.configuration.CertProperties;
import com.kh.semiproject.dao.CertDao;
import com.kh.semiproject.dto.CertDto;
import com.kh.semiproject.util.RandomGenerator;

@Service
public class CertService {
	@Autowired
	private JavaMailSender sender;
	@Autowired
	private CertDao certDao;
	@Autowired
	private RandomGenerator randomGenerator;
	@Autowired
	private CertProperties certProperties;

	public void sendCertEmail(String email) {
		// 인증번호 생성
		String number = randomGenerator.randomNumber(8);

		// 메세지 생성
		SimpleMailMessage message = new SimpleMailMessage();
		message.setTo(email);// 수신자설정
		message.setSubject("[KH관광공사] 인증번호 안내");// 제목설정
		message.setText("인증번호는 [" + number + "] 입니다");// 내용설정
		sender.send(message);// 전송

		// (+추가) DB등록
		certDao.insertOrUpdate(CertDto.builder().certEmail(email).certNumber(number).build());
	}

	// 정기적으로 인증정보 중 사용할 수 없는 것들을 제거하는 메소드
	@Scheduled(cron = "0 0 * * * *")
	public void work() {
		certDao.clean(certProperties.getExpireMinutes(), certProperties.getExpireAccept());
	}

}
