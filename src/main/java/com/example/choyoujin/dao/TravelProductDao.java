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
    void saveProductTags(List<Integer> tags, int productId);
    void plusLike(int productId);
    void plusUnLike(int productId);
    List<ProductDto> findAllByCountryId(int countryId);
    List<Integer> findAllProductIdsByCountryId(int countryId);
    List<ProductDto> findAllByUserLike(int userId);
    List<ProductDto> findAllByTravelTag(String travelTag, int start, int size);
    List<ProductDto> findProductsTop4ByLike();
    List<ProductDto> findAllByKeyword(String keyword);
    int countAllByTravelTag(String travelTag);
    List<ProductDto> findAllByTravelTagId(int tagId, int page, int size);
    int countAllByTravelTagId(int tagId);
    void updateProduct(ProductDto productDto);
    void updateEnabledByProductId(int productId, boolean enabled);
    List<ProductDto> findAllByTravelTagAndKeyword(String tag, String keyword, int start, int size);
    List<ProductDto> findAllByTravelTags(String tag, int page, int size);
    int countAllByTravelTagAndKeyword(String tag, String keyword);
}
