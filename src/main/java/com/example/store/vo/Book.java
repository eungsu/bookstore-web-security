package com.example.store.vo;

import java.util.Date;

import org.apache.ibatis.type.Alias;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
@Alias("Book")
public class Book {

    private int id;
    private String title;
    private String author;
    private String publisher;
    private String description;
    private int price;
    private int discountPrice;
    private int stock;
    private String onSell;
    private int reviewCount;
    private double reviewScore;
    private Date createdDate;
    private Date updatedDate;
}
