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
			return "size=" + size + "&order=" + order;
		}
		else {
			StringBuilder parameters = new StringBuilder();
			parameters.append("&size=").append(size);
			
			if(keyword != null) {
				parameters.append("&column=").append(column)
							.append("&keyword=").append(keyword);
			}
			
			if(region != null) {
				parameters.append("&region=").append(region);
			}
			
			if(type != null) {
				parameters.append("&type=").append(type);
			}
			
			parameters.append("&order=").append(order);
			return parameters.toString();
		}
	}
}
