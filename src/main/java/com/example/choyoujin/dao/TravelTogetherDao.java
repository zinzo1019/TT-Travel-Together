package com.example.choyoujin.dao;

import com.example.choyoujin.dto.PostDto;
import com.example.choyoujin.dto.SearchDto;
import org.apache.ibatis.annotations.Mapper;

import java.time.LocalDate;
import java.util.List;

@Mapper
public interface TravelTogetherDao {
    void saveTogetherPost(PostDto postDto);
    List<PostDto> findAllTogetherPostsByEnabled(boolean enabled);
    void disableExpiredPosts(LocalDate now);
    void updateEnabledByPostId(int postId, boolean enabled);
    void updateRecruitedNumber(int postId);
    PostDto findOneByPostId(int postId);
    List<PostDto> findAllByCountryIdAndEnabled(SearchDto searchDto, boolean enabled);
}