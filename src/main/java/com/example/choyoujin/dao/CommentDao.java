package com.example.choyoujin.dao;

import com.example.choyoujin.dto.CommentDto;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface CommentDao {
    List<CommentDto> findAllCuriousCommentsByPostId(int postId);
    void saveCuriousComment(CommentDto comment);
    List<CommentDto> findAllTogetherCommentsByPostId(int postId);
    void saveTogetherComment(CommentDto comment);
}
