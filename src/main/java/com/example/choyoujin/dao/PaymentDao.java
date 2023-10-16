package com.example.choyoujin.dao;

import com.example.choyoujin.dto.PaymentDto;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface PaymentDao {
    void savePayment(PaymentDto paymentDto);
    void cancelPaymentById(int id);
    List<PaymentDto> findAllByUserId(int userId);
}
