package com.example.choyoujin.service;

import com.example.choyoujin.dao.*;
import com.example.choyoujin.dto.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.PageImpl;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import static com.example.choyoujin.service.FileService.decompressBytes;

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
    @Autowired
    private FileService fileService;
    @Autowired
    private CouponService couponService;
    @Autowired
    private TravelTagsDao tagsDao;
    @Autowired
    private PaymentServiceImpl paymentService;

    /**
     * 최근 뜨는 여행지 4개 (좋아요 순으로 정렬)
     */
    public List<ProductDto> find4CountriesByCountryLike() {
        return countryDao.find4CountriesByCountryLike();
    }

    /**
     * 나라별 여행 상품 리스트 가져오기
     */
    public List<ProductDto> findAllProductsByCountryId(int countryId) {
        List<ProductDto> productDtos = travelProductDao.findAllProductsByCountryId(countryId);
        setImage(productDtos); // 이미지 Set
        setUserLiked(productDtos); // 좋아요 Set
        for (ProductDto dto : productDtos) {
            dto.setDescriptions(findAllByProductId(dto.getTravelProductId())); // 설명 Set
            dto.setTags(tagDao.findAllByProductId(dto.getTravelProductId())); // 태그 set
        }
        return productDtos;
    }

    /**
     * 여행 상품 아이디로 상품 데이터 가져오기
     */
    public ProductDto findProductByProductId(int productId) {
        boolean isLiked = false;
        ProductDto dto = travelProductDao.findProductByProductId(productId);
        if (userService.getUserData() != null) { // 로그인 후
            isLiked = likeService.findLikeByUserIdAndProductId(userService.getUserData().getUserId(), productId);
            dto.setUserLiked(isLiked);
        }
        dto.setEncoding(decompressBytes(dto.getPicByte())); // 이미지 Set
        dto.setDetailDescriptions(detailDao.findAllByProductId(dto.getTravelProductId())); // 설명 리스트 Set
        dto.setDescriptions(findAllByProductId(dto.getTravelProductId())); // 설명 Set
//        dto.setTags(tagDao.findAllByProductId(dto.getTravelProductId())); // 태그 리스트 Set
        dto.setTags(tagDao.findAllByProductId(dto.getTravelProductId())); // 태그 set
        dto.setCoupons(couponService.findAllByProductId(productId)); // 쿠폰 리스트 Set
        return dto;
    }

    /**
     * 여행 상품별 설명 리스트 가져오기 & 설명 이어 붙이기
     */
    public String findAllByProductId(int productId) {
        List<DetailDto> detailDtos = detailDao.findAllByProductId(productId);
        String tags = "";
        for (int i = 0; i < detailDtos.size(); i++) { // 태그 이어붙이기
            tags += " + ";
            tags += detailDtos.get(i).getDescription();
        }
        return tags;
    }

    /**
     * 여행지 검색하기
     */
    public List<ProductDto> findAllProductsByCountryIdAndKeyword(int countryId, String keyword) {
        List<ProductDto> productDtos = travelProductDao.findAllProductsByCountryIdAndKeyword(countryId, keyword);
        setImage(productDtos); // 이미지 Set
        setUserLiked(productDtos); // 좋아요 Set
        for (ProductDto dto : productDtos) {
            dto.setDescriptions(findAllByProductId(dto.getTravelProductId())); // 설명 Set
            dto.setTags(tagDao.findAllByProductId(dto.getTravelProductId())); // 태그 set
        }
        return productDtos;
    }

    /**
     * 내가 등록한 여행지 - 여행 상품 리스트 가져오기
     */
    public List<ProductDto> findAllProductsByUserId() {
        List<ProductDto> productDtos = travelProductDao.findAllProductsByUserId(userService.getUserData().getUserId());
        setImage(productDtos); // 이미지 Set
        setUserLiked(productDtos); // 좋아요 Set
        return productDtos;
    }

    /**
     * 내가 등록한 여행지 - 검색
     */
    public List<ProductDto> findAllProductsByKeywordAndUserId(String keyword) {
        List<ProductDto> productDtos = new ArrayList<>();
        if (keyword == "")
            productDtos = travelProductDao.findAllProductsByUserId(userService.getUserData().getUserId()); // 빈칸 검색
        productDtos = travelProductDao.findAllProductsByKeywordAndUserId(keyword, userService.getUserData().getUserId()); // 키워드 검색
        setImage(productDtos); // 이미지 Set
        setUserLiked(productDtos); // 좋아요 Set
        return productDtos;
    }

    /**
     * 여행 상품 저장하기
     */
    public void saveProduct(ProductDto productDto) {
        int imageId = saveImageAndGetImageId(productDto); // 이미지 저장
        productDto.setImageId(imageId); // 이미지 아이디 Set
        travelProductDao.saveProduct(productDto); // 여행 상품 저장
        if (!productDto.getStringDetailDescriptions().isEmpty())
            travelProductDao.saveProductDetails(productDto.getStringDetailDescriptions(), productDto.getTravelProductId()); // 설명 저장
        saveTags(productDto); // 태그 저장
    }

    /**
     * 여행 상품 수정하기
     */
    @Override
    public void updateProduct(ProductDto productDto) {
        try {
            if (!productDto.getStringDetailDescriptions().isEmpty())
                travelProductDao.saveProductDetails(productDto.getStringDetailDescriptions(), productDto.getTravelProductId()); // 설명 저장
            if (!productDto.getStringTags().isEmpty())
                saveTags(productDto); // 태그 저장
            if (productDto.getImage() != null)
                fileService.updateProductImage(productDto.getTravelProductId(), productDto.getImage()); // 이미지 수정
            travelProductDao.updateProduct(productDto); // 여행 상품 수정
        } catch (Exception e) {
            System.out.println(e.getMessage());
        }
    }

    /**
     * 나라 아이디로 여행 상품 리스트 가져오기
     */
    @Override
    public List<ProductDto> findAllByCountryId(int countryId) {
        return travelProductDao.findAllByCountryId(countryId);
    }

    /**
     * 나라 아이디로 여행 상품 아이디 리스트 가져오기
     */
    @Override
    public List<Integer> findAllProductIdsByCountryId(int countryId) {
        return travelProductDao.findAllProductIdsByCountryId(countryId);
    }

    /**
     * 사용자가 좋아요한 여행 상품 리스트 가져오기
     */
    @Override
    public List<ProductDto> findAllByUserLike() {
        List<ProductDto> productDtos = travelProductDao.findAllByUserLike(userService.getUserData().getUserId());
        setImage(productDtos); // 이미지 Set
        setUserLiked(productDtos); // 좋아요 Set
        for (ProductDto dto : productDtos) {
            dto.setDescriptions(findAllByProductId(dto.getTravelProductId())); // 설명 Set
            dto.setTags(tagDao.findAllByProductId(dto.getTravelProductId())); // 태그 set
        }
        return productDtos;
    }

    /**
     * 여행 태그별 여행 상품 리스트 가져오기
     */
    public PageImpl<ProductDto> findAllByTravelTag(int page, int size) {
        int start = (page - 1) * size;
        String travelTag = "힐링";
        if (userService.getUserData() != null) { // 로그인 후
            travelTag = userService.getUserData().getTravelTag(); // 사용자 여행 태그 가져오기
        }
        int total = travelProductDao.countAllByTravelTag(travelTag); // 여행 상품 개수
        List<ProductDto> productDtos = travelProductDao.findAllByTravelTag(travelTag, start, size);
        setImage(productDtos); // 이미지 Set
        return new PageImpl<>(productDtos, org.springframework.data.domain.PageRequest.of(page - 1, size), total);
    }

    /**
     * 여행 태그별 여행 상품 리스트 - 페이징 처리
     */
    @Override
    public PageImpl<ProductDto> findAllByTravelTag(String tag, int page, int size) {
        int start = (page - 1) * size;
        int total = travelProductDao.countAllByTravelTag(tag); // 여행 상품 개수
        List<ProductDto> productDtos = travelProductDao.findAllByTravelTag(tag, start, size);
        setImage(productDtos); // 이미지 Set
        return new PageImpl<>(productDtos, org.springframework.data.domain.PageRequest.of(page - 1, size), total);
    }

    /**
     * 상위 4개 여행 상품 리스트 가져오기
     */
    @Override
    public List<ProductDto> findProductsTop4ByLike() {
        List<ProductDto> productDtos = travelProductDao.findProductsTop4ByLike();
        return setImage(productDtos); // 이미지 Set
    }

    /**
     * 여행 태그별 여행 상품 리스트 가져오기
     */
    @Override
    public List<ProductsByTagDto> findAllByTravelTags(int page, int size) {
        List<ProductsByTagDto> productDtos = new ArrayList<>();
        List<TagDto> tagDtos = tagsDao.findAllTags(); // 모든 태그 가져오기
        for (TagDto dto : tagDtos) {
            List<ProductDto> productDtoList = travelProductDao.findAllByTravelTags(dto.getTag(), page, size);
            setImage(productDtoList); // 이미지 Set
            Pagination pagination = getPagination(); // 페이징 처리
            pagination.setTotalCount(travelProductDao.countAllByTravelTag(dto.getTag())); // 여행 상품 개수
            productDtos.add(new ProductsByTagDto(dto.getTagId(), dto.getTag(), productDtoList, pagination)); // 여행 상품 리스트
        }
        return productDtos;
    }

    /**
     * 모든 여행 - 검색하기
     */
    @Override
    public List<ProductDto> findAllByKeyword(String keyword) {
        List<ProductDto> productDtos = setImage(travelProductDao.findAllByKeyword(keyword));// 이미지 Set
        for (ProductDto dto : productDtos) {
            dto.setDescriptions(findAllByProductId(dto.getTravelProductId())); // 설명 Set
            dto.setTags(tagDao.findAllByProductId(dto.getTravelProductId())); // 태그 set
        }
        return productDtos;
    }

    /**
     * 태그 아이디로 여행 상품 리스트 찾기 - 태그별 여행 상품 페이징 처리
     */
    @Override
    public PageImpl<ProductDto> findAllByTravelTagsWithPaging(int tagId, int page, int size, Model model) {
        int start = (page - 1) * size;
        List<ProductDto> productDtos = travelProductDao.findAllByTravelTagId(tagId, start, size);
        setImage(productDtos); // 이미지 Set
        model.addAttribute("tagId", tagId); // 페이징 담기
        int total = travelProductDao.countAllByTravelTagId(tagId); // 여행 상품 개수
        return new PageImpl<>(productDtos, org.springframework.data.domain.PageRequest.of(page - 1, size), total);
    }

    /**
     * 태그와 검색어로 여행 상품 가져오기
     */
    @Override
    public PageImpl<ProductDto> findAllByTravelTagAndKeyword(String tag, String keyword, int page, int size) {
        int start = (page - 1) * size;
        int total = travelProductDao.countAllByTravelTagAndKeyword(tag, keyword); // 여행 상품 개수
        List<ProductDto> productDtos = travelProductDao.findAllByTravelTagAndKeyword(tag, keyword, start, size);
        setImage(productDtos); // 이미지 Set
        return new PageImpl<>(productDtos, org.springframework.data.domain.PageRequest.of(page - 1, size), total);
    }

    /**
     * 모든 여행 상품 리스트 가져오기 - 페이징 처리
     */
    @Override
    public PageImpl<ProductDto> findAllProducts(int page, int size) {
        int start = (page) * size;
        int total = travelProductDao.countAllProducts() - 4; // 여행 상품 개수
        List<ProductDto> productDtos = travelProductDao.findAllProductsWithPaging(start, size);
        setImage(productDtos); // 이미지 Set
        return new PageImpl<>(productDtos, org.springframework.data.domain.PageRequest.of(page - 1, size), total);
    }

    /**
     * 여행 상품 판매 중지하기
     */
    @Override
    public void updateEnabledByProductId(int productId, boolean enabled) {
        travelProductDao.updateEnabledByProductId(productId, enabled); // 판매 여부 수정
        paymentService.updateEnabledByProductId(productId, enabled); // 결제건 사용 가능 여부 수정
    }

    /**
     * 여행 상품 이미지 저장하기
     */
    private int saveImageAndGetImageId(ProductDto productDto) {
        int imageId = 0;
        try {
            if (!productDto.getImage().isEmpty())
                imageId = fileService.saveProductImage(productDto.getImage());// 이미지 저장
        } catch (IOException e) {
            System.out.println("이미지 업로드를 실패했습니다.");
        }
        return imageId;
    }

    /**
     * 태그들 저장하기
     */
    private void saveTags(ProductDto productDto) {
        List<Integer> tags = new ArrayList<>();
        if (!productDto.getStringTags().isEmpty()) {
            saveNewTag(productDto.getStringTags()); // travel_tags 저장
            for (String tag : productDto.getStringTags())
                tags.add(tagsDao.findOneByTag(tag).getTagId()); // 태그 아이디 리스트 가져오기
            travelProductDao.saveProductTags(tags, productDto.getTravelProductId()); // travel_product_tag 저장
        }
    }

    /**
     * 새 태그를 travel_tags에 저장
     */
    private void saveNewTag(List<String> tags) {
        List<String> dbTags = new ArrayList<>();
        List<String> newTags = new ArrayList<>();
        for (TagDto dto : tagsDao.findAllTags())
            dbTags.add(dto.getTag()); // db 내 태그들
        for (String tag : tags) { // db에 이미 저장된 태그인지 검사
            if (!dbTags.contains(tag))
                newTags.add(tag);
        }
        if (newTags != null && !newTags.isEmpty()) // 새 태그라면
            tagsDao.saveTags(newTags); // db에 저장
    }

    /**
     * 좋아요 1 증가
     */
    @Override
    public void plusLike(int productId) {
        travelProductDao.plusLike(productId);
    }

    /**
     * 좋아요 1 감소
     */
    @Override
    public void plusUnLike(int productId) {
        travelProductDao.plusUnLike(productId);
    }

    /**
     * 사용자가 좋아요 한 상품 여부에 따라 userLiked Set
     */
    private void setUserLiked(List<ProductDto> productDtos) {
        if (userService.getUserData() != null) { // 로그인 상태라면
            for (ProductDto dto : productDtos) {
                dto.setUserLiked(likeService.findLikeByUserIdAndProductId(userService.getUserData().getUserId(), dto.getTravelProductId()));
            }
        }
    }

    /**
     * 여행 상품 이미지 압축 해제하기
     */
    public static List<ProductDto> setImage(List<ProductDto> productDtos) {
        for (ProductDto dto : productDtos) {
            dto.setEncoding(decompressBytes(dto.getPicByte()));
        }
        return productDtos;
    }

    /**
     * Pagination 생성
     */
    public Pagination getPagination() {
        Pagination pagination = new Pagination();
        pagination.setPageRequest(new PageRequest());
        return pagination;
    }
}
