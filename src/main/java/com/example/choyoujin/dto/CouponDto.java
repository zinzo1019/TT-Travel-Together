package com.example.choyoujin.dto;

import lombok.Data;

import java.time.LocalDate;
import java.util.List;

@Data
public class CouponDto {
    private int couponId; // 쿠폰 아이디
    private List<Integer> productIds; // 쿠폰 등록 - 여행 상품 아이디 리스트
    private int amount; // 가격
    private int percentage; // 할인
    private String name; // 쿠폰 이름
    private String description; // 쿠폰 설명
    private LocalDate validFrom; // 유효 기간 시작
    private LocalDate validTo; // 유효 기간 만료
    private int userId; // 쿠폰 생성자 아이디
    private String code; // 쿠폰 코드
    private int countryId; // 나라 아이디
    private String productName; // 여행 상품 이름
    private String country; // 나라
    private String city; // 도시
    private int couponCount; // 쿠폰 개수
}
