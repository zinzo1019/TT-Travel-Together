package com.example.choyoujin.controller.userController.adminController;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import javax.servlet.http.HttpServletRequest;

@Controller
public class LoginController {

    @Autowired
    private AuthenticationManager authenticationManager;

    @PostMapping("/login/admin/action")
    public String customLogin(@RequestParam("email") String email, @RequestParam("password") String password, HttpServletRequest request) {
        UsernamePasswordAuthenticationToken token = new UsernamePasswordAuthenticationToken(email, password); // 토큰 생성
        try {
            Authentication authentication = authenticationManager.authenticate(token); // 사용자 인증 -> 로그인 시도
            SecurityContextHolder.getContext().setAuthentication(authentication); // 로그인 성공 시 보안 컨텍스트 설정
            return "redirect:/admin";
        } catch (AuthenticationException e) {
            System.out.println(e.getMessage());
            return "redirect:/login/admin";
        }
    }
}
