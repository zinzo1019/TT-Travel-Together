package com.example.choyoujin.dao;

import com.example.choyoujin.dto.CouponDto;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface CouponDao {
    void saveCoupon(CouponDto couponDto);
    List<CouponDto> findAllByUserId(int userId);
    CouponDto findOneByCouponId(int couponId);
    void updateCoupon(CouponDto couponDto);
    void deleteCoupon(int couponId);
    List<CouponDto> findAllByKeyword(String keyword);
    List<CouponDto> findAllByKeywordAndUserId(String keyword, int userId);
    List<CouponDto> findAll();
}
