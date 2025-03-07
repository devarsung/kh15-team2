package com.kh.semiproject.dto;

import java.sql.Timestamp;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data @Builder @NoArgsConstructor @AllArgsConstructor
public class HelpDto {
	private int helpNo;
	private String helpTitle;
	private String helpContent;
	private String helpPlace;
	private String helpWriter;
	private int helpDepth;
	private int helpTarget;
	private Timestamp helpWtime;
	private Timestamp helpEtime;
}
