package com.example.choyoujin.dao;

import com.example.choyoujin.dto.PostDto;
import com.example.choyoujin.dto.SearchDto;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface CuriousDao {
    void saveCuriousPost(PostDto postDto);
    List<PostDto> findAllPosts();
    PostDto findOneByPostId(int postId);
    List<PostDto> findAllByCountryId(int searchDto);
    List<PostDto> findAllByUserId(int userId);
    void updateCuriousPostByPostDto(PostDto postDto);
    void deleteCuriousPost(PostDto postDto);
    List<PostDto> findAllByKeyword(String keyword);
    List<PostDto> findAllByCountryIdAndKeyword(SearchDto searchDto);
}
