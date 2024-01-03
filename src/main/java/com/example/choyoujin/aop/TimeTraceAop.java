package com.example.choyoujin.aop;

import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.annotation.Around;
import org.aspectj.lang.annotation.Aspect;
import org.springframework.stereotype.Component;

@Aspect // aop
@Component
public class TimeTraceAop {

    @Around("execution(* com.example.choyoujin.service..*(..))")
    public Object execute(ProceedingJoinPoint joinPoint) throws Throwable {
        long start = System.currentTimeMillis();
        System.out.println("START: " + joinPoint.toString());
        try {
            return joinPoint.proceed();
        } finally {
            Long finish = System.currentTimeMillis();
            Long timeMs = finish - start;

            System.out.println("END: " + timeMs + "ms");
        }
    }
}