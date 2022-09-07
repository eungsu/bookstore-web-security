package com.example.store.paging;

import java.util.List;

public class Pagination<T> {

	private int number;		// 현재 페이지번호
	private int size ;		// 한 화면에 표시할 데이터 갯수
	private int pageSize;	// 한 화면에 표시할 페이지번호 갯수
	private int totalRows;	// 총 데이터 갯수
	private List<T> items;	// 화면에 출력할 데이터
	
	public Pagination(Pagable pagable, int totalRows, List<T> items) {
		this.number = pagable.getPage();
		this.size = pagable.getSize();
		this.totalRows = totalRows;
		this.pageSize = 5;
		this.items = items;
	}
	
	public int getNumber() {
		return number;
	}
	public int getSize() {
		return size;
	}
	public int getTotalRows() {
		return totalRows;
	}
	public int getTotalPages() {
		return (int) Math.ceil(((double) totalRows)/size);
	}
	public int getTotalBlocks() {
		return (int) Math.ceil(((double) getTotalPages())/pageSize);
	}
	public int getCurrentBlock() {
		return (int) Math.ceil(((double) number)/pageSize);
	}
	public int getBeginPage() {
		return (getCurrentBlock() - 1)*pageSize + 1; 
	}
	public int getEndPage() {
		return (getCurrentBlock() == getTotalBlocks()) ? getTotalPages() : getCurrentBlock()*pageSize;
	}
	public boolean isFirstBlock() {
		return getCurrentBlock() <= 1;
	}
	public boolean isLastBlock() {
		return getCurrentBlock() >= getTotalBlocks();
	}
	public int getPreviousBlockPage() {
		return (getCurrentBlock() - 1)*pageSize;
	}
	public int getNextBlockPage() {
		return getCurrentBlock()*pageSize + 1;
	}
	public List<T> getItems() {
		return items;
	}
}
