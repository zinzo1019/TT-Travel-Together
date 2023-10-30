package com.example.choyoujin.service;

import com.example.choyoujin.dao.RecruitedDao;
import com.example.choyoujin.dto.PostDto;
import com.example.choyoujin.dto.RecruitedDto;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class RecruitedService {

    @Autowired
    private RecruitedDao recruitedDao;
    @Autowired
    private TravelTogetherService togetherService;
    @Autowired
    private UserService userService;

    /** 지원자 저장하기 */
    public void saveRecruitedMember(int userId, int postId) {
        recruitedDao.saveRecruitedMember(userId, postId);
    }

    /** 지원자 삭제하기 */
    public void deleteRecruitedMember(int userId, int postId) {
        recruitedDao.deleteRecruitedMember(userId, postId);
    }

    /** 모집글 아이디와 사용자 아이디로 지원 여부 확인하기 */
    public RecruitedDto findOneByPostIdAndUserId(int userId, int postId) {
        return recruitedDao.findOneByPostIdAndUserId(userId, postId);
    }

    /** 모집글에 지원하기 */
    public void applyToRecruitment(int postId) throws Exception {
        // 이미 지원한 모집글인지 확인
        RecruitedDto recruitedDto = findOneByPostIdAndUserId(userService.getUserData().getUserId(), postId); // 모집 db에서 지원 데이터 찾기
        if (recruitedDto != null) throw new Exception("이미 지원한 모집글입니다."); // 이미 데이터가 있다면 이미 지원한 모집글 -> 에러 던지기
        togetherService.updateRecruitedNumber(postId); // 지원자 수 +1 증가
        saveRecruitedMember(userService.getUserData().getUserId(), postId); // 지원자 저장

        // 모집 인원이 다 찼다면 모집 마감 처리
        PostDto postDto = togetherService.findOneByPostId(postId);
        if (postDto.getRecruitedNumber() >= postDto.getTotalNum()) {
            togetherService.updateEnabledByPostId(postId, false);
            throw new Exception("지원을 완료했습니다. 인원수가 모두 차 마감 처리합니다.");
        }
    }

    /** 모집글에 지원 취소하기 */
    public void caneclToRecruitment(int postId) {
        togetherService.cancelRecruitedNumber(postId); // 지원자 수 -1 감소
        deleteRecruitedMember(userService.getUserData().getUserId(), postId); // 지원자 삭제
    }
}
