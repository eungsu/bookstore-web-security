package com.example.store.vo;

import java.util.Date;

import org.apache.ibatis.type.Alias;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
@Alias("OrderItem")
public class OrderItem {
    
    private int id;
    private Order order;
    private Book book;
    private int price;
    private int quantity;
    private Date createdDate;
    private Date updatedDate;
    
    public OrderItem() {}
    public OrderItem(Book book, int price, int quantity) {
    	this.book = book;
    	this.price = price;
    	this.quantity = quantity;
    }
	public int getTotalBookPrice() {
    	return book.getPrice()*quantity;
    }
    public int getTotalOrderPrice() {
    	return price*quantity;
    }
    public int getTotalDiscountPrice() {
    	return getTotalBookPrice() - getTotalOrderPrice();
    }

}
