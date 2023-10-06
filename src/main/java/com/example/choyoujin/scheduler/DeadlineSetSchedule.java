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

    /** 매일 자정에 여행 모집 글 마감 처리 */
    @Scheduled(cron = "0 0 0 * * ?") // 매일 자정 (0시 0분 0초)
    public void executeDailyTask() {
        togetherService.disableExpiredPosts(LocalDate.now());
    }
}
