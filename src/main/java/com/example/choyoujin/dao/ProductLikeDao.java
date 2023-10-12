package com.example.choyoujin.dao;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface ProductLikeDao {
    void saveProductLike(int productId, int userId);
    void deleteProductLike(int productId, int userId);
    boolean findLikeByUserIdAndProductId(int userId, int productId);
}
