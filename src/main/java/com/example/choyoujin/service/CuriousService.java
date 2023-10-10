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
    @Autowired
    private CommentServiceImpl commentService;

    /**
     * 게시글 작성하기
     */
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

    /**
     * 게시글 검색하기 (나라와 검색어)
     */
    public List<PostDto> findAllByCountryId(SearchDto searchDto) {
        return curiousDao.findAllByCountryId(searchDto);
    }

    /**
     * 사용자별 게시글 리스트 가져오기
     */
    public List<PostDto> findAllByUserId() {
        return curiousDao.findAllByUserId(userService.getUserData().getId());
    }

    /**
     * 여행에 대해 궁금해요! - 게시글 수정
     */
    public void updateCuriousPostByPostDto(PostDto postDto) throws Exception {
        if (userService.compareWriterAndUser(postDto.getUserId())) // 수정 권한 확인
            curiousDao.updateCuriousPostByPostDto(postDto);
        else throw new Exception("수정 권한이 없습니다.");
    }

    /**
     * 여행에 대해 궁금해요! - 게시글 삭제
     */
    public void deleteCuriousPost(PostDto postDto) throws Exception {
        if (userService.compareWriterAndUser(postDto.getUserId())) { // 삭제 권한 확인
            commentService.deleteCuriousCommentsByPostId(postDto.getId()); // 게시글 댓글 리스트 삭제
            curiousDao.deleteCuriousPost(postDto); // 게시글 삭제
        } else throw new Exception("삭제 권한이 없습니다.");
    }
}
