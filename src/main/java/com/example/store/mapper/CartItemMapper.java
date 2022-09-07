package com.example.store.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.example.store.paging.Pagable;
import com.example.store.vo.CartItem;

@Mapper
public interface CartItemMapper {
    
	CartItem getCartItemByUserIdAndBookId(@Param("userId") int userId, @Param("bookId") int bookId);
	CartItem getCartItemById(int userId);
	int getCartItemTotalRows(int userId);
	List<CartItem> getCartItemsByUserId(@Param("pagable") Pagable pagable, @Param("userId") int userId);
	List<CartItem> getCartItemsByIds(@Param("cartItemIds") List<Long> cartItemIds);
	void insertCartItem(CartItem cartItem);
	void updateCartItem(CartItem savedCartItem);
	void deleteCartItemsByIds(@Param("cartItemIds") List<Long> cartItemIds, @Param("userId") int userId);
}
