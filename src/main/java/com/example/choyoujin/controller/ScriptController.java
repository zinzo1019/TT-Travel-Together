package com.example.choyoujin.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/guest")
public class ScriptController {

    @GetMapping("/script01")
    public String script01() {
        return "test/script01";
    }
}
