package com.example.choyoujin.service;

import com.example.choyoujin.dto.ProductDto;
import com.example.choyoujin.dto.ProductsByTagDto;
import org.springframework.data.domain.PageImpl;
import org.springframework.ui.Model;

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
    void updateEnabledByProductId(int productId, boolean enabled);
    void plusLike(int productId);
    void plusUnLike(int productId);
    void updateProduct(ProductDto productDto);
    List<ProductDto> findAllByCountryId(int countryId);
    List<Integer> findAllProductIdsByCountryId(int countryId);
    List<ProductDto> findAllByUserLike();
    List<ProductDto> findProductsTop4ByLike();
    PageImpl<ProductDto> findAllByTravelTag(int page, int size);
    PageImpl<ProductDto> findAllByTravelTag(String tag, int page, int size);
    List<ProductsByTagDto> findAllByTravelTags(int page, int size);
    List<ProductDto> findAllByKeyword(String keyword);
    PageImpl<ProductDto> findAllByTravelTagsWithPaging(int tagId, int page, int size, Model model);
    PageImpl<ProductDto> findAllByTravelTagAndKeyword(String tag, String keyword, int page, int size);
    PageImpl<ProductDto> findAllProducts(int page, int size);
}
