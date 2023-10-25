package com.example.choyoujin.dto;

import lombok.Data;

import java.time.LocalDate;

@Data
public class PaymentDto {
    private int paymentId;
    private String impUid;
    private String merchantUid;
    private int paidAmount;
    private int paidAt;
    private String pgProvider;
    private String pgTid;
    private String receiptUrl;
    private LocalDate createDate;
    private boolean available;
    private String reason; // 사용 불가 이유
    private String refundReason; // 환불 사유
    private String adminEmail; // 관리자 이메일
    private int couponId; // 쿠폰 아이디

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
