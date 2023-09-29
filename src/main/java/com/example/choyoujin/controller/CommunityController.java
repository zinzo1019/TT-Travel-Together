package com.example.choyoujin.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/ROLE_USER")
public class CommunityController {

    /** 같이 여행 가요 */
    @GetMapping("/community/curious")
    public String curiousAboutTravelPage() {
        return "community/curious_about_travel";
    }

    /** 여행에 대해 궁금해요 */
    @GetMapping("/community/together")
    public String travelTogetherPage() {
        return "community/travel_together";
    }

    /** 여행에 대해 궁금해요 */
    @GetMapping("/my_travel/upcoming_travel")
    public String upcomingTravelPage() {
        return "my_travel/upcoming_travel";
    }

    /** 여행에 대해 궁금해요 */
    @GetMapping("/my_travel/interesting_travel")
    public String interestingTravelPage() {
        return "my_travel/interesting_travel";
    }

}
