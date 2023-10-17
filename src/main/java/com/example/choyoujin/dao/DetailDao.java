package com.example.choyoujin.dao;

import com.example.choyoujin.dto.DetailDto;

import java.util.List;

public interface DetailDao {
    List<DetailDto> findAllByProductId(int productId);
    void deleteOneById(int id);
    void deleteAllByProductId(int productId);
}
