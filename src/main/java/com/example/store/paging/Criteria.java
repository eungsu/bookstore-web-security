package com.example.store.paging;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class Criteria {
	private String option;
	private String keyword;
	private int minPrice;
	private int maxPrice;
}
