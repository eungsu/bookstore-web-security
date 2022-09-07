package com.example.store.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.example.store.mapper.BookMapper;
import com.example.store.mapper.CartItemMapper;
import com.example.store.paging.Pagable;
import com.example.store.vo.Book;
import com.example.store.vo.CartItem;
import com.example.store.vo.User;

import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
@Service
public class CartItemService {

	private final BookMapper bookMapper;
	private final CartItemMapper cartItemMapper;
	
	public void insertCartItem(int bookId, int quantity, User loginUser) {
		CartItem savedCartItem = cartItemMapper.getCartItemByUserIdAndBookId(loginUser.getId(), bookId);
		
		if (savedCartItem == null) {
			Book book = bookMapper.getBookById(bookId);
			
			CartItem cartItem = new CartItem();
			cartItem.setUser(loginUser);
			cartItem.setBook(book);
			cartItem.setQuantity(quantity);
			
			cartItemMapper.insertCartItem(cartItem);
			
		} else {
			savedCartItem.setQuantity(savedCartItem.getQuantity() + quantity);
			
			cartItemMapper.updateCartItem(savedCartItem);
		}
	}

	public List<CartItem> getMyCartItems(Pagable pagable, int userId) {
		return cartItemMapper.getCartItemsByUserId(pagable, userId);
	}
	
	public List<CartItem> getCartItems(List<Long> cartItemIds) {
		return cartItemMapper.getCartItemsByIds(cartItemIds);
	}

	public void updateCartItem(int cartItemId, int quantity, int userId) {
		CartItem cartItem = cartItemMapper.getCartItemById(cartItemId);
		if (cartItem.getUser().getId() == userId) {
			cartItem.setQuantity(quantity);
			cartItemMapper.updateCartItem(cartItem);
		}		
	}

	public void deleteCartItem(List<Long> cartItemIds, int userId) {
		cartItemMapper.deleteCartItemsByIds(cartItemIds, userId);
	}
	
}
