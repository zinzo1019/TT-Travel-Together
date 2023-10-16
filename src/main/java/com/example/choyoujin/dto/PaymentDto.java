package com.example.choyoujin.dto;

import lombok.Data;

import java.time.LocalDate;

@Data
public class PaymentDto {
    private int paymentId;
    private String impUid;
    private int productId;
    private int userId;
    private String merchantUid;
    private int paidAmount;
    private int paidAt;
    private String pgProvider;
    private String pgTid;
    private String receiptUrl;
    private LocalDate createDate;
    private boolean available;

    private ProductDto productDto;
}
