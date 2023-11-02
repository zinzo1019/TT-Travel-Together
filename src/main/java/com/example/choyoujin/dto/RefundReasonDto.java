package com.example.choyoujin.dto;

import lombok.Data;

@Data
public class RefundReasonDto {
    private int refundId;
    private int countReason;
    private String refundReason;
    private double refundDouble;
}
