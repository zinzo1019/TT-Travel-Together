package com.example.choyoujin.dto;

import lombok.Data;
import org.springframework.format.annotation.DateTimeFormat;

import java.time.LocalDate;

@Data
public class SearchDto {
    private int countryId;
    @DateTimeFormat(pattern = "yyyy-MM-dd") // jsp -> 날짜 데이터 파싱
    private LocalDate startDate;
    @DateTimeFormat(pattern = "yyyy-MM-dd")
    private LocalDate endDate;
    private String keyword;
}
