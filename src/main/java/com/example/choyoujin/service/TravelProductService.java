package com.example.choyoujin.service;

import com.example.choyoujin.dao.*;
import com.example.choyoujin.dto.CommentDto;
import com.example.choyoujin.dto.ProductDto;
import com.example.choyoujin.dto.DetailDto;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class TravelProductService {

    @Autowired
    private TravelProductDao travelProductDao;
    @Autowired
    private CountryDao countryDao;
    @Autowired
    private DetailDao detailDao;
    @Autowired
    private TagDao tagDao;
    @Autowired
    private UserService userService;

    /** 최근 뜨는 여행지 4개 (좋아요 순으로 정렬) */
    public List<ProductDto> find4CountriesByCountryLike() {
        return countryDao.find4CountriesByCountryLike();
    }

    /** 나라별 여행 상품 리스트 가져오기 */
    public List<ProductDto> findAllProductsByCountryId(int countryId) {
        List<ProductDto> productDtos = travelProductDao.findAllProductsByCountryId(countryId);
        for (ProductDto dto : productDtos) {
            dto.setDescriptions(findAllByProductId(dto.getId())); // 설명 Set
            dto.setTags(tagDao.findAllByProductId(dto.getId())); // 태그 set
        }
        return productDtos;
    }

    /** 여행 상품 아이디로 상품 데이터 가져오기 */
    public ProductDto findProductByProductId(int productId) {
        ProductDto dto = travelProductDao.findProductByProductId(productId);
        dto.setDescriptions(findAllByProductId(dto.getId())); // 설명 Set
        dto.setTags(tagDao.findAllByProductId(dto.getId())); // 태그 set
        return dto;
    }

    /** 여행 상품별 설명 리스트 가져오기 & 설명 이어 붙이기 */
    public String findAllByProductId(int productId) {
        List<DetailDto> detailDtos = detailDao.findallByProductId(productId);
        String tags = "";
        for (int i = 0; i < detailDtos.size(); i++) { // 태그 이어붙이기
                tags += " + ";
            tags += detailDtos.get(i).getDescription();
        }
        return tags;
    }

    /** 여행지 검색하기 */
    public List<ProductDto> findAllProductsByCountryIdAndKeyword(int countryId, String keyword) {
        List<ProductDto> productDtos = travelProductDao.findAllProductsByCountryIdAndKeyword(countryId, keyword);
        for (ProductDto dto : productDtos) {
            dto.setDescriptions(findAllByProductId(dto.getId())); // 설명 Set
            dto.setTags(tagDao.findAllByProductId(dto.getId())); // 태그 set
        }
        return productDtos;
    }

    /** 내가 등록한 여행지 - 여행 상품 리스트 가져오기 */
    public List<ProductDto> findAllProductsByUserId() {
        return travelProductDao.findAllProductsByUserId(userService.getUserData().getId());
    }

    /** 내가 등록한 여행지 - 검색 */
    public List<ProductDto> findAllProductsByKeywordAndUserId(String keyword) {
        if (keyword == "")
            return travelProductDao.findAllProductsByUserId(userService.getUserData().getId());
        return travelProductDao.findAllProductsByKeywordAndUserId(keyword);
    }

    /** 여행 상품 등록하기 */
    public void saveProduct(ProductDto productDto) {

        // TODO stringPlus 저장하기
        //  테이블명 table_product_detail

        // TODO stringTags 저장하기
        //  테이블명 travel_product_tag


        travelProductDao.saveProduct(productDto);
    }
}
