package com.example.choyoujin.controller.userController;

import com.example.choyoujin.dto.CommentDto;
import com.example.choyoujin.dto.PostDto;
import com.example.choyoujin.dto.SearchDto;
import com.example.choyoujin.service.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.List;

@Controller
@RequestMapping("/user/community/together")
public class TravelTogetherController {

    @Autowired
    private CountryService countryService;
    @Autowired
    private UserService userService;
    @Autowired
    private TravelTogetherService togetherService;
    @Autowired
    private RecruitedService recruitedService;
    @Autowired
    private CommentServiceImpl commentService;

    /**
     * 같이 여행 가요 - 리스트 페이지
     */
    @GetMapping("")
    public String travelTogetherPage(Model model) {
        model.addAttribute("user", userService.getUserData()); // 사용자 정보 담기
        model.addAttribute("options", countryService.findAllCountries()); // 나라 정보 담기
        List<PostDto> postsByTrue = togetherService.findAllTogetherPostsByEnabled(true); // 마감 전
        List<PostDto> postsByFalse = togetherService.findAllTogetherPostsByEnabled(false); // 마감 후
        model.addAttribute("postsByTrue", postsByTrue); // 모집 게시글 리스트 담기 (마감 전)
        model.addAttribute("postsByFalse", postsByFalse); // 모집 게시글 리스트 담기 (마감 후)
        return "community/travel_together";
    }

    /**
     * 같이 여행 가요 - 검색하기
     */
    @PostMapping("/search")
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
    @GetMapping("/post")
    public String travelTogetherPost(Model model) {
        model.addAttribute("user", userService.getUserData()); // 사용자 정보 담기
        model.addAttribute("options", countryService.findAllCountries()); // 나라 정보 담기
        return "community/travel_together_post";
    }

    /**
     * 같이 여행 가요 - 작성하기 동작
     */
    @PostMapping("/post")
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
    @GetMapping("/view")
    public String travelTogetherViewPage(@RequestParam("postId") int postId, Model model) {
        model.addAttribute("user", userService.getUserData()); // 사용자 정보 담기
        model.addAttribute("options", countryService.findAllCountries()); // 나라 정보 담기
        model.addAttribute("post", togetherService.findOneByPostId(postId)); // 게시글 정보 담기
        model.addAttribute("recruitedMember", togetherService.findRecruitedMember(postId)); // 모집 정보 담기
        model.addAttribute("comments", commentService.findAllTogetherCommentsByPostId(postId)); // 댓글 정보 담기
        return "community/travel_together_view";
    }

    /**
     * 같이 여행 가요 - 댓글 작성하기 동작
     */
    @PostMapping("/comment")
    public ResponseEntity<String> togetherCommentPostAction(CommentDto comment) {
        try {
            commentService.saveTogetherComment(comment); // 댓글 저장
            return ResponseEntity.ok("댓글 저장에 성공했습니다.");
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(e.getMessage());
        }
    }

    /**
     * 같이 여행 가요 - 댓글 삭제하기 동작
     */
    @PostMapping("/comment/delete")
    public ResponseEntity<String> togetherCommentDelete(@RequestParam("commentId") int commentId) {
        try {
            commentService.deleteTogetherComment(commentId); // 댓글 삭제
            return ResponseEntity.ok("댓글을 삭제했습니다.");
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).body("댓글 삭제에 실패했습니다.");
        }
    }

    /**
     * 같이 여행 가요 - 수정 페이지
     */
    @GetMapping("/modify/view")
    public String travelTogetherModifyViewPage(@RequestParam("postId") int postId, Model model) {
        model.addAttribute("user", userService.getUserData()); // 사용자 정보 담기
        model.addAttribute("options", countryService.findAllCountries()); // 나라 정보 담기
        model.addAttribute("post", togetherService.findOneByPostId(postId)); // 게시글 정보 담기
        return "community/travel_together_modify";
    }

    /**
     * 같이 여행 가요  - 수정하기 동작
     */
    @PostMapping("/modify/view")
    public ResponseEntity<String> togetherAboutTravelModify(PostDto postDto) {
        try {
            togetherService.updateTogetherPostByPostDto(postDto);
            return ResponseEntity.ok("게시글을 수정했습니다.");
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).body("게시글 수정에 실패했습니다: " + e.getMessage());
        }
    }

    /**
     * 같이 여행 가요  - 삭제하기 동작
     */
    @PostMapping("/delete/view")
    public ResponseEntity<String> togetherAboutTravelDelete(PostDto postDto) {
        try {
            togetherService.deletetogetherPost(postDto);
            return ResponseEntity.ok("게시글을 삭제했습니다.");
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).body("게시글 삭제에 실패했습니다: " + e.getMessage());
        }
    }

    /**
     * 모집 마감하기
     */
    @PostMapping("/close")
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
    @PostMapping("/apply")
    public ResponseEntity<String> applyRecruitment(@RequestParam("postId") int postId) {
        try {
            recruitedService.applyToRecruitment(postId); // 모집글에 지원하기
            return ResponseEntity.ok("지원을 완료했습니다.");
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(e.getMessage());
        }
    }

    /**
     * 모집글에 지원 취소하기
     */
    @PostMapping("/cancel")
    public ResponseEntity<String> cancelRecruitment(@RequestParam("postId") int postId) {
        try {
            recruitedService.caneclToRecruitment(postId); // 모집글 지원 취소하기
            return ResponseEntity.ok("지원을 취소했습니다.");
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(e.getMessage());
        }
    }
}
