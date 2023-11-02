package com.example.choyoujin.dto;

import lombok.Data;

import java.util.List;

@Data
public class RefundReasonPercentageDto {
    private List<String> refundReasons;
    private List<Double> refundPercentages;
}
