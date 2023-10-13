package com.example.choyoujin.dto;

import lombok.Data;
import org.springframework.web.multipart.MultipartFile;

import java.time.LocalDate;
import java.util.List;

@Data
public class ProductDto {
    private int id; // 상품 기본키
    private String productName; // 여행 상품 이름
    private String description;
    private String descriptions; // 이어붙이 설명
    private MultipartFile image;
    private String uesrId;
    private int cost;
    private LocalDate startDate;
    private LocalDate endDate;
    private int like;
    private boolean userLiked; // 좋아요 여부
    private List<TagDto> tags; // 태그들
    private List<TagDto> detailDescriptions; // 설명들

    private List<String> stringTags; // 태그들 저장
    private List<String> stringDetailDescriptions; // 설명들 저장

    private int countryId; // 나라 기본키
    private String country; // 나라 이름
    private String city; // 도시 이름
    private int cityCount; // 나라 - 도시별 여행 상품 개수

    private int userId; // 사용자 기본키
    private String email;
    private String name;

    private int imageId; // 이미지 아이디
    private byte[] picByte; // 압축 이미지
    private String type; // 이미지 타입
    private String encoding; // 압축 해제한 이미지
}
