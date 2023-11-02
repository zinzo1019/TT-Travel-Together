package com.example.choyoujin.scheduler;

import com.example.choyoujin.service.TravelTogetherService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import java.time.LocalDate;

@Component
public class DeadlineSetSchedule {

    @Autowired
    private TravelTogetherService togetherService;


    /** 매분마다 여행 모집 글 마감 처리 */
    // cron은 일정한 주기로 작업을 실행하기 위한 스케줄링 정의
    // 0 0 0: 시분초 (0시0분0초)
    // * * *: 일 월 요일 -> 모든 일월요일 의미
    @Scheduled(cron = "0 0 0 * * *") // 매일 자정 (0시 0분 0초)
    public void executeMinuteTask() {
        togetherService.disableExpiredPosts(LocalDate.now());
    }
}