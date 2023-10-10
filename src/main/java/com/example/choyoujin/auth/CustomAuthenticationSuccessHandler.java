package com.example.choyoujin.auth;

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
        String role = authentication.getAuthorities().toString(); // 사용자 권한
        // 로그인 권한에 따른 리다이렉션
        if (role.equals("[ROLE_USER]"))
            response.sendRedirect("/ROLE_USER");
        else if (role.equals("[ROLE_ADMIN]"))
            response.sendRedirect("/ROLE_ADMIN");
    }
}