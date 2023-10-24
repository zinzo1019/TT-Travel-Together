package com.example.choyoujin.dto;

import lombok.Data;
import lombok.NoArgsConstructor;
import org.springframework.web.multipart.MultipartFile;

import java.time.LocalDate;
import java.util.Date;

@Data
public class UserDto {
    private int id;
    private String email;
    private String name;
    private String password;
    private MultipartFile image;
    private String travelTag;
    private String role;
    private LocalDate createDate;
    private Date lastActivityDate; // 마지막으로 활동한 날짜
    private int enabled;

    private int imageId;
    private byte[] picByte;
    private String type;
    private String encoding;
}
