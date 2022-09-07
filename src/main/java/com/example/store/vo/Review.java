package com.example.store.vo;

import java.util.Date;

import org.apache.ibatis.type.Alias;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
@Alias("Review")
public class Review {

	private int id;
	private String content;
	private int score;
	private Date createdDate;
	private Date updatedDate;
	private User user;
	private Book book;
}
