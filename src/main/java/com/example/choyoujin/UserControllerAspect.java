//package com.example.choyoujin;
//
//import com.example.choyoujin.dto.UserDto;
//import com.example.choyoujin.service.UserService;
//import org.aspectj.lang.annotation.Aspect;
//import org.aspectj.lang.annotation.Before;
//import org.springframework.beans.factory.annotation.Autowired;
//import org.springframework.security.core.context.SecurityContextHolder;
//import org.springframework.security.core.userdetails.UserDetails;
//import org.springframework.stereotype.Component;
//
//@Aspect
//@Component
//public class UserControllerAspect {
//
//    @Autowired
//    private UserService userService;
//
//    @Before("execution(* com.example.choyoujin.controller.*.*(..))")
//    public void getUserDataBeforeControllerMethodExecution() {
//        Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
//        if (principal instanceof UserDetails) {
//            String email = ((UserDetails) principal).getUsername();
//            UserDto userDto = userService.findUserByEmail(email);
//        }
//    }
//}