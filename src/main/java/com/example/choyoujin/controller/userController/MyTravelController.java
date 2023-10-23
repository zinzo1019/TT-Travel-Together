package com.example.choyoujin.controller.userController;

import com.example.choyoujin.service.PaymentServiceImpl;
import com.example.choyoujin.service.TravelProductServiceImpl;
import com.example.choyoujin.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/user")
public class MyTravelController {

    @Autowired
    private UserService userService;
    @Autowired
    private TravelProductServiceImpl productService;
    @Autowired
    private PaymentServiceImpl paymentService;

    /** 곧 여기로 떠나요 */
    @GetMapping("/mytravel/upcoming")
    public String upcomingTravelPage(Model model) {
        model.addAttribute("user", userService.getUserData()); // 사용자 정보 담기
        model.addAttribute("products", paymentService.findAllByUserId());
        model.addAttribute("available", 1);
        return "my_travel/upcoming_travel";
    }

    /** 곧 여기로 떠나요 - 이용 가능한 상품 */
    @GetMapping("/mytravel/upcoming/payment")
    public String paymentTravelPage(Model model) {
        model.addAttribute("user", userService.getUserData()); // 사용자 정보 담기
        model.addAttribute("products", paymentService.findAllByUserIdAndAvailable(true));
        model.addAttribute("available", 2);
        return "my_travel/upcoming_travel";
    }

    /** 곧 여기로 떠나요 - 이용 불가능한 상품 */
    @GetMapping("/mytravel/upcoming/refund")
    public String refundTravelPage(Model model) {
        model.addAttribute("user", userService.getUserData()); // 사용자 정보 담기
        model.addAttribute("products", paymentService.findAllByUserIdAndAvailable(false));
        model.addAttribute("available", 3);
        return "my_travel/upcoming_travel";
    }

    /** 이 여행지에 관심 있어요 */
    @GetMapping("mytravel/interesting")
    public String interestingTravelPage(Model model) {
        model.addAttribute("user", userService.getUserData()); // 사용자 정보 담기
        model.addAttribute("products", productService.findAllByUserLike()); // 여행 상품 정보 담기
        return "my_travel/interesting_travel";
    }

}
