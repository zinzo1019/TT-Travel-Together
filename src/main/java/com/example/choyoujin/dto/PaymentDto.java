package com.example.choyoujin.dto;

import lombok.Data;

import java.time.LocalDate;

@Data
public class PaymentDto {
    private int paymentId;
    private String impUid;
    private int productId;
    private int userId;
    private String userName;
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

    private ProductDto productDto;
}
