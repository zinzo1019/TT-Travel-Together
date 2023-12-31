package com.example.choyoujin.auth;

import org.springframework.context.annotation.Configuration;
import org.springframework.security.authentication.BadCredentialsException;
import org.springframework.security.authentication.CredentialsExpiredException;
import org.springframework.security.authentication.DisabledException;
import org.springframework.security.authentication.InternalAuthenticationServiceException;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.web.authentication.AuthenticationFailureHandler;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

/**
 * 사용자 정의 클래스 - 에러 처리
 * 사용자 인증 실패 시의 여러 가지 상황에 따른 에러 메세지를 구분해서 출력
 * 로그인 실패 횟수를 기록해서 몇 회 이상이면 일정 시간 더 이상 로그인 시도를 못하게 막는 등의 처리
 */
@Configuration
public class CustomAuthenticationFailureHandler implements AuthenticationFailureHandler {
    @Override
    public void onAuthenticationFailure(HttpServletRequest request, HttpServletResponse response, AuthenticationException exception) throws IOException, ServletException {
        String loginid = request.getParameter("email");
        String errormsg = "";
        String loginUrl = request.getHeader("referer"); // 이전 주소 받아오기

        if (exception instanceof BadCredentialsException) {
            errormsg = "아이디나 비밀번호가 맞지 않습니다. 다시 확인해주세요.";
        } else if (exception instanceof InternalAuthenticationServiceException) {
            errormsg = "아이디나 비밀번호가 맞지 않습니다. 다시 확인해주세요.";
        } else if (exception instanceof DisabledException) {
            errormsg = "계정이 비활성화되었습니다. 관리자에게 문의하세요.";
        } else if (exception instanceof CredentialsExpiredException) {
            errormsg = "비밀번호 유효기간이 만료되었습니다. 관리자에게 문의하세요.";
        }

        request.setAttribute("email", loginid);
        request.setAttribute("error_message", errormsg); // 에러 메세지 담기

        if (loginUrl.endsWith("login")) { // 사용자 로그인
            request.getRequestDispatcher("/login?error=true").forward(request, response);
        }
        if (loginUrl.endsWith("admin")) { // 관리자 로그인
            request.getRequestDispatcher("/login/admin?error=true").forward(request, response);
        }
    }
}
