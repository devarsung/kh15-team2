package com.kh.semiproject.vo;

import java.util.List;

import lombok.Data;

@Data
public class RestPageVO {
	protected int page=1;
	
	protected int size=5;
	protected int count; // 전체 rownum 수량
	protected String memberId;
	
	public int getStartRownum() {
		return page*size - (size-1);
	}
	public int getFinishRownum() {
		return page*size;
	}
	
	public int getPageCount() {
		return (count - 1)/size + 1;
	}
	
	public int getNextPage() {
		return page+1;
	}
	
	public boolean isLastPage() {
		return page == this.getPageCount();
	}
	
	public boolean hasNextPage() {
		return page < this.getPageCount();
	}
	
	public String getParameters() {
			return "size="+size;
	}




}

























