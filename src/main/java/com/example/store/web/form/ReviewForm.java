package com.example.store.web.form;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class ReviewForm {

	private int bookId;
	private int score;
	private String content;
}
