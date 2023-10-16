package com.example.choyoujin.dao;

import com.example.choyoujin.dto.PaymentDto;
import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface PaymentDao {
    void savePayment(PaymentDto paymentDto);
    void cancelPaymentById(int id);
}
