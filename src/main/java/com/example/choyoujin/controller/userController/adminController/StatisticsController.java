package com.example.choyoujin.controller.userController.adminController;

import com.example.choyoujin.service.StatisticsService;
import com.example.choyoujin.service.UserService;
import com.fasterxml.jackson.core.JsonProcessingException;
import org.bouncycastle.math.raw.Mod;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/admin/statistics")
public class StatisticsController {

    @Autowired
    private StatisticsService statisticsService;
    @Autowired
    private UserService userService;

    /**
     * 결제 통계 페이지
     */
    @GetMapping("/payment")
    public String paymentPage(Model model) throws JsonProcessingException {
        model.addAttribute("user", userService.getUserData()); // 사용자 정보 담기
        model.addAttribute("paymentRefundRate", statisticsService.calculPaymentRate()); // 퍼센티지 담기
        model.addAttribute("countByProducts", statisticsService.countPaymentsByProduct()); // 여행 상품별 결제 건수 담기
        model.addAttribute("countByContries", statisticsService.countPaymentsByCountry()); // 나라별 결제 건수 담기
        return "admin/statistics/product_payment";
    }

    /**
     * 환불 통계 페이지
     */
    @GetMapping("/refund")
    public String refundPage(Model model) throws JsonProcessingException {
        model.addAttribute("user", userService.getUserData()); // 사용자 정보 담기
        model.addAttribute("paymentRefundRate", statisticsService.calculPaymentRate()); // 퍼센티지
        model.addAttribute("countByProducts", statisticsService.countRefundsByProduct()); // 여행 상품별 환불 건수 담기
        model.addAttribute("countByContries", statisticsService.countRefundsByCountry()); // 나라별 환불 건수 담기
        model.addAttribute("refundProducts", statisticsService.findAllProductsByRefund()); // 환불된 여행 상품 정보 담기
        model.addAttribute("refundReasons", statisticsService.findAllRefundReasonByRefund()); // 환불 사유 담기
        return "admin/statistics/product_refund";
    }

    /**
     * 결제 차트
     */
    @GetMapping("/paymentChart")
    @ResponseBody
    public List<Map<String, Object>> getPaymentChart() {
        return statisticsService.countPaymentByMonth();// 달별 결제 건수
    }

    /**
     * 환불 차트
     */
    @GetMapping("/refundChart")
    @ResponseBody
    public List<Map<String, Object>> getRefnudChart() {
        return statisticsService.countRefundByMonth(); // 달별 환불 건수
    }

}
