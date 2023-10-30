package com.example.choyoujin.dto;

import lombok.Data;
import org.springframework.format.annotation.DateTimeFormat;

import java.time.LocalDate;

@Data
public class PostDto {
    private int postId; // 게시글 아이디
    private String title; // 제목
    private String content; // 내용
    private String country; // 나라
    private String city; // 도시
    private int userId; // 작성자 기본키
    private String email; // 작성자 이메일
    private String userName; // 작성자 이름
    private int countryId; // 나라 기본키
    private LocalDate createDate; // 생성 날짜
    private LocalDate updateDate; // 생성 날짜
    private boolean supported; // 모집글 지원 여부

    @DateTimeFormat(pattern = "yyyy-MM-dd")
    private LocalDate startDate; // 시작 날짜
    @DateTimeFormat(pattern = "yyyy-MM-dd")
    private LocalDate endDate; // 종료 날짜
    @DateTimeFormat(pattern = "yyyy-MM-dd")
    private LocalDate deadline; // 마감 날짜
    private int totalNum; // 모집 인원
    private int recruitedNumber; // 모집된 인원
    private int remainingDays; // 모집 마감까지 남은 날짜
    private boolean enabled; // 모집 완료 여부
}
