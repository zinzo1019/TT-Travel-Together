package com.example.choyoujin.service;

import com.example.choyoujin.dao.RecruitedDao;
import com.example.choyoujin.dao.TravelTogetherDao;
import com.example.choyoujin.dto.PostDto;
import com.example.choyoujin.dto.SearchDto;
import com.example.choyoujin.dto.UserDto;
import com.example.choyoujin.websocket.ChatRoom;
import com.example.choyoujin.websocket.ChatService;
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
    @Autowired
    private CommentServiceImpl commentService;
    @Autowired
    private RecruitedDao recruitedDao;
    @Autowired
    private ChatService chatService;

    /**
     * 모집 게시글 저장하기
     */
    public void saveTogetherPost(PostDto postDto) {
        postDto.setUserId(userService.getUserData().getUserId()); // 작성자 아이디 Set
        postDto.setCreateDate(LocalDate.now()); // 생성 날짜 set
        togetherDao.saveTogetherPost(postDto);
        int seq = togetherDao.getMaxId();

        // 채팅방 생성하기
        chatService.createRoom(ChatRoom.builder()
                .roomId("travel_together_room_" + seq)
                .postId(seq)
                .build());
    }

    /**
     * 모집 마감 여부에 따른 모집글 리스트 가져오기
     */
    public List<PostDto> findAllTogetherPostsByEnabled(boolean enabled, int userId) {
        List<PostDto> posts = togetherDao.findAllTogetherPostsByEnabled(enabled, userId); // 모집글 리스트 가져오기
        for (PostDto dto : posts) {
            boolean supported = togetherDao.findIsSupportedByPostIdAndUserId(userService.getUserData().getUserId(), dto.getPostId()); // 모집 지원 여부
            dto.setSupported(supported);
        }
        return calculateRemainingDays(posts); // 모집 마감까지 남은 날짜 계산
    }

    /**
     * 모집 마감 기한이 지난 게시글 -> enabled = false
     */
    public void disableExpiredPosts(LocalDate now) {
        System.out.println("기한이 지난 모집글은 모집 마감 처리합니다.");
        togetherDao.disableExpiredPosts(now);
    }

    /**
     * 모집 마감 처리
     */
    public void updateEnabledByPostId(int postId, boolean enabled) {
        togetherDao.updateEnabledByPostId(postId, enabled);
    }

    /**
     * 지원자 수 1 증가
     */
    public void updateRecruitedNumber(int postId) {
        togetherDao.updateRecruitedNumber(postId);
    }

    /**
     * 지원자 수 1 감소
     */
    public void cancelRecruitedNumber(int postId) {
        togetherDao.cancelRecruitedNumber(postId);
    }

    /**
     * 모집 마감 날짜까지 남은 기한 계산
     */
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

    public List<UserDto> findRecruitedMember(int postId) {
        return recruitedDao.findRecruitedMember(postId);
    }

    /**
     * 모집글 검색하기 (나라와 날짜)
     */
    public List<PostDto> findAllByCountryIdAndEnabled(SearchDto searchDto, boolean enabled) {
        return togetherDao.findAllByCountryIdAndEnabled(searchDto, enabled); // 검색된 모집글만 가져오기
    }

    public List<PostDto> findAllTogetherPostsByEnabledAndUserId(boolean enabled) {
        List<PostDto> postDtos = togetherDao.findAllTogetherPostsByEnabledAndUserId(enabled, userService.getUserData().getUserId());
        return calculateRemainingDays(postDtos); // 모집 마감까지 남은 날짜 계산
    }

    /**
     * 같이 여행 가요 - 수정하기
     */
    public void updateTogetherPostByPostDto(PostDto postDto) throws Exception {
        if (userService.compareWriterAndUser(postDto.getUserId())) // 수정 권한 확인
            togetherDao.updateTogetherPostByPostDto(postDto);
        else throw new Exception("수정 권한이 없습니다.");
    }

    /**
     * 같이 여행 가요 - 삭제하기
     */
    public void deletetogetherPost(PostDto postDto) throws Exception {
        if (userService.compareWriterAndUser(postDto.getUserId())) { // 삭제 권한 확인
            commentService.deleteTogetherCommentsByPostId(postDto.getPostId()); // 댓글 리스트 삭제
            recruitedDao.deleteAllByPostId(postDto.getPostId()); // 모집된 인원 삭제

            chatService.deleteChatMessagesByCRoomId("travel_together_room_" + postDto.getPostId()); // 채팅 내역 삭제
            chatService.deleteChatRoom("travel_together_room_" + postDto.getPostId());// 채팅방 삭제

            togetherDao.deletetogetherPost(postDto); // 게시글 삭제
        } else throw new Exception("수정 권한이 없습니다.");
    }
}