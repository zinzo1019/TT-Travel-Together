package com.example.choyoujin.service;

import com.example.choyoujin.dto.CommentDto;

import java.util.List;

public interface CommentService {
    List<CommentDto> findAllCuriousCommentsByPostId(int postId);
    void saveCuriousComment(CommentDto comment);
    void saveProductComment(CommentDto comment);
    List<CommentDto> findAllProductCommentsByPostId(int postId);
    void deleteCuriousCommentsByPostId(int postId);
    void deleteTogetherCommentsByPostId(int postId);
    void deleteProductCommentsByPostId(int postId);
    void deleteCuriousComment(int commentId);
    void deleteTogetherComment(int commentId);
    void deleteProductComment(int commentId);
}
