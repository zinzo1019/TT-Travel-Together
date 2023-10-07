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
}
