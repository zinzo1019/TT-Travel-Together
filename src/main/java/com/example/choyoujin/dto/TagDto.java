package com.example.choyoujin.dto;

import lombok.Data;

@Data
public class TagDto {
    private int tagId; // travel_tags_id
    private String tag;
    private int productTagId; // travel_product_tag_id
}
