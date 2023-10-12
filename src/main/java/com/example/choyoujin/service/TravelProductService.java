package com.example.choyoujin.service;

import com.example.choyoujin.dto.ProductDto;

import java.util.List;

public interface TravelProductService {
    List<ProductDto> find4CountriesByCountryLike();
    List<ProductDto> findAllProductsByCountryId(int countryId);
    ProductDto findProductByProductId(int productId);
    String findAllByProductId(int productId);
    List<ProductDto> findAllProductsByCountryIdAndKeyword(int countryId, String keyword);
    List<ProductDto> findAllProductsByUserId();
    List<ProductDto> findAllProductsByKeywordAndUserId(String keyword);
    void saveProduct(ProductDto productDto);
    void plusLike(int productId);
    void plusUnLike(int productId);
    List<ProductDto> findAllByCountryId(int countryId);
    List<Integer> findAllProductIdsByCountryId(int countryId);
}
