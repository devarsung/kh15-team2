package com.kh.semiproject.dto;

import java.sql.Timestamp;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data @Builder @NoArgsConstructor @AllArgsConstructor
public class NoticeDto {
	private int noticeNo;
	private String noticeTitle;
	private String noticeContent;
	private Timestamp noticeWtime;
	private Timestamp noticeEtime;
	private String noticeWriter;
	private int noticeRead;
	
	public String getWtimeString() {
		LocalDate today = LocalDate.now();
		LocalDateTime wtime = noticeWtime.toLocalDateTime();
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
		LocalDateTime wtime = noticeWtime.toLocalDateTime();
		LocalDate wdate = wtime.toLocalDate();
		if(wdate.isBefore(today)) {
			return wdate.toString();
		}
		else {
			return wtime.toLocalTime().format(DateTimeFormatter.ofPattern("HH:mm"));
		}
	}
}
