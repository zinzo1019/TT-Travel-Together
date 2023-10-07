package com.example.choyoujin.service;

import com.example.choyoujin.dto.CommentDto;

import java.util.List;

public interface CommentService {
    List<CommentDto> findAllCuriousCommentsByPostId(int postId);
    void saveCuriousComment(CommentDto comment);
    void saveProductComment(CommentDto comment);
}
