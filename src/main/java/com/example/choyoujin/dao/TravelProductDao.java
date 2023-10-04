package com.example.choyoujin.dao;

import com.example.choyoujin.dto.ProductDto;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface TravelProductDao {
    List<ProductDto> findAllProductsByCountryId(int countryId);
    ProductDto findProductByProductId(int productId);
    List<ProductDto> findAllProductsByCountryIdAndKeyword(int countryId, String keyword);
}
