package com.example.store.paging;

import org.apache.ibatis.type.Alias;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
@Alias("Pagable")
public class Pagable {

	private int page = 1;			// 요청파라미터에 page가 없는 경우 1이 기본값이다.
	private int size = 10;			// 요청파라미터에 size가 없는 경우 10이 기본값이다.
	private String sort = "date";	// 요청파라미터에 sort가 없는 경우 "date"가 기본값이다.

	public int getBeginIndex() {
		return (page - 1)*size + 1;
	}
	public int getEndIndex() {
		return page*size;
	}
}
