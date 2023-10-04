package com.example.choyoujin.dto;

import lombok.Data;

import java.time.LocalDate;
import java.util.List;

@Data
public class ProductDto {
    private int id; // 상품 기본키
    private String description;
    private String image;
    private String uesrId;
    private int cost;
    private LocalDate startDate;
    private LocalDate endDate;
    private int like;
    private String descriptions; // 설명
    private List<TagDto> tags; // 태그들

    private int countryId; // 나라 기본키
    private String country; // 나라 이름
    private String city; // 도시 이름

    private int userId; // 사용자 기본키
    private String email;
    private String name;
}
