package com.example.choyoujin.dto;

import lombok.Data;
import lombok.NoArgsConstructor;
import org.springframework.web.multipart.MultipartFile;

import java.util.List;

@Data
@NoArgsConstructor
public class MailDto {
    private String address;
    private String title;
    private String content;
    private List<MultipartFile> file;
}