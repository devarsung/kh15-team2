package com.kh.semiproject.dto;

import java.sql.Timestamp;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class MyReplyDto {
    private int replyNo;
    private String replyWriter; // 원래 저장된 userId
    private String replyNickname; // 닉네임 추가 (조회용)
    private int replyOrigin;
    private String replyContent;
    private Timestamp replyWtime;
    private Timestamp replyEtime;
    
    private String reviewTitle;
    
    public String getWtimeString() {
		LocalDate today = LocalDate.now();
		LocalDateTime wtime = replyWtime.toLocalDateTime();
		LocalDate wdate = wtime.toLocalDate();
		if(wdate.isBefore(today)) {
			return wdate.toString();
		}
		else {
			return wtime.toLocalTime().format(DateTimeFormatter.ofPattern("HH:mm"));
		}
	}	
	
	public String getEtimeString() {
		LocalDate today = LocalDate.now();
		LocalDateTime wtime = replyWtime.toLocalDateTime();
		LocalDate wdate = wtime.toLocalDate();
		if(wdate.isBefore(today)) {
			return wdate.toString();
		}
		else {
			return wtime.toLocalTime().format(DateTimeFormatter.ofPattern("HH:mm"));
		}
	}	
}
