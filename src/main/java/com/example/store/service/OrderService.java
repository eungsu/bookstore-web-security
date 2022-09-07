package com.example.store.service;

import java.util.ArrayList;
import java.util.List;

import org.springframework.stereotype.Service;

import com.example.store.dto.OrderDetailDto;
import com.example.store.mapper.OrderItemMapper;
import com.example.store.mapper.OrderMapper;
import com.example.store.mapper.UserMapper;
import com.example.store.paging.Pagable;
import com.example.store.vo.Book;
import com.example.store.vo.Order;
import com.example.store.vo.OrderItem;
import com.example.store.vo.User;
import com.example.store.web.form.OrderForm;

import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
@Service
public class OrderService {
	
	private final BookService bookService;
	private final OrderItemMapper orderItemMapper;
	private final OrderMapper orderMapper;
	private final UserMapper userMapper;
	
	public long insertOrder(OrderForm orderForm, User user) {		
		Order order = this.createOrder(orderForm, user);
		orderMapper.insertOrder(order);
		
		List<OrderItem> orderItems = this.getOrderItems(order, orderForm);
		for (OrderItem orderItem : orderItems) {
			bookService.changeBookStock(orderItem.getBook().getId(), orderItem.getQuantity());
			orderItemMapper.insertOrderItem(orderItem);
		}	
		
		user.setPoint(user.getPoint() + order.getDepositPoint());
		userMapper.updateUser(user);
		
		return order.getId();
	}

	public OrderDetailDto getOrderDetail(int orderId) {
		Order order = orderMapper.getOrderById(orderId);
		List<OrderItem> orderItems = orderItemMapper.getOrderItemsByOrderId(orderId);
		
		OrderDetailDto orderDetailDto = new OrderDetailDto();
		orderDetailDto.setOrder(order);
		orderDetailDto.setOrderItems(orderItems);
		
		return orderDetailDto;
	}

    public List<Order> getMyOrders(Pagable pagable, int userId) {
		return orderMapper.getOrdersByUserId(pagable, userId);
    }

	private Order createOrder(OrderForm orderForm, User user) {
		Book book = bookService.getBookById(orderForm.getIds()[0]);

		Order order = new Order();
		order.setUser(user);
		order.setTitle(orderForm.getTitle(book));
		order.setTotalPrice(orderForm.getTotalBookPrice());
		order.setUsedPoint(orderForm.getUsedPoint());
		order.setPaymentPrice(orderForm.getTotalPaymentPrice() - orderForm.getUsedPoint());
		order.setTotalQuantity(orderForm.getTotalQuantity());
		order.setDepositPoint(orderForm.getDepositPoint());

		return order;
	}

	private List<OrderItem> getOrderItems(Order order, OrderForm orderForm) {
		List<OrderItem> orderItems = new ArrayList<OrderItem>();
		for (int index = 0; index < orderForm.getIds().length; index++) {
			int bookId = orderForm.getIds()[index];
			int quantity = orderForm.getQuantities()[index];

			Book book = bookService.getBookById(bookId);
			book.setStock(book.getStock() - quantity);

			OrderItem orderItem = new OrderItem();
			orderItem.setBook(book);
			orderItem.setOrder(order);
			orderItem.setPrice(book.getDiscountPrice());
			orderItem.setQuantity(quantity);

			orderItems.add(orderItem);
		}
		return orderItems;
	}

}
