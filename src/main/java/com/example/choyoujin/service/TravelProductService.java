package com.example.choyoujin.service;

import com.example.choyoujin.dao.CountryDao;
import com.example.choyoujin.dao.DetailDao;
import com.example.choyoujin.dao.TagDao;
import com.example.choyoujin.dao.TravelProductDao;
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

    public List<ProductDto> findAllProductsByCountryIdAndKeyword(int countryId, String keyword) {
        List<ProductDto> productDtos = travelProductDao.findAllProductsByCountryIdAndKeyword(countryId, keyword);
        for (ProductDto dto : productDtos) {
            dto.setDescriptions(findAllByProductId(dto.getId())); // 설명 Set
            dto.setTags(tagDao.findAllByProductId(dto.getId())); // 태그 set
        }
        return productDtos;
    }
}
