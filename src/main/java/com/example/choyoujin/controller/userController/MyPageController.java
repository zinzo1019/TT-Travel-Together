package com.example.choyoujin.controller.userController;

import com.example.choyoujin.service.CountryService;
import com.example.choyoujin.service.CuriousService;
import com.example.choyoujin.service.TravelTogetherService;
import com.example.choyoujin.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/user")
public class MyPageController {

    @Autowired
    private UserService userService;
    @Autowired
    private CountryService countryService;
    @Autowired
    private TravelTogetherService togetherService;
    @Autowired
    private CuriousService curiousService;

    /**
     * 나의 '같이 여행 가요' - 리스트 페이지
     */
    @GetMapping("/mypage/together")
    public String MypageTravelTogetherPage(Model model) {
        model.addAttribute("user", userService.getUserData()); // 사용자 정보 담기
        model.addAttribute("postsByTrue", togetherService.findAllTogetherPostsByEnabledAndUserId(true)); // 모집 게시글 리스트 담기 (마감 전)
        model.addAttribute("postsByFalse", togetherService.findAllTogetherPostsByEnabledAndUserId(false)); // 모집 게시글 리스트 담기 (마감 후)
        return "my_page/travel_together";
    }

    /**
     * 나의 '여행에 대해 궁금해요'
     */
    @GetMapping("mypage/curious")
    public String interestingTravelPage(Model model) {
        model.addAttribute("user", userService.getUserData()); // 사용자 정보 담기
        model.addAttribute("posts", curiousService.findAllByUserId()); // 게시글 리스트 담기
        return "my_page/curious_about_travel";
    }
}
