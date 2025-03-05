package com.kh.semiproject.vo;

import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(callSuper = true)
public class PlacePageVO extends PageVO{
	private String region;
	private String type;
	
	//검색인지 확인
	@Override
	public boolean search() {
		return !isList();
	}
	
	//목록인지 확인
	@Override
	public boolean isList() {
		return super.keyword == null && this.region == null && this.type == null;
	}

	//링크를 위한 주소 생성 메소드
	@Override
	public String getParameters() {
		if(isList()) {
			return "size=" + size;
		}
		else {
			return "column=" + column + "&keyword=" + keyword + "&size=" + size 
				+ "&region=" + region + "&type=" + type;
		}
	}
}