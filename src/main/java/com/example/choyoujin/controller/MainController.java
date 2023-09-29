package com.example.choyoujin.controller;

import com.example.choyoujin.dto.UserDto;
import com.example.choyoujin.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
public class MainController {

    @Autowired
    private UserService userService;

    /** 메인 페이지 */
    @GetMapping({"", "/", "ROLE_GUEST", "ROLE_USER"})
    public String redirectMainPage(Model model) {
        userService.getUserAndAddModel(model); // 사용자 정보 담기
        return "main";
    }

    /** 로그인 페이지 */
    @RequestMapping("/login")
    public String loginPage() {
        return "login";
    }

    /** 회원가입 페이지 */
    @RequestMapping("/signup")
    public String signUpPage() {
        return "sign_up";
    }

    /** ROLE_USER 회원가입 로직 */
    @RequestMapping("/ROLE_GUEST/signup-process")
    public String signUpProcess(UserDto userDto) {
        int imageId = userService.saveImageAndGetImageId(userDto); // 이미지 저장
        userService.saveUser(userDto, "ROLE_USER", 1, imageId); // 사용자 저장
        return "login";
    }

    /** 이메일 중복 확인 */
    @GetMapping("/ROLE_GUEST/email/check")
    public ResponseEntity<String> checkIdDuplication(@RequestParam(value = "email") String email) {
        if (userService.isUser(email) == true) {
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).body("이미 사용 중인 아이디입니다.");
        } else {
            return ResponseEntity.ok("사용 가능한 아이디 입니다.");
        }
    }

}
