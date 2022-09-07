package com.example.store.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.example.store.paging.Pagable;
import com.example.store.vo.Review;

@Mapper
public interface ReviewMapper {

	void insertReview(Review review);
	void deleteReview(int reviewId);
	Review getReviewById(int reviewId);
	int getReviewTotalRows(int bookId);
	List<Review> getReviewsByBookId(@Param("pagable") Pagable pagable, @Param("bookId") int bookId);
}
