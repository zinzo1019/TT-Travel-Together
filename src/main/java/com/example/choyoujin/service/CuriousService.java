package com.example.choyoujin.service;

import com.example.choyoujin.dao.CuriousDao;
import com.example.choyoujin.dto.PostDto;
import com.example.choyoujin.dto.SearchDto;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.time.LocalDate;
import java.util.List;

@Service
public class CuriousService {

    @Autowired
    private CuriousDao curiousDao;
    @Autowired
    private UserService userService;

    /** 게시글 작성하기 */
    public void saveCuriousPost(PostDto postDto) {
        postDto.setUserId(userService.getUserData().getId()); // 사용자 아이디 Set
        postDto.setCreateDate(LocalDate.now());
        curiousDao.saveCuriousPost(postDto); // 게시글 저장
    }

    public List<PostDto> findAllPosts() {
        return curiousDao.findAllPosts();
    }

    public PostDto findOneByPostId(int postId) {
        return curiousDao.findOneByPostId(postId);
    }

    /** 게시글 검색하기 (나라와 검색어) */
    public List<PostDto> findAllByCountryId(SearchDto searchDto) {
        return curiousDao.findAllByCountryId(searchDto);
    }
}
