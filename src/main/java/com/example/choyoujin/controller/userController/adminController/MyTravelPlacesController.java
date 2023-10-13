package com.example.choyoujin.controller.userController.adminController;

import com.example.choyoujin.dto.ProductDto;
import com.example.choyoujin.service.CountryService;
import com.example.choyoujin.service.TravelProductServiceImpl;
import com.example.choyoujin.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/ROLE_ADMIN/my-travel-places")
public class MyTravelPlacesController {

    @Autowired
    private UserService userService;
    @Autowired
    private TravelProductServiceImpl travelProductService;
    @Autowired
    private CountryService countryService;

    /** 내가 등록한 여행지 */
    @GetMapping("")
    public String myTravelPlacesPage(Model model) {
        model.addAttribute("user", userService.getUserData()); // 사용자 정보 담기
        model.addAttribute("products", travelProductService.findAllProductsByUserId()); // 상품 리스트 정보 담기
        return "admin/my_travel/places";
    }

    /**
     * 내가 등록한 여행지 - 검색
     */
    @PostMapping("/search")
    public String SearchCountryProductsListPage(String keyword, Model model) {
        model.addAttribute("user", userService.getUserData()); // 사용자 정보 담기
        model.addAttribute("products", travelProductService.findAllProductsByKeywordAndUserId(keyword)); // 여행 상품 리스트 담기
        return "admin/my_travel/places_search_result";
    }

    /** 여행지 등록 페이지 */
    @GetMapping("/save")
    public String myTravelPlacesPostPage(Model model) {
        model.addAttribute("user", userService.getUserData()); // 사용자 정보 담기
        model.addAttribute("options", countryService.findAllCountries()); // 나라 정보 담기
        return "admin/my_travel/places_post";
    }

    /** 여행지 등록 - post action */
    @PostMapping("/save")
    public ResponseEntity<String> myTravelPlacesPostAction(ProductDto productDto) {
        try {
            travelProductService.saveProduct(productDto);
            return ResponseEntity.ok("여행지를 등록했습니다.");
        } catch (Exception e) {
            System.out.println(e.getMessage());
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).body("여행지 등록에 실패했습니다.");
        }
    }
}
