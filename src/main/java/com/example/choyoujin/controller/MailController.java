package com.example.choyoujin.controller;

import com.example.choyoujin.dto.MailDto;
import com.example.choyoujin.service.MailService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

@Controller
public class MailController {

    @Autowired
    private MailService mailService;

    /**
     * 메일 전송 테스트 컨트롤러
     */
    @GetMapping("/guest/mail")
    public String mainPage(Model model) {
        return "test/test";
    }

    @PostMapping("/guest/mail/send")
    public String sendMail(MailDto mailDto) {
        mailService.sendSimpleMessage(mailDto);
        System.out.println("메일 전송 완료");
        return "AfterMail.html";
    }
}
