package com.example.choyoujin.auth;

import org.springframework.security.core.Authentication;
import org.springframework.security.web.authentication.AuthenticationSuccessHandler;
import org.springframework.stereotype.Component;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@Component
public class CustomAuthenticationSuccessHandler implements AuthenticationSuccessHandler {
    @Override
    public void onAuthenticationSuccess(HttpServletRequest request, HttpServletResponse response, Authentication authentication) throws IOException, ServletException {
        String role = authentication.getAuthorities().toString(); // 사용자 권한
        String loginUrl = request.getHeader("referer"); // 이전 주소 받아오기

        if (loginUrl.endsWith("login")) { // 사용자 로그인
            if(role.equals("[ROLE_ADMIN]")) { // 관리자가 로그인 시도하면 에러 처리
                request.setAttribute("error_message", "사용자 페이지에 접근 권한이 없습니다.");
                request.getRequestDispatcher("/login?error=true").forward(request, response);
            }
            response.sendRedirect("/user");
        }
        if (loginUrl.endsWith("admin")) { // 관리자 로그인
            if(role.equals("[ROLE_USER]")){ // 사용자가 로그인 시도하면 에러 처리
                request.setAttribute("error_message", "관리자 페이지에 접근 권한이 없습니다.");
                request.getRequestDispatcher("/login?error=true").forward(request, response);
            }
            response.sendRedirect("/admin");
        }
    }
}