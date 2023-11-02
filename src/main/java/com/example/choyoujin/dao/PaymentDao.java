package com.example.choyoujin.dao;

import com.example.choyoujin.dto.PaymentDto;
import com.example.choyoujin.dto.RefundDto;
import com.example.choyoujin.dto.RefundReasonDto;
import com.example.choyoujin.dto.StatisticsDto;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface PaymentDao {
    void savePayment(PaymentDto paymentDto);
    void cancelPaymentById(int id);
    List<PaymentDto> findAllByUserIdAndAvailable(int userId, boolean available);
    void updateEnabledByProductId(int productId, boolean enabled);
    PaymentDto findOneByPaymentId(int paymentId);
    void saveRefund(RefundDto refundDto);
    void updateNotAvailableByProductId(int paymentId, boolean enabled, String reason);
    List<PaymentDto> findAllByUserId(int userId);
    int countPaymentBy6Month();
    int countRefundBy6Month();
    List<StatisticsDto> countPaymentsByProduct();
    List<StatisticsDto> countRefundsByProduct();
    List<StatisticsDto> countRefundsByCountry();
    List<StatisticsDto> countPaymentsByCountry();
    List<RefundDto> findAllProductsByRefund();
    List<RefundReasonDto> countRefundByRefundReason();
    int countAllRefunds();
    List<PaymentDto> findAllPayments();
    List<RefundDto> findAllRefunds();
    void updatePaymentAvailable(int paymentId, boolean available);
}
