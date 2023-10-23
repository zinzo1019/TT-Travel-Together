package com.example.choyoujin.controller.userController.adminController;

import com.example.choyoujin.dto.RefundDto;
import com.example.choyoujin.service.PaymentServiceImpl;
import com.example.choyoujin.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/admin")
public class PaymentManagementController {

    @Autowired
    private PaymentServiceImpl paymentService;
    @Autowired
    private UserService userService;

    /** 관리자 - 결제 관리 페이지 */
    @GetMapping("/payment/view")
    public String paymentViewPage(Model model) {
        model.addAttribute("user", userService.getUserData()); // 사용자 정보 담기
        model.addAttribute("payments", paymentService.findAllPayments()); // 모든 결제건 담기
        return "admin/payments/paymentsManagement";
    }

    /** 관리자 - 환불 처리하기 */
    @PostMapping("/refund/processing")
    public ResponseEntity<String> refundProcessing(RefundDto refundDto) {
        try {
            refundDto.setReason("관리자에 의해 환불 처리된 상품입니다.");
            paymentService.saveRefund(refundDto);
            return ResponseEntity.ok("환불 처리했습니다.");
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).body("환불 처리 실패했습니다.");
        }
    }

    /** 관리자 - 환불 관리 페이지 */
    @GetMapping("/refund/view")
    public String refundViewPage(Model model) {
        model.addAttribute("user", userService.getUserData()); // 사용자 정보 담기
        model.addAttribute("refunds", paymentService.findAllRefunds()); // 모든 환불건 담기
        return "admin/payments/refundsManagement";
    }

    /** 관리자 - 사용 완료 처리하기 */
    @PostMapping("/used/processing")
    public ResponseEntity<String> usedProcessing(int paymentId) {
        try {
            paymentService.updatePaymentAvailable(paymentId, false);
            return ResponseEntity.ok("사용 완료 처리했습니다.");
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).body("사용 완료 처리에 실패했습니다.");
        }
    }
}
