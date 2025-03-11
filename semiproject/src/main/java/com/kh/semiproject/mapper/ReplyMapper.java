package com.kh.semiproject.mapper;

import java.sql.ResultSet;
import java.sql.SQLException;

import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Component;

import com.kh.semiproject.dto.ReplyDto;

@Component
public class ReplyMapper implements RowMapper<ReplyDto> {
    @Override
    public ReplyDto mapRow(ResultSet rs, int rowNum) throws SQLException {
        return ReplyDto.builder()
                .replyNo(rs.getInt("reply_no")) // ✅ 소문자로 수정
                .replyOrigin(rs.getInt("reply_origin")) // ✅ 소문자로 수정
                .replyWriter(rs.getString("member_nickname")) // ✅ 소문자로 수정
                .replyContent(rs.getString("reply_content")) // ✅ 소문자로 수정
                .replyWtime(rs.getTimestamp("reply_wtime")) // ✅ 소문자로 수정
                .replyEtime(rs.getTimestamp("reply_etime")) // ✅ 소문자로 수정
                .build();
    }
}

