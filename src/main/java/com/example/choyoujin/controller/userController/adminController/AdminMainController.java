package com.example.choyoujin.controller.userController.adminController;

import com.example.choyoujin.dto.*;
import com.example.choyoujin.service.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.List;

@Controller
public class AdminMainController {

    @Autowired
    private UserService userService;
    @Autowired
    private TravelProductServiceImpl travelProductService;
    @Autowired
    private CountryService countryService;

    /**
     * 나라별 상품 리스트 페이지
     */
    @GetMapping("/admin/country")
    public String countryProductsListPage(@RequestParam("country_id") int countryId, Model model) {
        model.addAttribute("user", userService.getUserData()); // 사용자 정보 담기
        model.addAttribute("country", countryService.findCountryByCountryId(countryId)); // 나라 정보 담기
        model.addAttribute("products", travelProductService.findAllProductsByCountryId(countryId)); // 여행 상품 리스트 담기
        return "main/country_products_list";
    }

    /**
     * 나라별 상품 리스트 페이지 - 검색
     */
    @PostMapping("/admin/country/search")
    public String SearchCountryProductsListPage(@RequestParam("country_id") int countryId, String keyword, Model model) {
        model.addAttribute("user", userService.getUserData()); // 사용자 정보 담기
        model.addAttribute("country", countryService.findCountryByCountryId(countryId)); // 나라 정보 담기
        model.addAttribute("products", travelProductService.findAllProductsByCountryIdAndKeyword(countryId, keyword)); // 여행 상품 리스트 담기
        return "main/products_search_result";
    }

    /**
     * 회원가입 페이지
     */
    @RequestMapping("/signup/admin")
    public String signUpPage() {
        return "admin/base_view/sign_up";
    }

    /**
     * ROLE_ADMIN 회원가입 동작
     */
    @PostMapping("/guest/admin/signup-process")
    public ResponseEntity<String> signUpProcess(UserDto userDto) {
        try {
            userService.saveUser(userDto, "ROLE_ADMIN"); // 사용자 저장
            return ResponseEntity.ok("회원가입을 성공했습니다.");
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).body("회원가입을 실패했습니다.");
        }
    }

    /**
     * 관리자 로그인 페이지
     */
    @RequestMapping("/login/admin")
    public String loginPage() {
        return "admin/base_view/login";
    }
}
