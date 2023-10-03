package com.example.choyoujin.dto;

import lombok.Data;
import org.springframework.format.annotation.DateTimeFormat;

import java.time.LocalDate;

@Data
public class PostDto {
    private String title; // 제목
    private String content; // 내용
    private String country; // 나라

    @DateTimeFormat(pattern = "yyyy-MM-dd")
    private LocalDate startDate; // 시작 날짜
    @DateTimeFormat(pattern = "yyyy-MM-dd")
    private LocalDate endDate; // 종료 날짜
    @DateTimeFormat(pattern = "yyyy-MM-dd")
    private LocalDate deadline; // 마감 날짜
    private int recruitedNum; // 모집 인원
}
