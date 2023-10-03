package com.example.choyoujin.controller;

import com.example.choyoujin.dto.PostDto;
import com.example.choyoujin.service.CountryService;
import com.example.choyoujin.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

@Controller
@RequestMapping("/ROLE_USER")
public class CommunityController {

    @Autowired
    private CountryService countryService;
    @Autowired
    private UserService userService;

    /** 여행에 대해 궁금해요 */
    @GetMapping("/community/curious")
    public String curiousAboutTravelPage(Model model) {
        userService.getUserAndAddModel(model); // 사용자 정보 담기
        countryService.getCountriesAndAddModel(model); // 나라 데이터 담기
        return "community/curious_about_travel";
    }

    /** 여행에 대해 궁금해요 - 작성하기 페이지 */
    @GetMapping("/community/curious/post")
    public String curiousAboutTravelPost(Model model) {
        userService.getUserAndAddModel(model); // 사용자 정보 담기
        countryService.getCountriesAndAddModel(model); // 나라 데이터 담기
        return "community/curious_about_travel_post";
    }

    /** 여행에 대해 궁금해요 - 작성하기 동작 */
    @PostMapping("/community/curious/post")
    public void curiousAboutTravelPostAction(PostDto postDto) {
        // TODO: 게시글 저장
        System.out.println(postDto.toString());
        System.out.println("여행에 대해 궁금해요! 게시글 작성 동작 함수 실행");
    }

    /** 같이 여행 가요 */
    @GetMapping("/community/together")
    public String travelTogetherPage(Model model) {
        userService.getUserAndAddModel(model); // 사용자 정보 담기
        countryService.getCountriesAndAddModel(model); // 나라 데이터 담기
        return "community/travel_together";
    }

    /** 같이 여행 가요 - 작성하기 페이지 */
    @GetMapping("/community/together/post")
    public String travelTogetherPost(Model model) {
        userService.getUserAndAddModel(model); // 사용자 정보 담기
        countryService.getCountriesAndAddModel(model); // 나라 데이터 담기
        return "community/travel_together_post";
    }

    /** 같이 여행 가요 - 작성하기 동작 */
    @PostMapping("/community/together/post")
    public void travelTogetherPostAction(PostDto postDto) {
        // TODO: 게시글 저장
        System.out.println(postDto.toString());
        System.out.println("같이 여행 가요! 게시글 작성 동작 함수 실행");
    }
}
