package com.example.store.web.controller;

import java.util.List;

import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.example.store.dto.OrderDetailDto;
import com.example.store.service.BookService;
import com.example.store.service.OrderService;
import com.example.store.vo.Book;
import com.example.store.vo.OrderItem;
import com.example.store.vo.User;
import com.example.store.web.form.OrderForm;

import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
@Controller
@RequestMapping("/order")
public class OrderController {

	private final BookService bookService;
	private final OrderService orderService;
	
	@GetMapping("/form")
	public String orderform(@RequestParam("id") int bookId, @RequestParam("quantity") int quantity, Model model) {
		
		Book book = bookService.getBookById(bookId);
		int totalBookPrice = book.getPrice()*quantity;
		int totalPaymentPrice = book.getDiscountPrice()*quantity;
		
		model.addAttribute("totalBookPrice", totalBookPrice);
		model.addAttribute("totalDiscountPrice", totalBookPrice - totalPaymentPrice);
		model.addAttribute("totalOrderPrice", totalPaymentPrice);
		model.addAttribute("totalPaymentPrice", totalPaymentPrice);
		
		OrderItem orderItem = new OrderItem(book, book.getDiscountPrice(), quantity);
		model.addAttribute("orderItems", List.of(orderItem));		
		
		return "/order/form";
	}
	
	@PostMapping("/insert")
	public String insert(Authentication authentication, OrderForm orderForm) {
		User loginUser = (User) authentication.getPrincipal();
		
		long orderId = orderService.insertOrder(orderForm, loginUser);
		
		return "redirect:/order/completed?id=" + orderId;
	}
	
	@GetMapping("/completed")
	public String completed(@RequestParam("id") int orderId, Model model) {
		OrderDetailDto orderDetailDto = orderService.getOrderDetail(orderId);
		model.addAttribute("order", orderDetailDto.getOrder());
		model.addAttribute("orderItems", orderDetailDto.getOrderItems());
		
		return "order/completed";
	}
	
}
