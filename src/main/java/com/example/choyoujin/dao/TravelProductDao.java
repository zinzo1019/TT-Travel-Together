package com.example.choyoujin.dao;

import com.example.choyoujin.dto.ProductDto;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface TravelProductDao {
    List<ProductDto> findAllProductsByCountryId(int countryId);
    ProductDto findProductByProductId(int productId);
    List<ProductDto> findAllProductsByCountryIdAndKeyword(int countryId, String keyword);
    List<ProductDto> findAllProductsByUserId(int userId);
    List<ProductDto> findAllProductsByKeywordAndUserId(String keyword, int userId);
    void saveProduct(ProductDto productDto);
    void saveProductDetails(List<String> details, int productId);
    void saveProductTags(List<String> tags, int productId);
    List<ProductDto> findAllProductsByCountryIdAndUserId(int countryId, int userId);
    ProductDto findProductByProductIdAndUserId(int productId, int userId);
    void plusLike(int productId);
    void plusUnLike(int productId);
    List<ProductDto> findAllProductsByCountryIdAndKeywordAndUserId(int countryId, String keyword, int userId);
    List<ProductDto> findAllByCountryId(int countryId);
    List<Integer> findAllProductIdsByCountryId(int countryId);
    List<ProductDto> findAllByUserLike(int userId);
}
