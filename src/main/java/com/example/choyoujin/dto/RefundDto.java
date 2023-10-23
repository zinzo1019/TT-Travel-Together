package com.example.choyoujin.dto;

import lombok.Data;

import java.time.LocalDate;

@Data
public class RefundDto {
    private int refundId;
    private String reason;
    private String refundReason;
    private int paymentId;
    private LocalDate refundDate;
    private int paidAmount;

    private int productId;
    private String productName;
    private int cost;
    private int userId;
    private String userName;
    private String email;

    private int imageId; // 이미지 아이디
    private byte[] picByte; // 압축 이미지
    private String type; // 이미지 타입
    private String encoding; // 압축 해제한 이미지

    private ProductDto productDto;
}
