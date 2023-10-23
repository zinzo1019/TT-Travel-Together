package com.example.choyoujin.service;

import com.example.choyoujin.dto.PaymentDto;
import com.example.choyoujin.dto.RefundDto;

import java.time.LocalDate;
import java.util.List;

public interface PaymentService {
    void savePayment(PaymentDto paymentDto);
    void cancelPaymentById(int id);
    List<PaymentDto> findAllByUserIdAndAvailable(boolean available);
    void updateEnabledByProductId(int productId, boolean enabled);
    void updateEnabledByProductId(int productId, boolean enabled, String notAvailableReason);
    void saveRefund(RefundDto refundDto);
    void refundPayment(RefundDto refundDto);
    String getAccessToken();
    List<PaymentDto> findAllByUserId();
    List<PaymentDto> findAllPayments();
    List<RefundDto> findAllRefunds();
}
