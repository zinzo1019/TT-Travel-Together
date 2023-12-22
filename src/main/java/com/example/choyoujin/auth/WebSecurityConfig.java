package com.example.choyoujin.auth;

import lombok.RequiredArgsConstructor;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.core.annotation.Order;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.config.annotation.authentication.builders.AuthenticationManagerBuilder;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.web.access.AccessDeniedHandler;
import org.springframework.security.web.authentication.AuthenticationSuccessHandler;

import javax.sql.DataSource;

@Configuration // 이 클래스를 빈으로 등록하는데 스프링 설정으로 사용
@EnableWebSecurity // 스프링 시큐리티 기능 활성화
@RequiredArgsConstructor
public class WebSecurityConfig {

    @Autowired
    public CustomAuthenticationFailureHandler authenticationFailureHandler; // 로그인 실패 시
    @Autowired
    private AccessDeniedHandler accessDeniedHandler;
    @Autowired
    private CustomAuthenticationSuccessHandler authenticationSuccessHandler; // 로그인 성공 시

    @Order(1)
    @Configuration
    class AdminConfig extends WebSecurityConfigurerAdapter {
        @Override
        protected void configure(HttpSecurity http) throws Exception {
            http.authorizeRequests()
                    .antMatchers("/signup/**", "/login/**", "/guest/**").permitAll()
                    .antMatchers("/images/**").permitAll()
                    .antMatchers("/user/**").hasAnyRole("USER") // user 게시판 -> 사용자만 접근 허용
                    .anyRequest().authenticated()
                    .and()
                    .exceptionHandling()
                    .accessDeniedHandler(accessDeniedHandler);

            http.formLogin()
                    .loginPage("/login") // 사용자 로그인 페이지
                    .successHandler(authenticationSuccessHandler)
                    .failureHandler(authenticationFailureHandler)
                    .usernameParameter("email") // "login.jsp"에서 지정한 변수명으로 파라미터명 설정
                    .passwordParameter("password")
                    .permitAll(); // 로그인 폼 url 모두 허용

            http.logout()
                    .logoutUrl("/logout")
                    .logoutSuccessUrl("/")
                    .permitAll(); // 로그아웃 폼 url 모두 허용
            http.csrf().disable();
        }

        // 스프링 시큐리티 암호화
        @Bean
        public BCryptPasswordEncoder passwordEncoder() {
            return new BCryptPasswordEncoder();
        }

        @Bean
        @Override
        public AuthenticationManager authenticationManagerBean() throws Exception {
            return super.authenticationManagerBean();
        }
    }
}
