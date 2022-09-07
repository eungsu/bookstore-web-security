package com.example.store.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.example.store.paging.Criteria;
import com.example.store.paging.Pagable;
import com.example.store.vo.Book;

@Mapper
public interface BookMapper {

	int getTotalRows(Criteria criteria);    
	List<Book> getBooks(@Param("pagable") Pagable pagable, @Param("criteria") Criteria criteria);
	Book getBookById(int bookId);
	void updateBook(Book book);
}
