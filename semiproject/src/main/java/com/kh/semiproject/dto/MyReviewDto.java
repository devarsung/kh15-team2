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
public class MyReviewDto {
	private int reviewNo; // 후기 번호
	private String reviewTitle; // 후기 제목
	private String reviewWriter; // 작성자
	private int reviewLike; // 좋아요 수
	private int reviewRead; // 조회수
	private int reviewReply; // 댓글 수
	private Timestamp reviewWtime; // 작성 시간
	private Timestamp reviewEtime; // 수정 시간

	public String getWtimeString() {
		LocalDate today = LocalDate.now();
		LocalDateTime wtime = reviewWtime.toLocalDateTime();
		LocalDate wdate = wtime.toLocalDate();
		if (wdate.isBefore(today)) {
			return wdate.toString();
		} else {
			return wtime.toLocalTime().format(DateTimeFormatter.ofPattern("HH:mm"));
		}
	}

	public String getEtimeString() {
		LocalDate today = LocalDate.now();
		LocalDateTime wtime = reviewWtime.toLocalDateTime();
		LocalDate wdate = wtime.toLocalDate();
		if (wdate.isBefore(today)) {
			return wdate.toString();
		} else {
			return wtime.toLocalTime().format(DateTimeFormatter.ofPattern("HH:mm"));
		}
	}
}
