package com.example.choyoujin.service;

import com.example.choyoujin.dao.CommentDao;
import com.example.choyoujin.dto.CommentDto;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.time.LocalDate;
import java.util.List;

@Service
public class CommentServiceImpl implements CommentService {
    @Autowired
    private CommentDao commentDao;
    @Autowired
    private UserService userService;

    public List<CommentDto> findAllCuriousCommentsByPostId(int postId) {
        return commentDao.findAllCuriousCommentsByPostId(postId);
    }

    public void saveCuriousComment(CommentDto comment) {
        comment.setCreateDate(LocalDate.now()); // 생성 날짜 Set
        comment.setUserId(userService.getUserData().getId()); // 사용자 아이디 Set
        commentDao.saveCuriousComment(comment);
    }

    public List<CommentDto> findAllTogetherCommentsByPostId(int postId) {
        return commentDao.findAllTogetherCommentsByPostId(postId);
    }

    public void saveTogetherComment(CommentDto comment) {
        comment.setCreateDate(LocalDate.now()); // 생성 날짜 Set
        comment.setUserId(userService.getUserData().getId()); // 사용자 아이디 Set
        commentDao.saveTogetherComment(comment);
    }

    @Override
    public void saveProductComment(CommentDto comment) {
        comment.setCreateDate(LocalDate.now()); // 생성 날짜 Set
        comment.setUserId(userService.getUserData().getId()); // 사용자 아이디 Set
        commentDao.saveProductComment(comment);
    }

    @Override
    public List<CommentDto> findAllProductCommentsByPostId(int postId) {
        return commentDao.findAllProductCommentsByPostId(postId);
    }

    @Override
    public void deleteCuriousCommentsByPostId(int postId) {
        commentDao.deleteCuriousCommentsByPostId(postId);
    }

    @Override
    public void deleteTogetherCommentsByPostId(int postId) {
        commentDao.deleteTogetherCommentsByPostId(postId);
    }

    @Override
    public void deleteProductCommentsByPostId(int postId) {
        commentDao.deleteProductCommentsByPostId(postId);
    }

    @Override
    public void deleteCuriousComment(int commentId) {
        commentDao.deleteCuriousComment(commentId);
    }

    @Override
    public void deleteTogetherComment(int commentId) {
        commentDao.deleteTogetherComment(commentId);
    }

    @Override
    public void deleteProductComment(int commentId) {
        commentDao.deleteProductComment(commentId);
    }
}
