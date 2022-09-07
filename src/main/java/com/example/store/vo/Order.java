package com.example.store.vo;

import java.util.Date;

import org.apache.ibatis.type.Alias;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
@Alias("Order")
public class Order {
	
    private int id;
    private String status;
    private String title;
    private int totalPrice;
    private int usedPoint;
    private int paymentPrice;
    private int depositPoint;
    private int totalQuantity;
    private Date createdDate;
    private Date updatedDate;
    private User user;
}
