package com.example.store.dto;

import java.util.List;

import org.apache.ibatis.type.Alias;

import com.example.store.vo.Order;
import com.example.store.vo.OrderItem;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
@Alias("OrderDetailDto")
public class OrderDetailDto {
	private Order order;
	private List<OrderItem> orderItems;
	
	// 총 도서가격
	public int getTotalBookPrice() {
		int totalBookDiscountPrice = 0;
		for (OrderItem orderItem : orderItems) {
			totalBookDiscountPrice += orderItem.getTotalBookPrice();
		}
		return totalBookDiscountPrice;
	}
	
	// 총 할인가격
	public int getTotalDiscountPrice() {
		int totalDiscountPrice = 0;
		for (OrderItem orderItem : orderItems) {
			totalDiscountPrice += orderItem.getTotalDiscountPrice();
		}
		return totalDiscountPrice;
	}
	
	// 총구매가격
	public int getTotalOrderPrice() {
		return getTotalBookPrice() - getTotalDiscountPrice();
	}
}
