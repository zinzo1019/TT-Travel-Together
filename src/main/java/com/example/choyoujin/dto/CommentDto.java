package com.example.choyoujin.dto;

import lombok.Data;

import java.time.LocalDate;

@Data
public class CommentDto {
    private int id;
    private String content;
    private int postId;
    private int parentCommentId;
    private int userId;
    private String userName;
    private int level;
    private LocalDate createDate;
    private LocalDate updateDate;
}
