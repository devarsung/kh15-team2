package com.kh.semiproject.dto;

import java.sql.Timestamp;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class ReplyDto {
    private int replyNo;
    private String replyWriter; // 원래 저장된 userId
    private int replyOrigin;
    private String replyContent;
    private Timestamp replyWtime;
    private Timestamp replyEtime;
}

