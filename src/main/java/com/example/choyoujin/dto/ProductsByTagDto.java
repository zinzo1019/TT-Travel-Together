package com.example.choyoujin.dto;

import lombok.Data;

import java.util.List;

@Data
public class ProductsByTagDto {
    private int tagId; // 태그 아이디
    private String tag; // 태그 이름
    private List<ProductDto> productDtos; // 태그별 여행 상품 리스트
    private Pagination pagination;

    public ProductsByTagDto(int id, String tag, List<ProductDto> productDtos, Pagination pagination) {
        this.tagId = id;
        this.tag = tag;
        this.productDtos = productDtos;
        this.pagination = pagination;
    }
}
