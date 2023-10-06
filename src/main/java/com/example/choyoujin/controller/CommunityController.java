package com.example.choyoujin.controller;

import com.example.choyoujin.dto.CommentDto;
import com.example.choyoujin.dto.PostDto;
import com.example.choyoujin.dto.SearchDto;
import com.example.choyoujin.service.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@Controller
@RequestMapping("/ROLE_USER/community")
public class CommunityController {

    @Autowired
    private CountryService countryService;
    @Autowired
    private UserService userService;
    @Autowired
    private TravelTogetherService togetherService;
    @Autowired
    private RecruitedService recruitedService;
    @Autowired
    private CuriousService curiousService;
    @Autowired
    private CommentServiceImpl commentService;

    /**
     * 여행에 대해 궁금해요
     */
    @GetMapping("/curious")
    public String curiousAboutTravelPage(Model model) {
        model.addAttribute("user", userService.getUserData()); // 사용자 정보 담기
        model.addAttribute("options", countryService.findAllCountries()); // 나라 정보 담기
        List<PostDto> posts = curiousService.findAllPosts();
        model.addAttribute("posts", posts);
        return "community/curious_about_travel";
    }

    /**
     * 여행에 대해 궁금해요 - 뷰 페이지
     */
    @GetMapping("/curious/view")
    public String curiousAboutTravelViewPage(@RequestParam("postId") int postId, Model model) {
        model.addAttribute("user", userService.getUserData()); // 사용자 정보 담기
        model.addAttribute("options", countryService.findAllCountries()); // 나라 정보 담기
        model.addAttribute("post", curiousService.findOneByPostId(postId)); // 게시글 정보 담기
        model.addAttribute("comments", commentService.findAllCuriousCommentsByPostId(postId)); // 댓글 정보 담기
        return "community/curious_about_travel_view";
    }

    /**
     * 여행에 대해 궁금해요 - 작성하기 페이지
     */
    @GetMapping("/curious/post")
    public String curiousAboutTravelPost(Model model) {
        model.addAttribute("user", userService.getUserData()); // 사용자 정보 담기
        model.addAttribute("options", countryService.findAllCountries()); // 나라 정보 담기
        return "community/curious_about_travel_post";
    }

    /**
     * 여행에 대해 궁금해요 - 작성하기 동작
     */
    @PostMapping("/curious/post")
    public ResponseEntity<String> curiousAboutTravelPostAction(PostDto postDto) {
        try {
            curiousService.saveCuriousPost(postDto); // 게시글 저장
            return ResponseEntity.ok("게시글 저장에 성공했습니다.");
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).body("게시글 저장에 실패했습니다.");
        }
    }

    /**
     * 여행에 대해 궁금해요 - 댓글 작성하기 동작
     */
    @PostMapping("/curious/comment")
    public ResponseEntity<String> curiousAboutTravelCommentPostAction(CommentDto comment) {
        try {
            commentService.saveCuriousComment(comment); // 댓글 저장
            return ResponseEntity.ok("댓글 저장에 성공했습니다.");
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).body("댓글 저장에 실패했습니다.");
        }
    }

    /**
     * 여행에 대해 궁금해요 - 대댓글 작성하기 동작
     */
    @PostMapping("/curious/reply")
    public ResponseEntity<String> curiousAboutTravelReplyPostAction(CommentDto comment) {
        try {
            commentService.saveCuriousComment(comment); // 댓글 저장
            return ResponseEntity.ok("댓글 저장에 성공했습니다.");
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).body("댓글 저장에 실패했습니다.");
        }
    }

    /** 여행에 대해 궁금해요 - 검색하기 */
    @PostMapping("/curious/search")
    public String searchTravelCurious(SearchDto searchDto, Model model) {
        model.addAttribute("user", userService.getUserData()); // 사용자 정보 담기
        model.addAttribute("options", countryService.findAllCountries()); // 나라 정보 담기
        model.addAttribute("posts", curiousService.findAllByCountryId(searchDto)); // 검색 결과 담기

        System.out.println(searchDto);

        return "community/curious_search_result";
    }

    /**
     * 같이 여행 가요
     */
    @GetMapping("/together")
    public String travelTogetherPage(Model model) {
        model.addAttribute("user", userService.getUserData()); // 사용자 정보 담기
        model.addAttribute("options", countryService.findAllCountries()); // 나라 정보 담기

        List<PostDto> postsByTrue = togetherService.findAllTogetherPostsByEnabled(true); // 마감 전
        List<PostDto> postsByFalse = togetherService.findAllTogetherPostsByEnabled(false); // 마감 후
        model.addAttribute("postsByTrue", postsByTrue); // 모집 게시글 리스트 담기 (마감 전)
        model.addAttribute("postsByFalse", postsByFalse); // 모집 게시글 리스트 담기 (마감 후)
        return "community/travel_together";
    }

    /** 같이 여행 가요 - 검색하기 */
    @PostMapping("/together/search")
    public String searchTravelTogether(SearchDto searchDto, Model model) {
        model.addAttribute("user", userService.getUserData()); // 사용자 정보 담기
        model.addAttribute("options", countryService.findAllCountries()); // 나라 정보 담기
        List<PostDto> postsByTrue = togetherService.findAllByCountryIdAndEnabled(searchDto, true); // 모집글 검색하기 (나라와 날짜)
        postsByTrue = togetherService.calculateRemainingDays(postsByTrue); // 모집 마감까지 남은 날짜 계산
        model.addAttribute("postsByTrue", postsByTrue);
        return "community/travel_together_search_result";
    }

    /**
     * 같이 여행 가요 - 작성하기 페이지
     */
    @GetMapping("/together/post")
    public String travelTogetherPost(Model model) {
        model.addAttribute("user", userService.getUserData()); // 사용자 정보 담기
        model.addAttribute("options", countryService.findAllCountries()); // 나라 정보 담기
        return "community/travel_together_post";
    }

    /**
     * 같이 여행 가요 - 작성하기 동작
     */
    @PostMapping("/together/post")
    public ResponseEntity<String> travelTogetherPostAction(PostDto postDto) {
        try {
            togetherService.saveTogetherPost(postDto); // 게시글 저장
            return ResponseEntity.ok("게시글 저장에 성공했습니다.");
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).body("게시글 저장에 실패했습니다.");
        }
    }

    /**
     * 같이 여행 가요 - 뷰 페이지
     */
    @GetMapping("/together/view")
    public String travelTogetherViewPage(@RequestParam("postId") int postId, Model model) {
        model.addAttribute("user", userService.getUserData()); // 사용자 정보 담기
        model.addAttribute("options", countryService.findAllCountries()); // 나라 정보 담기
        model.addAttribute("post", togetherService.findOneByPostId(postId)); // 게시글 정보 담기
        model.addAttribute("comments", commentService.findAllTogetherCommentsByPostId(postId)); // 댓글 정보 담기
        return "community/travel_together_view";
    }


    /**
     * 같이 여행 가요 - 댓글 작성하기 동작
     */
    @PostMapping("/together/comment")
    public ResponseEntity<String> togetherCommentPostAction(CommentDto comment) {
        try {
            commentService.saveTogetherComment(comment); // 댓글 저장
            return ResponseEntity.ok("댓글 저장에 성공했습니다.");
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).body("댓글 저장에 실패했습니다.");
        }
    }

    /**
     * 같이 여행 가요 - 대댓글 작성하기 동작
     */
    @PostMapping("/together/reply")
    public ResponseEntity<String> togetherReplyPostAction(CommentDto comment) {
        try {
            commentService.saveTogetherComment(comment); // 댓글 저장
            return ResponseEntity.ok("댓글 저장에 성공했습니다.");
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).body("댓글 저장에 실패했습니다.");
        }
    }

    /**
     * 모집 마감하기
     */
    @PostMapping("/together/close")
    public ResponseEntity<String> closeRecruitment(@RequestParam("postId") int postId) {
        try {
            togetherService.updateEnabledByPostId(postId, false); // 모집 마감 처리
            return ResponseEntity.ok("모집이 마감되었습니다.");
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).body("모집 마감에 실패했습니다.");
        }
    }

    /**
     * 모집글에 지원하기
     */
    @PostMapping("/together/apply")
    public ResponseEntity<String> applyRecruitment(@RequestParam("postId") int postId) {
        try {
            recruitedService.applyToRecruitment(postId); // 모집글에 지원하기
            return ResponseEntity.ok("지원을 완료했습니다.");
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(e.getMessage());
        }
    }
}
