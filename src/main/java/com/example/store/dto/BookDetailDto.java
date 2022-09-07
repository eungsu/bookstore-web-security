package com.example.store.dto;

import java.util.List;

import org.apache.ibatis.type.Alias;

import com.example.store.vo.Book;
import com.example.store.vo.Review;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
@Alias("BookDetailDto")
public class BookDetailDto {

	private Book book;
	private List<Review> reviews;
}
