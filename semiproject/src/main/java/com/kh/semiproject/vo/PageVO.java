package com.kh.semiproject.vo;

import lombok.Data;

@Data
public class PageVO {
	private int page;
	private int size;
	private int count; // 전체 rownum 수량
	private int blockSize;
	private String column;
	private String keyword;
	public boolean search() {
		return column != null && keyword != null;
	}
	public boolean isList() {
		return !search();
	}
	
	public int getStartRownum() {
		return page*size - (size-1);
	}
	public int getFinishRownum() {
		return page*size;
	}
	
	public int getStartBlock() {
		return (page-1)/size * size + 1;
	}
	
	public int getFinishBlock() {
		int number = (page - 1)/blockSize*blockSize + blockSize; 
		return Math.min(number, getPageCount());
	}
	
	public int getPageCount() {
		return (count - 1)/size + 1;
	}

}

























