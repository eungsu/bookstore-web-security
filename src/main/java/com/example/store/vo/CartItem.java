package com.example.store.vo;

import java.util.Date;

import org.apache.ibatis.type.Alias;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
@Alias("CartItem")
public class CartItem {
	
    private int id;
    private int quantity;
    private Date createdDate;
    private Date updatedDate;
    private User user;
    private Book book;

    public int getItemPrice() {
    	return book.getPrice()*quantity;
    }
    public int getItemSellPrice() {
    	return book.getDiscountPrice()*quantity;
    }
    public int getItemDiscountPrice() {
    	return getItemPrice() - getItemSellPrice();
    }
}
