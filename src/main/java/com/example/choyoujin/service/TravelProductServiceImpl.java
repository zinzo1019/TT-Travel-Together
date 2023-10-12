package com.example.choyoujin.service;

import com.example.choyoujin.dao.*;
import com.example.choyoujin.dto.ProductDto;
import com.example.choyoujin.dto.DetailDto;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class TravelProductServiceImpl implements TravelProductService {

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
    @Autowired
    private ProductLikeServiceImpl likeService;

    /** 최근 뜨는 여행지 4개 (좋아요 순으로 정렬) */
    public List<ProductDto> find4CountriesByCountryLike() {
        return countryDao.find4CountriesByCountryLike();
    }

    /** 나라별 여행 상품 리스트 가져오기 */
    public List<ProductDto> findAllProductsByCountryId(int countryId) {
        List<ProductDto> productDtos = travelProductDao.findAllProductsByCountryId(countryId);
        if (userService.getUserData() != null) { // 로그인 상태라면
            // todo 상품별 좋아요 여부 확인
            for (ProductDto dto : productDtos) {
                dto.setUserLiked(likeService.findLikeByUserIdAndProductId(userService.getUserData().getId(), dto.getId()));
            }
        }
        for (ProductDto dto : productDtos) {
            dto.setDescriptions(findAllByProductId(dto.getId())); // 설명 Set
            dto.setTags(tagDao.findAllByProductId(dto.getId())); // 태그 set
        }
        return productDtos;
    }

    /** 여행 상품 아이디로 상품 데이터 가져오기 */
    public ProductDto findProductByProductId(int productId) {
        boolean isLiked = false;
        ProductDto dto = travelProductDao.findProductByProductId(productId);
        if (userService.getUserData() != null) { // 로그인 후
            // todo 좋아요 여부 확인
            isLiked = likeService.findLikeByUserIdAndProductId(userService.getUserData().getId(), productId);
            dto.setUserLiked(isLiked);
        }
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
        List<ProductDto> productDtos = null;
        if (userService.getUserData() != null) { // 로그인 상태라면
            productDtos = travelProductDao.findAllProductsByCountryIdAndKeywordAndUserId(countryId, keyword, userService.getUserData().getId());
        } else
            productDtos = travelProductDao.findAllProductsByCountryIdAndKeyword(countryId, keyword);
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
        return travelProductDao.findAllProductsByKeywordAndUserId(keyword, userService.getUserData().getId());
    }

    /** 여행 상품 등록하기 */
    public void saveProduct(ProductDto productDto) {
        travelProductDao.saveProduct(productDto); // 여행 상품 저장
        if (!productDto.getStringDetailDescriptions().isEmpty())
            travelProductDao.saveProductDetails(productDto.getStringDetailDescriptions(), productDto.getId()); // 설명 저장
        if (!productDto.getStringTags().isEmpty())
            travelProductDao.saveProductTags(productDto.getStringTags(), productDto.getId()); // 태그 저장
    }

    /** 좋아요 1 증가 */
    @Override
    public void plusLike(int productId) {
        travelProductDao.plusLike(productId);
    }

     /** 좋아요 1 감소 */
    @Override
    public void plusUnLike(int productId) {
        travelProductDao.plusUnLike(productId);
    }

    /** 나라 아이디로 여행 상품 리스트 가져오기 */
    @Override
    public List<ProductDto> findAllByCountryId(int countryId) {
        return travelProductDao.findAllByCountryId(countryId);
    }

    /** 나라 아이디로 여행 상품 아이디 리스트 가져오기 */
    @Override
    public List<Integer> findAllProductIdsByCountryId(int countryId) {
        return travelProductDao.findAllProductIdsByCountryId(countryId);
    }
}
