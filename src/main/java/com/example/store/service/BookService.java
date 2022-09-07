package com.example.store.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.example.store.mapper.BookMapper;
import com.example.store.mapper.ReviewMapper;
import com.example.store.paging.Criteria;
import com.example.store.paging.Pagable;
import com.example.store.paging.Pagination;
import com.example.store.vo.Book;
import com.example.store.vo.Review;
import com.example.store.vo.User;
import com.example.store.web.form.ReviewForm;

import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
@Service
public class BookService {

	private final BookMapper bookMapper;
	private final ReviewMapper reviewMapper;
	
	public Pagination<Book> getBooks(Pagable pagable, Criteria criteria) {
		int totalRows = bookMapper.getTotalRows(criteria);
		List<Book> books = bookMapper.getBooks(pagable, criteria);
		
		return new Pagination<>(pagable, totalRows, books);
	}

	public Book getBookById(int bookId) {
		return bookMapper.getBookById(bookId);
	}
	
	public Pagination<Review> getReviews(Pagable pagable, int bookId) {
		int totalRows = reviewMapper.getReviewTotalRows(bookId);
		List<Review> reviews = reviewMapper.getReviewsByBookId(pagable, bookId);
		
		return new Pagination<>(pagable, totalRows, reviews);
	}
	
	public void changeBookStock(int bookId, int quantity) {
		Book book = bookMapper.getBookById(bookId);
		book.setStock(book.getStock() - 1);
		if (book.getStock() == 0) {
			book.setOnSell("N");
		}
		
		bookMapper.updateBook(book);
	}
	
	public void addReview(ReviewForm reviewForm, User loginUser) {
		Book book = bookMapper.getBookById(reviewForm.getBookId());
		
		Review review = new Review();
		review.setContent(reviewForm.getContent());
		review.setScore(reviewForm.getScore());
		review.setUser(loginUser);
		review.setBook(book);
		
		reviewMapper.insertReview(review);
		
		int reviewCount = book.getReviewCount() + 1;
		double reviewScore = (book.getReviewScore()*book.getReviewCount() + reviewForm.getScore())/reviewCount;
		book.setReviewCount(reviewCount);
		book.setReviewScore(reviewScore);
		
		bookMapper.updateBook(book);
	}

	public void deleteReview(int bookId, int reviewId, User loginUser) {
		Review review = reviewMapper.getReviewById(reviewId);
		reviewMapper.deleteReview(reviewId);
		
		Book book = bookMapper.getBookById(bookId);
		
		int reviewCount = book.getReviewCount();
		double reviewScore = book.getReviewScore();
		double totalReviewScore = Math.ceil(reviewCount*reviewScore);
		
		reviewScore = (totalReviewScore - review.getScore())/(reviewCount - 1);
		
		book.setReviewCount(reviewCount - 1);
		book.setReviewScore(reviewScore);
		
		bookMapper.updateBook(book);
	}

}
