package com.example.choyoujin.Auth;

import org.springframework.security.core.Authentication;
import org.springframework.security.web.authentication.AuthenticationSuccessHandler;
import org.springframework.stereotype.Component;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@Component
public class CustomAuthenticationSuccessHandler implements AuthenticationSuccessHandler {

    @Override
    public void onAuthenticationSuccess(HttpServletRequest request, HttpServletResponse response, Authentication authentication) throws IOException {
        String userEmail = authentication.getName(); // 사용자 이메일
        if (userEmail != null) {



        }
        response.sendRedirect("/ROLE_GUEST"); // 로그인 성공 후 리다이렉션
    }

}