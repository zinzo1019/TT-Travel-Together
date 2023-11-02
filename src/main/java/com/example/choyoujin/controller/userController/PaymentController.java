package com.example.choyoujin.controller.userController;

import com.example.choyoujin.dto.PaymentDto;
import com.example.choyoujin.dto.RefundDto;
import com.example.choyoujin.service.CouponService;
import com.example.choyoujin.service.PaymentService;
import com.example.choyoujin.service.PaymentServiceImpl;
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

    @Autowired
    private PaymentServiceImpl paymentService;
    @Autowired
    private CouponService couponService;

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

    /** 여행 상품 쿠폰 사용 -  동시성 처리하기 */
    @PostMapping("/product/payment/coupon")
    public ResponseEntity<String> couponCount(PaymentDto paymentDto) {
        try {
            couponService.updateCouponCount(paymentDto.getCouponId());
            return ResponseEntity.ok("");
        } catch (Exception e) {
            System.out.println(e.getMessage());
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).body("");
        }
    }

    /** 여행 상품 환불하기 */
    @PostMapping("/mytravel/upcoming/refund")
    public ResponseEntity<String> productRefund(RefundDto refundDto) {
        try {
            refundDto.setReason("구매자에 의해 환불 처리된 상품입니다.");
            paymentService.saveRefund(refundDto);
            return ResponseEntity.ok("환불되었습니다.");
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).body("환불에 실패했습니다");
        }
    }
}
