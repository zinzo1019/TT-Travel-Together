package com.example.choyoujin.service;

import com.example.choyoujin.dao.ProductLikeDao;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class ProductLikeServiceImpl implements ProductLikeService {

    @Autowired
    private ProductLikeDao productLikeDao;
    @Autowired
    private UserService userService;
    @Autowired
    private TravelProductServiceImpl productService;

    /**
     * 여행 상품 - 좋아요 저장하기
     */
    @Override
    public void saveProductLike(int productId) throws Exception {
        try {
            productLikeDao.saveProductLike(productId, userService.getUserData().getId()); // 좋아요 저장
            productService.plusLike(productId); // 좋아요 수 늘리기
        } catch (Exception e) {
            throw new Exception("좋아요 저장 중 오류가 발생했습니다.");
        }
    }

    /**
     * 여행 상품 - 좋아요 취소하기
     */
    @Override
    public void deleteProductLike(int productId) throws Exception {
        try {
            productLikeDao.deleteProductLike(productId, userService.getUserData().getId()); // 좋아요 취소
            productService.plusUnLike(productId); // 좋아요 수 줄이기
        } catch (Exception e) {
            throw new Exception("좋아요 취소 중 오류가 발생했습니다.");
        }
    }

    /** 여행 상품별 좋아요 여부 확인 */
    @Override
    public boolean findLikeByUserIdAndProductId(int userId, int productId) {
        return productLikeDao.findLikeByUserIdAndProductId(userId, productId);
    }
}
