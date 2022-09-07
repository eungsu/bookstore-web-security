package com.example.store.vo;

import java.util.Date;

import org.apache.ibatis.type.Alias;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
@Alias("PointHistory")
public class PointHistory {

	private int id;
	private String reason;
	private int amount;
	private Date createdDate;
	private Date updatedDate;
	private User user;
	private Order order;
}
