package com.example.choyoujin.controller.userController;

import com.example.choyoujin.dto.ProductDto;
import com.example.choyoujin.service.TravelProductServiceImpl;
import com.example.choyoujin.service.TravelTogetherService;
import com.example.choyoujin.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import java.util.List;

@Controller
@RequestMapping("/ROLE_USER")
public class MyTravelController {

    @Autowired
    private UserService userService;
    @Autowired
    private TravelProductServiceImpl productService;

    /** 곧 여기로 떠나요 */
    @GetMapping("/mytravel/upcoming")
    public String upcomingTravelPage(Model model) {
        model.addAttribute("user", userService.getUserData()); // 사용자 정보 담기
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
