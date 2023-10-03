package com.example.choyoujin.controller;

import com.example.choyoujin.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.Banner;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/ROLE_USER")
public class MyPageController {

    @Autowired
    private UserService userService;

    /** 나의 '같이 여행 가요' */
    @GetMapping("/mypage/together")
    public String upcomingTravelPage(Model model) {
        userService.getUserAndAddModel(model); // 사용자 정보 담기
        return "my_page/travel_together";
    }

    /** 나의 '여행에 대해 궁금해요' */
    @GetMapping("mypage/curious")
    public String interestingTravelPage(Model model) {
        userService.getUserAndAddModel(model); // 사용자 정보 담기
        return "my_page/curious_about_travel";
    }

}
