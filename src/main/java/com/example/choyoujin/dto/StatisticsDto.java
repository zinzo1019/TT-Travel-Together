package com.example.choyoujin.dto;

import lombok.Data;

@Data
public class StatisticsDto {
    private int productId;
    private int paymendId;
    private int refundId;
    private String name;
    private int count;
}
