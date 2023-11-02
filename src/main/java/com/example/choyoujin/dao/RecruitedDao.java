package com.example.choyoujin.dao;

import com.example.choyoujin.dto.RecruitedDto;
import com.example.choyoujin.dto.UserDto;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface RecruitedDao {
    void saveRecruitedMember(int userId, int postId);
    RecruitedDto findOneByPostIdAndUserId(int userId, int postId);
    void deleteRecruitedMember(int userId, int postId);
    void deleteAllByPostId(int postId);
    List<UserDto> findRecruitedMember(int postId);
}
