package com.example.choyoujin.dto;

import lombok.Data;

import java.time.LocalDate;

@Data
public class RefundDto {
    private int refundId;
    private String refundReason;
    private int paymentId;
    private LocalDate refundDate;
    private int productId;
    private int paidAmount;

    private ProductDto productDto;
}
