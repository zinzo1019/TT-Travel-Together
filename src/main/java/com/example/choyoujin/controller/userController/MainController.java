package com.example.choyoujin.controller.userController;

import com.example.choyoujin.dto.*;
import com.example.choyoujin.service.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@Controller
public class MainController {

    @Autowired
    private UserService userService;
    @Autowired
    private TravelProductServiceImpl travelProductService;
    @Autowired
    private CountryService countryService;
    @Autowired
    private CommentServiceImpl commentService;
    @Autowired
    private ProductLikeServiceImpl likeService;
    @Autowired
    private CouponService couponService;
    @Autowired
    private TagService tagService;

    /**
     * 리다이렉션
     */
    @GetMapping({"", "/", "user"})
    public String redirectMainPage() {
        return "redirect:/guest";
    }

    /**
     * 메인 페이지
     */
    @GetMapping("/guest")
    public String mainPage(Model model, @RequestParam(defaultValue = "1") int page) {
        model.addAttribute("user", userService.getUserData()); // 사용자 정보 담기
        model.addAttribute("countries4", travelProductService.find4CountriesByCountryLike()); // 최근 뜨는 여행지 담기
        model.addAttribute("countries", countryService.findAllCountriesOrderByLike(page, 4)); // 모든 여행지 담기
        model.addAttribute("products", travelProductService.findAllByTravelTag(page, 4)); // 태그별 추천 여행 상품 담기
        return "main/main";
    }

    /** 메인 페이지 - 여행 상품 페이징 처리 */
    @PostMapping("/guest/product/pagination")
    public String mainPageProductPagination(String tag, @RequestParam(defaultValue = "1") int page, Model model) {
        model.addAttribute("products", travelProductService.findAllByTravelTag(tag, page, 4)); // 태그별 추천 여행 상품 담기
        return "main/main_products_by_page";
    }

    /** 메인 페이지 - 태그별 여행 상품 모아보기 */
    @GetMapping("/guest/all/products/tag")
    public String productsByTag(@RequestParam("tag") String tag, @RequestParam(defaultValue = "1") int page, Model model) {
        model.addAttribute("products", travelProductService.findAllByTravelTag(tag, page, 4));
        model.addAttribute("tag", tag);
        return "main/products_by_tag";
    }

    /** 태그별 여행 상품 - 검색하기 */
    @PostMapping("/guest/all/products/tag/search")
    public String searchPproductsByTag(String tag, String keyword, @RequestParam(defaultValue = "1") int page, Model model) {
        model.addAttribute("products", travelProductService.findAllByTravelTagAndKeyword(tag, keyword, page, 4));
        return "main/products_by_tag_search_result";
    }

    /** 메인 페이지 - 여행지 페이징 처리 */
    @PostMapping("/guest/country/pagination")
    public String mainPageCountryPagination(@RequestParam(defaultValue = "1") int page, Model model) {
        model.addAttribute("countries", countryService.findAllCountriesOrderByLike(page, 4)); // 태그별 추천 여행 상품 담기
        return "main/main_country_by_page";
    }

    /**
     * 어디로 갈지 모르겠어요 - 모든 여행지 태그별로 둘러보기
     */
    @GetMapping("/guest/all/products/bytag")
    public String allProductsPageByTag(Model model, @RequestParam(defaultValue = "1") int page) {
        model.addAttribute("user", userService.getUserData()); // 사용자 정보 담기
        model.addAttribute("productsTop4", travelProductService.findProductsTop4ByLike()); // 상위 4개 여행 상품 담기
        model.addAttribute("productsByTags", travelProductService.findAllByTravelTags(page, 4)); // 태그 별로 여행 상품 담기
        return "main/show_all_products_by_tag";
    }

    /**
     * 어디로 갈지 모르겠어요 - 모든 여행지 둘러보기
     */
    @GetMapping("/guest/all/products")
    public String allProductsPage(Model model, @RequestParam(defaultValue = "1") int page) {
        model.addAttribute("user", userService.getUserData()); // 사용자 정보 담기
        model.addAttribute("productsTop4", travelProductService.findProductsTop4ByLike()); // 상위 4개 여행 상품 담기
        model.addAttribute("products", travelProductService.findAllProducts(page, 4)); // 모든 여행 상품 담기
        return "main/show_all_products";
    }

    /** 네비게이션 바 - 모든 태그 가져오기 */
    @ResponseBody
    @GetMapping("/guest/all/tags")
    public List<TagDto> getAllTags() {
        try {
            return tagService.findAll();
        } catch (Exception e) {
            System.out.println(e.getMessage()); return null;
        }
    }

    /**
     * 어디로 갈지 모르겠어요. - 태그별 여행 상품 페이징 처리
     */
    @PostMapping("/guest/loadPagedData")
    public String allProductsPagePaging(int tagId, int page, Model model) {
        model.addAttribute("user", userService.getUserData()); // 사용자 정보 담기
        model.addAttribute("products", travelProductService.findAllByTravelTagsWithPaging(tagId, page, 4, model)); // 태그 별로 여행 상품 담기
        return "main/products_by_page";
    }

    /**
     * 어디로 갈지 모르겠어요 - 검색
     */
    @PostMapping("/guest/all/products/search")
    public String searchAllProductsPage(String keyword, Model model) {
        model.addAttribute("user", userService.getUserData()); // 사용자 정보 담기
        model.addAttribute("products", travelProductService.findAllByKeyword(keyword)); // 태그 별로 여행 상품 담기
        model.addAttribute("keyword", keyword); // 태그 별로 여행 상품 담기
        return "main/show_all_products_list_search_result";
    }

    /**
     * 메인 페이지 - 검색
     */
    @PostMapping("/guest/search")
    public String searchMainPage(String keyword, Model model, @RequestParam(defaultValue = "1") int page) {
        model.addAttribute("user", userService.getUserData()); // 사용자 정보 담기
        model.addAttribute("searchResults", countryService.findAllCountriesByKeyword(keyword, page, 4)); // 검색 결과 담기
        return "main/main_search_result";
    }

    /**
     * 나라별 상품 리스트 페이지
     */
    @GetMapping("/guest/country")
    public String countryProductsListPage(@RequestParam("country_id") int countryId, Model model) {
        CountryDto countryDto = countryService.findCountryByCountryId(countryId);
        model.addAttribute("user", userService.getUserData()); // 사용자 정보 담기
        model.addAttribute("country", countryDto); // 나라 정보 담기
        model.addAttribute("products", travelProductService.findAllProductsByCountryId(countryId)); // 여행 상품 리스트 담기
        model.addAttribute("news", countryService.crawlNaverNewsHeadlines(countryDto.getCountry())); // 여행 상품 리스트 담기
        return "main/country_products_list";
    }

    /**
     * 나라별 상품 리스트 페이지 - 검색
     */
    @PostMapping("/guest/country/search")
    public String SearchCountryProductsListPage(@RequestParam("country_id") int countryId, String keyword, Model model) {
        model.addAttribute("user", userService.getUserData()); // 사용자 정보 담기
        model.addAttribute("country", countryService.findCountryByCountryId(countryId)); // 나라 정보 담기
        List<ProductDto> productDtos = travelProductService.findAllProductsByCountryIdAndKeyword(countryId, keyword);
        model.addAttribute("products", productDtos); // 여행 상품 리스트 담기
        return "main/products_search_result";
    }

    /**
     * 여행지 상세 페이지
     */
    @GetMapping("/guest/product/detail")
    public String countryDetailPage(@RequestParam("product_id") int productId, Model model) {
        model.addAttribute("user", userService.getUserData()); // 사용자 정보 담기
        model.addAttribute("comments", commentService.findAllProductCommentsByPostId(productId)); // 댓글 리스트 가져오기
        model.addAttribute("product", travelProductService.findProductByProductId(productId)); // 여행지 상세 데이터 담기
        return "main/travel_product_detail";
    }

    /**
     * 여행지 상세 페이지 - 좋아요 동작
     */
    @PostMapping("/guest/product/like")
    public ResponseEntity<String> productLikeAction(@RequestParam("product_id") int productId) {
        try {
            likeService.saveProductLike(productId); // 좋아요 저장
            return ResponseEntity.ok("좋아요를 눌렀습니다.");
        } catch (Exception e) {
            System.out.println(e.getMessage());
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).body("좋아요 저장에 실패했습니다.");
        }
    }

    /**
     * 여행지 상세 페이지 - 좋아요 취소 동작
     */
    @PostMapping("/guest/product/unlike")
    public ResponseEntity<String> productUnLikeAction(@RequestParam("product_id") int productId) {
        try {
            likeService.deleteProductLike(productId); // 좋아요 취소
            return ResponseEntity.ok("좋아요를 눌렀습니다.");
        } catch (Exception e) {
            System.out.println(e.getMessage());
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).body("좋아요 저장에 실패했습니다.");
        }
    }

    /** 쿠폰 적용하기 */
    @PostMapping("/guest/product/coupon/apply")
    public ResponseEntity<String> productCouponApplyAction(@RequestParam("coupon_id") int couponId, int cost) {
        try {
            cost = couponService.getCostAfterCouponApply(couponId, cost); // 할인가 적용
            return ResponseEntity.ok(String.valueOf(cost));
        } catch (Exception e) {
            System.out.println(e.getMessage());
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).body("쿠폰 적용에 실패했습니다.");
        }
    }


    /**
     * 여행지 상세 페이지 - 댓글 작성하기 동작
     */
    @PostMapping("/guest/product/comment")
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
    @PostMapping("/guest/product/comment/delete")
    public ResponseEntity<String> productCommentDelete(@RequestParam("commentId") int commentId) {
        try {
            commentService.deleteProductComment(commentId); // 댓글 삭제
            return ResponseEntity.ok("댓글을 삭제했습니다.");
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).body("댓글 삭제에 실패했습니다.");
        }
    }

    /**
     * 로그인 페이지
     */
    @RequestMapping("/login")
    public String loginPage() {
        return "login";
    }

    /**
     * 회원가입 페이지
     */
    @RequestMapping("/signup")
    public String signUpPage() {
        return "sign_up";
    }

    /**
     * ROLE_USER 회원가입 로직
     */
    @RequestMapping("/guest/signup-process")
    public ResponseEntity<String> signUpProcess(UserDto userDto) {
        try {
            userService.saveUser(userDto, "ROLE_USER");
            return ResponseEntity.ok("회원가입에 성공했습니다.");
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).body("회원가입에 실패했습니다.");
        }
    }

    /**
     * 이메일 중복 확인
     */
    @RequestMapping("/guest/email/check")
    public ResponseEntity<String> checkIdDuplication(UserDto userDto) {
        if (userService.isUser(userDto.getEmail()) == true) {
            System.out.println("중복된 아이디입니다.");
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).body("이미 사용 중인 아이디입니다.");
        } else {
            return ResponseEntity.ok("사용 가능한 아이디 입니다.");
        }
    }
}
