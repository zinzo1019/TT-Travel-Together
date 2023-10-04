package com.example.choyoujin.controller;

import com.example.choyoujin.dto.*;
import com.example.choyoujin.service.CountryService;
import com.example.choyoujin.service.TravelProductService;
import com.example.choyoujin.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
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
public class MainController {

    @Autowired
    private UserService userService;
    @Autowired
    private TravelProductService travelProductService;
    @Autowired
    private CountryService countryService;

    /** 리다이렉션 */
    @GetMapping({"", "/", "ROLE_USER"})
    public String redirectMainPage() {
        return "redirect:/ROLE_GUEST";
    }

    /** 메인 페이지 */
    @GetMapping("/ROLE_GUEST")
    public String mainPage(Model model, @RequestParam(defaultValue = "2") int page) {
        userService.getUserAndAddModel(model); // 사용자 정보 담기

        List<ProductDto> countries = travelProductService.findAllCountriesByCountryLike();
        model.addAttribute("countries", countries); // 최근 뜨는 여행지 담기

        Pagination pagination = getPagination();
        Page<CountryDto> countriesExcept4 = countryService.findAllCountriesExcept4(page, 4);
        pagination.setTotalCount(countryService.countAllCountries() - 4); // 총 개수 - 4

        model.addAttribute("pagination", pagination); // 페이징 담기
        model.addAttribute("countriesExcept4", countriesExcept4); // 최근 4개 여행지 제외 전체 여행지 가져오기
        return "main/main";
    }

    /** 메인 페이지 - 검색 */
    @PostMapping("/ROLE_GUEST/search")
    public String searchMainPage(String keyword, Model model, @RequestParam(defaultValue = "1") int page) {
        userService.getUserAndAddModel(model); // 사용자 정보 담기
        Pagination pagination = getPagination();
        Page<CountryDto> searchResults = countryService.findAllCountriesByKeyword(keyword, page, 4); // 나라 이름으로 검색
        pagination.setTotalCount(countryService.countAllCountriesByKeyword(keyword)); // 나라 이름으로 검색된 개수

        model.addAttribute("pagination", pagination); // 페이징 담기
        model.addAttribute("searchResults", searchResults); // 검색 결과 담기
        return "main/main_search_result";
    }

    /** 나라별 상품 리스트 페이지 */
    @GetMapping("/ROLE_GUEST/country")
    public String countryProductsListPage(@RequestParam("country_id") int countryId, Model model) {
        userService.getUserAndAddModel(model); // 사용자 정보 담기
        CountryDto countryDto = countryService.findCountryByCountryId(countryId);
        model.addAttribute("country", countryDto); // 나라 정보 담기

        List<ProductDto> productDtos = travelProductService.findAllProductsByCountryId(countryId);
        model.addAttribute("products", productDtos); // 여행 상품 리스트 담기
        model.addAttribute("count", productDtos.size()); // 여행 상품 개수 담기
        return "main/country_products_list";
    }

    /** 나라별 상품 리스트 페이지 - 검색 */
    @PostMapping("/ROLE_GUEST/country/search")
    public String SearchCountryProductsListPage(@RequestParam("country_id") int countryId, String keyword, Model model) {
        userService.getUserAndAddModel(model); // 사용자 정보 담기
        CountryDto countryDto = countryService.findCountryByCountryId(countryId);
        model.addAttribute("country", countryDto); // 나라 정보 담기

        List<ProductDto> productDtos = travelProductService.findAllProductsByCountryIdAndKeyword(countryId, keyword);
        model.addAttribute("products", productDtos); // 여행 상품 리스트 담기
        model.addAttribute("count", productDtos.size()); // 여행 상품 개수 담기
        return "main/products_search_result";
    }

    /** 여행지 상세 페이지 */
    @GetMapping( "/ROLE_GUEST/product/detail")
    public String countryDetailPage(@RequestParam("product_id") int productId, Model model) {
        userService.getUserAndAddModel(model); // 사용자 정보 담기
        ProductDto productDto = travelProductService.findProductByProductId(productId);

        System.out.println(productDto);

        model.addAttribute("product", productDto);
        return "main/travel_product_detail";
    }

    /** 로그인 페이지 */
    @RequestMapping("/login")
    public String loginPage() {
        return "login";
    }

    /** 회원가입 페이지 */
    @RequestMapping("/signup")
    public String signUpPage() {
        return "sign_up";
    }

    /** ROLE_USER 회원가입 로직 */
    @RequestMapping("/ROLE_GUEST/signup-process")
    public String signUpProcess(UserDto userDto) {
        int imageId = userService.saveImageAndGetImageId(userDto); // 이미지 저장
        userService.saveUser(userDto, "ROLE_USER", 1, imageId); // 사용자 저장
        return "login";
    }

    /** 이메일 중복 확인 */
    @GetMapping("/ROLE_GUEST/email/check")
    public ResponseEntity<String> checkIdDuplication(@RequestParam(value = "email") String email) {
        if (userService.isUser(email) == true) {
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).body("이미 사용 중인 아이디입니다.");
        } else {
            return ResponseEntity.ok("사용 가능한 아이디 입니다.");
        }
    }

    /** Pagination 생성 */
    private static Pagination getPagination() {
        Pagination pagination = new Pagination();
        pagination.setPageRequest(new PageRequest());
        return pagination;
    }
}
