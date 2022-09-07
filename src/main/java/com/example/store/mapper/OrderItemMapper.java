package com.example.store.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.example.store.vo.OrderItem;

@Mapper
public interface OrderItemMapper {

	void insertOrderItem(OrderItem orderItem);
    List<OrderItem> getOrderItemsByOrderId(int orderId);
    
}
