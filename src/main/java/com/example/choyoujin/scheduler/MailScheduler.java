package com.example.choyoujin.scheduler;

import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import java.time.LocalDate;

@Component
public class MailScheduler {

    /** 여행 출발 전 리마인드 메일 전송 */
    @Scheduled(cron = "0 0 0 * * *") // 매일 자정 (0시 0분 0초)
    public void executeMinuteTask() {
        try {
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
