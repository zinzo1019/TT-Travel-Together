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
import org.springframework.web.bind.annotation.*;

import java.util.List;

@Controller
@RequestMapping("/user/community/curious")
public class CommunityController {

    @Autowired
    private CountryService countryService;
    @Autowired
    private UserService userService;
    @Autowired
    private CuriousService curiousService;
    @Autowired
    private CommentServiceImpl commentService;

    /**
     * 여행에 대해 궁금해요
     */
    @GetMapping("")
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
    @GetMapping("/view")
    public String curiousAboutTravelViewPage(@RequestParam("postId") int postId, Model model) {
        model.addAttribute("user", userService.getUserData()); // 사용자 정보 담기
        model.addAttribute("options", countryService.findAllCountries()); // 나라 정보 담기
        model.addAttribute("post", curiousService.findOneByPostId(postId)); // 게시글 정보 담기
        model.addAttribute("comments", commentService.findAllCuriousCommentsByPostId(postId)); // 댓글 정보 담기
        return "community/curious_about_travel_view";
    }

    /**
     * 여행에 대해 궁금해요 - 수정 페이지
     */
    @GetMapping("/modify/view")
    public String curiousAboutTravelModifyViewPage(@RequestParam("postId") int postId, Model model) {
        model.addAttribute("user", userService.getUserData()); // 사용자 정보 담기
        model.addAttribute("options", countryService.findAllCountries()); // 나라 정보 담기
        model.addAttribute("post", curiousService.findOneByPostId(postId)); // 게시글 정보 담기
        model.addAttribute("comments", commentService.findAllCuriousCommentsByPostId(postId)); // 댓글 정보 담기
        return "community/curious_about_travel_modify";
    }

    /**
     * 여행에 대해 궁금해요 - 수정하기 동작
     */
    @PostMapping("/modify/view")
    public ResponseEntity<String> curiousAboutTravelModify(PostDto postDto) {
        try {
            curiousService.updateCuriousPostByPostDto(postDto);
            return ResponseEntity.ok("게시글을 수정했습니다.");
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).body("게시글 수정에 실패했습니다: " + e.getMessage());
        }
    }

    /**
     * 여행에 대해 궁금해요 - 삭제하기 동작
     */
    @PostMapping("/delete/view")
    public ResponseEntity<String> curiousAboutTravelDelete(PostDto postDto) {
        try {
            curiousService.deleteCuriousPost(postDto);
            return ResponseEntity.ok("게시글을 삭제했습니다.");
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).body("게시글 삭제에 실패했습니다: " + e.getMessage());
        }
    }

    /**
     * 여행에 대해 궁금해요 - 작성하기 페이지
     */
    @GetMapping("/post")
    public String curiousAboutTravelPost(Model model) {
        model.addAttribute("user", userService.getUserData()); // 사용자 정보 담기
        model.addAttribute("options", countryService.findAllCountries()); // 나라 정보 담기
        return "community/curious_about_travel_post";
    }

    /**
     * 여행에 대해 궁금해요 - 작성하기 동작
     */
    @PostMapping("/post")
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
    @PostMapping("/comment")
    public ResponseEntity<String> curiousAboutTravelCommentPostAction(CommentDto comment) {
        try {
            commentService.saveCuriousComment(comment); // 댓글 저장
            return ResponseEntity.ok("댓글 저장에 성공했습니다.");
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(e.getMessage());
        }
    }

    /**
     * 여행에 대해 궁금해요 - 댓글 삭제하기 동작
     */
    @PostMapping("/comment/delete")
    public ResponseEntity<String> curiousCommentDelete(@RequestParam("commentId") int commentId) {
        try {
            commentService.deleteCuriousComment(commentId); // 댓글 삭제
            return ResponseEntity.ok("댓글을 삭제했습니다.");
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(e.getMessage());
        }
    }

    /**
     * 여행에 대해 궁금해요 - 검색하기
     */
    @PostMapping("/search")
    public String searchTravelCurious(SearchDto searchDto, Model model) {
        model.addAttribute("user", userService.getUserData()); // 사용자 정보 담기
        model.addAttribute("options", countryService.findAllCountries()); // 나라 정보 담기
        model.addAttribute("posts", curiousService.findAllByCountryId(searchDto)); // 검색 결과 담기
        return "community/curious_search_result";
    }
}
