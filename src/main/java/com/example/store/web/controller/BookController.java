package com.example.store.web.controller;

import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.example.store.paging.Criteria;
import com.example.store.paging.Pagable;
import com.example.store.paging.Pagination;
import com.example.store.service.BookService;
import com.example.store.vo.Book;
import com.example.store.vo.Review;
import com.example.store.vo.User;
import com.example.store.web.form.ReviewForm;

import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
@Controller
@RequestMapping("/book")
public class BookController {

	private final BookService bookService;
	
	@GetMapping("/list")
	public String books(Pagable pagable, Criteria criteria,  Model model) {
		Pagination<Book> pagination = bookService.getBooks(pagable, criteria);
		
		model.addAttribute("books", pagination.getItems());
		model.addAttribute("pagination", pagination);
		
		return "book/list";
	}
	
	@GetMapping("/detail")
	public String detail(Pagable pagable, @RequestParam(name = "id") int bookId, Model model) {
		Book book = bookService.getBookById(bookId);
		
		pagable.setSize(4);
		Pagination<Review> pagination = bookService.getReviews(pagable, bookId);
		
		model.addAttribute("book", book);
		model.addAttribute("reviews", pagination.getItems());
		model.addAttribute("pagination", pagination);
		
		return "book/detail";
	}
	
	@PostMapping("/review/add")
	public String addReview(Authentication authentication, ReviewForm form, RedirectAttributes redirectAttributes) {
		User loginUser = (User) authentication.getPrincipal();
		
		bookService.addReview(form, loginUser);
		redirectAttributes.addAttribute("id", form.getBookId());
		
		return "redirect:/book/detail";
	}
	
	@GetMapping("/review/delete")
	public String addReview(Authentication authentication, @RequestParam(name = "id") int bookId, @RequestParam(name = "rid") int reviewId, RedirectAttributes redirectAttributes) {
		User loginUser = (User) authentication.getPrincipal();
		
		bookService.deleteReview(bookId, reviewId, loginUser);
		redirectAttributes.addAttribute("id", bookId);
		
		return "redirect:/book/detail";
	}
}
