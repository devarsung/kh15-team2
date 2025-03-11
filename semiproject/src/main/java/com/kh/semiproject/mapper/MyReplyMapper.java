package com.kh.semiproject.mapper;

import java.sql.ResultSet;
import java.sql.SQLException;

import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Component;

import com.kh.semiproject.dto.MyReplyDto;

@Component
public class MyReplyMapper implements RowMapper<MyReplyDto> {
    @Override
    public MyReplyDto mapRow(ResultSet rs, int rowNum) throws SQLException {
        return MyReplyDto.builder()
                .replyNo(rs.getInt("reply_no")) 
                .replyOrigin(rs.getInt("reply_origin")) 
                .reviewTitle(rs.getString("review_title")) 
                .replyWriter(rs.getString("member_nickname")) 
                .replyContent(rs.getString("reply_content")) 
                .replyWtime(rs.getTimestamp("reply_wtime")) 
                .replyEtime(rs.getTimestamp("reply_etime"))
                .build();
    }
}


