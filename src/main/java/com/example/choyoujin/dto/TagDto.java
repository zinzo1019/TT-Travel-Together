package com.example.choyoujin.dto;

import lombok.Data;

@Data
public class TagDto {
    private int id; // travel_tags 아이디
    private String tag;
    private int productTagId; // travel_product_tag 아이디
}
