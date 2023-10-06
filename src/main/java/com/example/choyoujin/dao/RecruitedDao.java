package com.example.choyoujin.dao;

import com.example.choyoujin.dto.RecruitedDto;
import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface RecruitedDao {
    void saveRecruitedMember(int userId, int postId);
    RecruitedDto findOneByPostIdAndUserId(int userId, int postId);
}
