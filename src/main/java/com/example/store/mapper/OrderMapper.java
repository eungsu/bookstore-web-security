package com.example.store.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.example.store.paging.Pagable;
import com.example.store.vo.Order;

@Mapper
public interface OrderMapper {

	void insertOrder(Order order);
	void updateOrder(Order order);
	int getOrderTotalRows(int userId);
	List<Order> getOrdersByUserId(@Param("pagable") Pagable pagable, @Param("userId") int userId);
	Order getOrderById(int orderId);
	
}
