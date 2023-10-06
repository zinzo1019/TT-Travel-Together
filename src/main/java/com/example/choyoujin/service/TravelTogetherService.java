package com.example.choyoujin.service;

import com.example.choyoujin.dao.TravelTogetherDao;
import com.example.choyoujin.dto.PostDto;
import com.example.choyoujin.dto.SearchDto;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.time.LocalDate;
import java.time.temporal.ChronoUnit;
import java.util.List;

@Service
public class TravelTogetherService {

    @Autowired
    private TravelTogetherDao togetherDao;
    @Autowired
    private UserService userService;

    /** 모집 게시글 저장하기 */
    public void saveTogetherPost(PostDto postDto) {
        postDto.setUserId(userService.getUserData().getId()); // 작성자 아이디 Set
        postDto.setCreateDate(LocalDate.now()); // 생성 날짜 set
        togetherDao.saveTogetherPost(postDto);
    }

    /** 모집 마감 여부에 따른 모집글 리스트 가져오기 */
    public List<PostDto> findAllTogetherPostsByEnabled(boolean enabled) {
        List<PostDto> posts = togetherDao.findAllTogetherPostsByEnabled(enabled); // 모집글 리스트 가져오기
        return calculateRemainingDays(posts); // 모집 마감까지 남은 날짜 계산
    }

    /** 모집 마감 기한이 지난 게시글 -> enabled = false */
    public void disableExpiredPosts(LocalDate now) {
        togetherDao.disableExpiredPosts(now);
    }

    /** 모집 마감 처리 */
    public void updateEnabledByPostId(int postId, boolean enabled) {
        togetherDao.updateEnabledByPostId(postId, enabled);
    }

    /** 지원자 수 1 증가 */
    public void updateRecruitedNumber(int postId) {
        togetherDao.updateRecruitedNumber(postId);
    }

    /** 모집 마감 날짜까지 남은 기한 계산 */
    public List<PostDto> calculateRemainingDays(List<PostDto> postDtos) {
        for (PostDto dto : postDtos) { // 모집 마감까지 남은 날짜 Set
            LocalDate deadline = dto.getDeadline(); // 모집 마감 날짜
            int days = (int) ChronoUnit.DAYS.between(LocalDate.now(), deadline); // 남은 날짜
            dto.setRemainingDays(days);
        }
        return postDtos;
    }

    public PostDto findOneByPostId(int postId) {
        return togetherDao.findOneByPostId(postId);
    }

    /** 모집글 검색하기 (나라와 날짜) */
    public List<PostDto> findAllByCountryIdAndEnabled(SearchDto searchDto, boolean enabled) {
        return togetherDao.findAllByCountryIdAndEnabled(searchDto, enabled); // 검색된 모집글만 가져오기
    }
}
