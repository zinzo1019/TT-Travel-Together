package com.example.choyoujin.dto;

import lombok.Data;

@Data
public class CountryDto {
    private int countryId; // 나라 기본키
    private String country; // 나라 이름
    private String city; // 도시 이름
    private int totalLikes; // 나라별 총 좋아요 수
    private String image; // 나라 이미지
}