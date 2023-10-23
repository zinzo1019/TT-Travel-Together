package com.example.choyoujin.controller.userController.adminController;

import com.example.choyoujin.service.PaymentService;
import com.example.choyoujin.service.PaymentServiceImpl;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/admin")
public class PaymentManagementController {

    @Autowired
    private PaymentServiceImpl paymentService;

    @GetMapping("/payment/view")
    public void paymentViewPage(Model model) {
        model.addAttribute("payments", paymentService.findAllPayments()); // 모든 결제건 담기
    }

    @GetMapping("/refund/view")
    public void refundViewPage(Model model) {
        model.addAttribute("payments", paymentService.findAllRefunds()); // 모든 환불건 담기
    }

}
