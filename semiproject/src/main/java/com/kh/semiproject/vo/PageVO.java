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
	protected String order;
	protected Integer placeNo;
	protected Integer reviewNo;
	
	
	
	public boolean byPlace() { //placeNo 로 받았을때
		return placeNo != null;
	}
	public boolean byReview() { // reviewNo 로 받았을때
		return reviewNo != null;
	}
	
	public boolean search() {
		return (column != null || keyword != null) && !byPlace();
	}
	public boolean isList() {
		return !search() && !byPlace();
	}
	
	public int getStartRownum() {
		return page*size - (size-1);
	}
	public int getFinishRownum() {
		return page*size;
	}
	
	public int getStartBlock() {
		return(page - 1)/blockSize*blockSize + 1;
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
		else if(search()){
			return "column="+column+"&keyword="+keyword+"&size="+size;
		}
		else {
			return "placeNo="+placeNo; 
		}
	}
}

























