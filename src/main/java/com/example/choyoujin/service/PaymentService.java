package com.example.choyoujin.service;

import com.example.choyoujin.dao.PaymentDao;
import com.example.choyoujin.dto.PaymentDto;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class PaymentService {

    @Autowired
    private PaymentDao paymentDao;

    /** 여행 상품 결제건 저장하기 */
    public void savePayment(PaymentDto paymentDto) {
        paymentDao.savePayment(paymentDto);
    }

    /** 여행 상품 결제 취소하기 */
    public void cancelPaymentById(int id) {
        paymentDao.cancelPaymentById(id);
    }
}
