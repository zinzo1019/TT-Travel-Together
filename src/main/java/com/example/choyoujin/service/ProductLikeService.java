package com.example.choyoujin.service;

public interface ProductLikeService {
    void saveProductLike(int productId) throws Exception;
    void deleteProductLike(int productId) throws Exception;
    boolean findLikeByUserIdAndProductId(int userId, int productId);
}
