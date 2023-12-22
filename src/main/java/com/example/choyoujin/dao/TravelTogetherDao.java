package com.example.choyoujin.dao;

import com.example.choyoujin.dto.PostDto;
import com.example.choyoujin.dto.SearchDto;
import org.apache.ibatis.annotations.Mapper;

import java.time.LocalDate;
import java.util.List;

@Mapper
public interface TravelTogetherDao {
    void saveTogetherPost(PostDto postDto);
    List<PostDto> findAllTogetherPostsByEnabled(boolean enabled, int userId);
    void disableExpiredPosts(LocalDate now);
    void updateEnabledByPostId(int postId, boolean enabled);
    void updateRecruitedNumber(int postId);
    void cancelRecruitedNumber(int postId);
    PostDto findOneByPostId(int postId);
    List<PostDto> findAllByCountryIdAndEnabled(SearchDto searchDto, boolean enabled);
    List<PostDto> findAllTogetherPostsByEnabledAndUserId(boolean enabled, int userId);
    void updateTogetherPostByPostDto(PostDto postDto);
    void deletetogetherPost(PostDto postDto);
    boolean findIsSupportedByPostIdAndUserId(int userId, int postId);
    int getMaxId();
}
