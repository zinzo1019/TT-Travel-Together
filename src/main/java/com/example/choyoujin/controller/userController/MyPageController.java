package com.example.choyoujin.controller.userController;

import com.example.choyoujin.dto.PostDto;
import com.example.choyoujin.dto.UserDto;
import com.example.choyoujin.service.CountryService;
import com.example.choyoujin.service.CuriousService;
import com.example.choyoujin.service.TravelTogetherService;
import com.example.choyoujin.service.UserService;
import org.bouncycastle.jcajce.provider.asymmetric.ec.KeyFactorySpi;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import java.util.List;

@Controller
@RequestMapping("/user")
public class MyPageController {

    @Autowired
    private UserService userService;
    @Autowired
    private TravelTogetherService togetherService;
    @Autowired
    private CuriousService curiousService;

    /**
     * 나의 '같이 여행 가요' - 내가 지원한 여행 모집글 리스트 페이지
     */
    @GetMapping("/mypage/together/apply")
    public String travelTogetherIAppliedForPage(Model model) {
        UserDto userDto = userService.getUserData();
        model.addAttribute("user", userService.getUserData()); // 사용자 정보 담기

        List<PostDto> postsByTrue = togetherService.findAllTogetherPostsIAppliedFor(true, userDto.getUserId()); // 마감 전
        List<PostDto> postsByFalse = togetherService.findAllTogetherPostsIAppliedFor(false, userDto.getUserId()); // 마감 후
        model.addAttribute("postsByTrue", postsByTrue); // 모집 게시글 리스트 담기 (마감 전)
        model.addAttribute("postsByFalse", postsByFalse); // 모집 게시글 리스트 담기 (마감 후)
        return "my_page/travel_together";
    }

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
    @GetMapping("/mypage/curious")
    public String interestingTravelPage(Model model) {
        model.addAttribute("user", userService.getUserData()); // 사용자 정보 담기
        model.addAttribute("posts", curiousService.findAllByUserId()); // 게시글 리스트 담기
        return "my_page/curious_about_travel";
    }

    /**
     * 회원 정보 페이지
     */
    @GetMapping("/mypage/modify/user")
    public String modifyUserPage(Model model) {
        model.addAttribute("user", userService.getUserData()); // 사용자 정보 담기
        return "my_page/user";
    }

    /**
     * 회원 정보 페이지 - 수정하기
     */
    @PostMapping("/mypage/modify/user")
    public ResponseEntity modifyUserAction(String travelTag) {
        try {
            userService.updateTravelTag(travelTag);
            return ResponseEntity.ok("사용자 정보를 수정했습니다.");
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).body("사용자 정보 수정에 실패했습니다.");
        }
    }
}
