package com.example.choyoujin.dto;

import lombok.Data;

import java.time.LocalDate;

@Data
public class CommentDto {
    private int commentId;
    private String content;
    private int postId; // 게시글 아이디
    private int productId; // 여행 상품 아이디
    private int parentCommentId;
    private int userId;
    private String userName;
    private int level;
    private LocalDate createDate;
    private LocalDate updateDate;
}
