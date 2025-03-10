package com.kh.semiproject.dto;


import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class PlaceLikeDto {
    private int placeNo;          // 여행지 번호
    private int likeCount;        // 좋아요 개수
    
    private String placeTitle;    // 여행지 이름
    private String placeType;     // 여행지 타입
    private String placeRegion;   // 여행지 지역
    private int placeFirstImage;  // 대표 이미지 (첨부파일 번호)
}