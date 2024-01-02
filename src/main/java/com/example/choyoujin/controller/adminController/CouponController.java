package com.example.choyoujin.controller.adminController;

import com.example.choyoujin.dto.CouponDto;
import com.example.choyoujin.dto.ProductDto;
import com.example.choyoujin.dto.SearchDto;
import com.example.choyoujin.service.CouponService;
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
import org.springframework.web.bind.annotation.RequestParam;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/admin/coupon")
public class CouponController {

    @Autowired
    private UserService userService;
    @Autowired
    private CountryService countryService;
    @Autowired
    private TravelProductServiceImpl productService;
    @Autowired
    private CouponService couponService;

    /**
     * 모든 쿠폰 가져오기
     */
    @GetMapping("/all")
    public String allCouponPage(Model model) {
        model.addAttribute("user", userService.getUserData()); // 사용자 정보 담기
        model.addAttribute("coupons", couponService.findAll()); // 쿠폰 리스트 담기
        return "admin/coupon/all_coupon";
    }

    /**
     * 내 쿠폰 가져오기
     */
    @GetMapping("/my")
    public String myCouponPage(Model model) {
        model.addAttribute("user", userService.getUserData()); // 사용자 정보 담기
        model.addAttribute("coupons", couponService.findAllByUserId()); // 쿠폰 리스트 담기
        return "admin/coupon/my_coupon";
    }

    /**
     * 쿠폰 저장하기 페이지
     */
    @GetMapping("/save")
    public String saveCouponPage(Model model) {
        model.addAttribute("user", userService.getUserData()); // 사용자 정보 담기
        model.addAttribute("countries", countryService.findAllCountries()); // 나라 정보 담기
        return "admin/coupon/save_coupon";
    }

    /** 쿠폰 저장하기 - post action */
    @PostMapping("/save")
    public ResponseEntity<String> saveCouponAction(CouponDto couponDto) {
        try {
            couponService.saveCoupon(couponDto);
            return ResponseEntity.ok("쿠폰을 등록했습니다.");
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).body("쿠폰 등록에 실패했습니다.");
        }
    }

    /**
     * 나라 아이디에 따른 여행 상품 리스트 가져오기 - <select></select>
     */
    @PostMapping("/countrySelect/action")
    public ResponseEntity<Map<String, List<ProductDto>>> countrySelectAction(@RequestParam("countryId") int countryId) {
        List<ProductDto> products = productService.findAllByCountryId(countryId); // 나라 아이디에 따른 여행 상품 리스트
        Map<String, List<ProductDto>> response = new HashMap<>();
        response.put("products", products);
        return new ResponseEntity<>(response, HttpStatus.OK);
    }

    /** 쿠폰 수정하기 페이지 */
    @GetMapping("/update")
    public String modifyCouponPage(@RequestParam("coupon_id") int couponId, Model model) {
        model.addAttribute("user", userService.getUserData()); // 사용자 정보 담기
        model.addAttribute("countries", countryService.findAllCountries()); // 나라 정보 담기
        model.addAttribute("coupon", couponService.findOneByCouponId(couponId));
        return "admin/coupon/modify_coupon";
    }

    /** 쿠폰 수정하기 - post action */
    @PostMapping("/update")
    public ResponseEntity<String> updateCouponAction(CouponDto couponDto) {
        try {
            couponService.updateCoupon(couponDto);
            return ResponseEntity.ok("쿠폰을 수정했습니다.");
        } catch (Exception e) {
            System.out.println(e.getMessage());
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).body("쿠폰 수정에 실패했습니다.");
        }
    }

    /** 쿠폰 삭제하기 */
    @PostMapping("/delete")
    public ResponseEntity<String> deleteCouponAction(@RequestParam("coupon_id") int couponId) {
        try {
            couponService.deleteCoupon(couponId);
            return ResponseEntity.ok("쿠폰을 삭제했습니다.");
        } catch (Exception e) {
            System.out.println(e.getMessage());
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).body("쿠폰 삭제에 실패했습니다.");
        }
    }

    /**
     * 모든 쿠폰 - 검색하기
     */
    @PostMapping("/all/search")
    public String searchCoupons(String keyword, Model model) {
        model.addAttribute("user", userService.getUserData()); // 사용자 정보 담기
        model.addAttribute("coupons", couponService.findAllByKeyword(keyword)); // 검색 결과 담기
        return "admin/coupon/coupon_search_result";
    }

    /**
     * 나의 쿠폰 - 검색하기
     */
    @PostMapping("/my/search")
    public String searchMyCoupons(String keyword, Model model) {
        model.addAttribute("user", userService.getUserData()); // 사용자 정보 담기
        model.addAttribute("coupons", couponService.findAllByKeywordAndUserId(keyword)); // 검색 결과 담기
        return "admin/coupon/my_coupon_search_result";
    }
}
