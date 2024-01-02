package com.example.choyoujin.controller.adminController;

import com.example.choyoujin.dto.ProductDto;
import com.example.choyoujin.service.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.swing.*;

@Controller
@RequestMapping("/admin/my-travel-places")
public class MyTravelPlacesController {

    @Autowired
    private UserService userService;
    @Autowired
    private TravelProductServiceImpl travelProductService;
    @Autowired
    private CountryService countryService;
    @Autowired
    private DetailService detailService;
    @Autowired
    private TagService tagService;

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

    /** 여행지 수정 페이지 */
    @GetMapping("/modify")
    public String myTravelPlacesModifyPage(@RequestParam("product_id") int productId, Model model) {
        model.addAttribute("user", userService.getUserData()); // 사용자 정보 담기
        model.addAttribute("options", countryService.findAllCountries()); // 나라 정보 담기
        model.addAttribute("product", travelProductService.findProductByProductId(productId)); // 여행 상품 정보 담기
        return "admin/my_travel/places_modify";
    }

    /** 여행지 수정하기 동작 - post action */
    @PostMapping("/modify")
    public ResponseEntity<String> myTravelPlacesModifyAction(ProductDto productDto) {
        try {
            travelProductService.updateProduct(productDto); // 여행 상품 수정
            return ResponseEntity.ok("수정했습니다.");
        } catch (Exception e) {
            System.out.println(e.getMessage());
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).body("수정에 실패했습니다.");
        }
    }

    /** 여행 상품 수정 - 설명 삭제하기 */
    @PostMapping("/delete/description")
    public ResponseEntity<String> deleteDescription(@RequestParam("description_id") int desId) {
        try {
            detailService.deleteOneById(desId); // 설명 삭제
            return ResponseEntity.ok("삭제했습니다.");
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).body("삭제에 실패했습니다.");
        }
    }

    /** 여행 상품 수정 - 태그 삭제하기 */
    @PostMapping("/delete/tag")
    public ResponseEntity<String> deleteTag(@RequestParam("tag_id") int tagId) {
        try {
            tagService.deleteOneById(tagId); // 태그 삭제
            return ResponseEntity.ok("삭제했습니다.");
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).body("삭제에 실패했습니다.");
        }
    }

    /** 여행 상품 판재 여부 수정하기 */
    @PostMapping("/enabled/{enabled}")
    public ResponseEntity<String> stopSellingProduct(@RequestParam("product_id") int productId, @PathVariable("enabled") boolean enabled) {
        try {
            travelProductService.updateEnabledByProductId(productId, enabled);
            return ResponseEntity.ok("판매 여부를 수정했습니다.");
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).body("판매 여부 수정에 실패했습니다.");
        }
    }
}
