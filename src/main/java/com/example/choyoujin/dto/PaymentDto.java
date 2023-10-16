package com.example.choyoujin.dto;

import lombok.Data;

@Data
public class PaymentDto {
    private String impUid;
    private int productId;
    private int userId;
    private String merchantUid;
    private int paidAmount;
    private int paidAt;
    private String pgProvider;
    private String pgTid;
    private String receiptUrl;
}
