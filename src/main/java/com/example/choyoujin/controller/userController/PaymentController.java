package com.example.choyoujin.controller.userController;

import com.example.choyoujin.dto.PaymentDto;
import com.example.choyoujin.service.PaymentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/user")
public class PaymentController {

    @Value("${cid}")
    private String cid;

    @Autowired
    private PaymentService paymentService;

    /** 여행 상품 결제하기 */
    @PostMapping("/product/payment")
    public ResponseEntity<String> productPayment(PaymentDto paymentDto) {
        try {
            paymentService.savePayment(paymentDto);
            return ResponseEntity.ok("결제가 완료됐습니다.");
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).body("결제에 실패했습니다");
        }
    }

    /** 여행 상품 환불하기 */
    @PostMapping("/mytravel/refund")
    public ResponseEntity<String> productRefund(int paymentId) {
        try {
            System.out.println("payment id is " + paymentId);
            return ResponseEntity.ok("결제가 완료됐습니다.");
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).body("결제에 실패했습니다");
        }
    }
}
