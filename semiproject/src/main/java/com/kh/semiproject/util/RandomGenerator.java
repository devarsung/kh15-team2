package com.kh.semiproject.util;

import java.util.Random;

import org.springframework.stereotype.Component;

@Component
public class RandomGenerator {
	
	private Random r = new Random();
	
	//[1] 원하는 자리수의 랜덤 숫자를 생성
	public String randomNumber(int size) {
		StringBuffer buffer = new StringBuffer();
		for(int i=0; i<size; i++) {		
			buffer.append(r.nextInt(10));
		}
		return buffer.toString();
	}
	
	//[2] 원하는 자리수의 랜덤 문자열을 생성
}
