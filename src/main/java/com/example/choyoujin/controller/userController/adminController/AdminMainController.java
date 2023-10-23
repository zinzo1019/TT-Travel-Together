package com.example.choyoujin.controller.userController.adminController;

import com.example.choyoujin.dto.*;
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
public class AdminMainController {

    @Autowired
    private UserService userService;
    @Autowired
    private TravelProductServiceImpl travelProductService;
    @Autowired
    private CountryService countryService;
    @Autowired
    private CommentServiceImpl commentService;

    /**
     * 메인 페이지
     */
    @GetMapping("/admin")
    public String mainPage(Model model, @RequestParam(defaultValue = "2") int page) {
        model.addAttribute("user", userService.getUserData()); // 사용자 정보 담기
        model.addAttribute("countries4", travelProductService.find4CountriesByCountryLike()); // 최근 뜨는 여행지 담기
        model.addAttribute("countries", countryService.findAllCountriesOrderByLike(page, 4)); // 전체 여행지 가져오기

        Pagination pagination = getPagination();
        pagination.setTotalCount(countryService.countAllCountries()); // 총 개수
        model.addAttribute("pagination", pagination); // 페이징 담기
        return "admin/main/main";
    }

    /**
     * 메인 페이지 - 검색
     */
    @PostMapping("/admin/search")
    public String searchMainPage(String keyword, Model model, @RequestParam(defaultValue = "1") int page) {
        model.addAttribute("user", userService.getUserData()); // 사용자 정보 담기
        model.addAttribute("searchResults", countryService.findAllCountriesByKeyword(keyword, page, 4)); // 검색 결과 담기

        Pagination pagination = getPagination();
        pagination.setTotalCount(countryService.countAllCountriesByKeyword(keyword)); // 나라 이름으로 검색된 개수
        model.addAttribute("pagination", pagination); // 페이징 담기
        return "main/main_search_result";
    }

    /**
     * 나라별 상품 리스트 페이지
     */
    @GetMapping("/admin/country")
    public String countryProductsListPage(@RequestParam("country_id") int countryId, Model model) {
        model.addAttribute("user", userService.getUserData()); // 사용자 정보 담기
        model.addAttribute("country", countryService.findCountryByCountryId(countryId)); // 나라 정보 담기

        List<ProductDto> productDtos = travelProductService.findAllProductsByCountryId(countryId);
        model.addAttribute("products", travelProductService.findAllProductsByCountryId(countryId)); // 여행 상품 리스트 담기
        model.addAttribute("count", productDtos.size()); // 여행 상품 개수 담기
        return "main/country_products_list";
    }

    /**
     * 나라별 상품 리스트 페이지 - 검색
     */
    @PostMapping("/admin/country/search")
    public String SearchCountryProductsListPage(@RequestParam("country_id") int countryId, String keyword, Model model) {
        model.addAttribute("user", userService.getUserData()); // 사용자 정보 담기
        model.addAttribute("country", countryService.findCountryByCountryId(countryId)); // 나라 정보 담기
        List<ProductDto> productDtos = travelProductService.findAllProductsByCountryIdAndKeyword(countryId, keyword);
        model.addAttribute("products", productDtos); // 여행 상품 리스트 담기
        model.addAttribute("count", productDtos.size()); // 여행 상품 개수 담기
        return "main/products_search_result";
    }

    /**
     * 여행지 상세 페이지
     */
    @GetMapping("/admin/product/detail")
    public String countryDetailPage(@RequestParam("product_id") int productId, Model model) {
        model.addAttribute("user", userService.getUserData()); // 사용자 정보 담기
        model.addAttribute("comments", commentService.findAllProductCommentsByPostId(productId)); // 댓글 리스트 가져오기
        model.addAttribute("product", travelProductService.findProductByProductId(productId)); // 여행지 상세 데이터 담기
        return "main/travel_product_detail";
    }

    /**
     * 여행지 상세 페이지 - 댓글 작성하기 동작
     */
    @PostMapping("/admin/product/comment")
    public ResponseEntity<String> productCommentPostAction(CommentDto comment) {
        try {
            commentService.saveProductComment(comment); // 댓글 저장
            return ResponseEntity.ok("댓글 저장에 성공했습니다.");
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(e.getMessage());
        }
    }

    /**
     * 여행지 상세 페이지 - 댓글 삭제하기 동작
     */
    @PostMapping("/admin/product/comment/delete")
    public ResponseEntity<String> productCommentDelete(@RequestParam("commentId") int commentId) {
        try {
            commentService.deleteProductComment(commentId); // 댓글 삭제
            return ResponseEntity.ok("댓글을 삭제했습니다.");
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).body("댓글 삭제에 실패했습니다.");
        }
    }

    /**
     * 회원가입 페이지
     */
    @RequestMapping("/signup/admin")
    public String signUpPage() {
        return "admin/base_view/sign_up";
    }

    /**
     * ROLE_ADMIN 회원가입 동작
     */
    @PostMapping("/guest/admin/signup-process")
    public ResponseEntity<String> signUpProcess(UserDto userDto) {
        try {
            int imageId = userService.saveImageAndGetImageId(userDto); // 이미지 저장
            userService.saveUser(userDto, "ROLE_ADMIN", 1, imageId); // 사용자 저장
            return ResponseEntity.ok("회원가입을 성공했습니다.");
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).body("회원가입을 실패했습니다.");
        }
    }

    /**
     * Pagination 생성
     */
    public static Pagination getPagination() {
        Pagination pagination = new Pagination();
        pagination.setPageRequest(new PageRequest());
        return pagination;
    }
}
