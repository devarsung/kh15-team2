package com.kh.semiproject.vo;

import lombok.Data;

@Data
public class PageVO {
	protected int page = 1;
	
	protected int size = 16;
	protected int count; // 전체 rownum 수량
	protected int blockSize = 10;
	protected String column;
	protected String keyword;
	
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
	

	public int getPrevBlock() {
		return getStartBlock() - 1;
	}
	
	public int getNextBlock() {
		return getFinishBlock() + 1;
	}
	
	public boolean hasPrevBlock() {
		return getStartBlock() > 1;
	}
	
	public boolean hasNextBlock() {
		return getFinishBlock() < getPageCount();
	}
	
	public boolean isLastBlock() {
		return getFinishBlock() == getPageCount();
	}
	
	public boolean isFirstBlock() {
		return getStartBlock() == 1;
	}
	
	public String getParameters() {
		if(isList()) {
			return "size="+size;
		}
		else {
			return "column="+column+"&keyword="+keyword+"&size="+size;
		}
	}
}

























